//
//  CBPerlObject.m
//  Camel Bones - a bare-bones Perl bridge for Objective-C
//  Originally written for ShuX
//
//  Copyright (c) 2002 Sherm Pendley. All rights reserved.

#ifdef GNUSTEP
#import <objc/objc-api.h>
#else
#import <objc/runtime.h>
#endif

#import <Foundation/Foundation.h>
#import "CBPerlHash.h"
#import "CBPerlHashInternals.h"
#import "CBPerlObject.h"
#import "CBPerl.h"
#import "Conversions_real.h"
#import "PerlMethods_real.h"

@interface NSMethodSignature(HiddenStuffInFoundation)
+ signatureWithObjCTypes:(const char *)fp12;
@end

@implementation CBPerlObject

// Returns an autoreleased handle to a Perl object named varName.
// Returns nil of no such object exists.
+ (CBPerlObject *) namedObject: (NSString *)varName {
    CBPerlObject *newObject = [[CBPerlObject alloc] initNamedObject: varName];
    if (newObject != nil) {
        [newObject autorelease];
    }
    return newObject;
}

// Returns an autoreleased handle to a Perl object named varName, creating a
// new object if necessary of the class className.
// Returns nil if the named object does not exist, and could not be created
+ (CBPerlObject *) namedObject: (NSString *)varName ofClass: (NSString *)newClassName {
    CBPerlObject *newObject = [[CBPerlObject alloc] initNamedObject: varName ofClass: newClassName];
    if (newObject != nil) {
        [newObject autorelease];
    }
    return newObject;
}

#ifdef OBJC2_UNAVAILABLE
struct objc_method_description methodDescriptionForSelector(Class cls, SEL sel) {
	NSCParameterAssert(cls);

	struct objc_method_description desc;

	// Try the class hierarchy.
	Class class = cls;
	do {
		unsigned int count = 0;
		Protocol * __unsafe_unretained * list = class_copyProtocolList(class, &count);
		for (NSUInteger i = 0; i < count; i++) {

			// Matches among required methods.
			desc = protocol_getMethodDescription(list[i], sel, YES, !class_isMetaClass(class));
			if (desc.name != NULL) {
				return desc;
			}

			// Matches among optional methods.
			desc = protocol_getMethodDescription(list[i], sel, NO, !class_isMetaClass(class));
			if (desc.name != NULL) {
				return desc;
			}
		}
		free(list);
	} while ((class = [class superclass]));

	// Fallback: The instance method may still exist in the class even if the object doesn't declare
	// conformance or the runtime doesn't believe us.
	Method meth = class_getInstanceMethod(cls, sel);
	if (meth != NULL) {
		return *method_getDescription(meth);
	}

	// Otherwise bad things.
	desc.name = NULL;
	desc.types = (char *)NULL;
	return desc;
}
#endif


// Returns a handle to a Perl object named varName.
// Returns nil of no such object exists.
- (CBPerlObject *) initNamedObject: (NSString *)varName {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;


    // Get the named SV
    SV *obj = get_sv([varName UTF8String], FALSE);

    // Is it an object reference?
    if (obj && sv_isobject(obj)) {
        SV *deref;
        HV *stash;
        char *packageName;

        // Store the object reference
        _mySV = obj;

        // Increment the reference count to keep Perl from releasing it
        SvREFCNT_inc((SV *)_mySV);

        // Find the class name
        deref = SvRV((SV *)_mySV);
        stash = SvSTASH(deref);
        packageName = HvNAME(stash);
        className = [[NSString alloc] initWithUTF8String: packageName];

        return self;
    }

    return nil;
}

// Returns a handle to a Perl object named varName, creating a
// new object if necessary of the class className.
// Returns nil if the named object does not exist, and could not be created
- (CBPerlObject *) initNamedObject: (NSString *)varName ofClass: (NSString *)newClassName {
    // Build a constructor and eval it
    NSString *construct = [NSString stringWithFormat: @"$%@ = new %@;", varName, newClassName];
    [[CBPerl sharedPerl] eval: construct];
    return [self initNamedObject: varName];
}

// Check for named properties, and get/set their values
- (BOOL) hasProperty: (NSString *)propName {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    if (SvTYPE((SV*)_myHV) == SVt_PVAV) {
        return FALSE;
    }

    if (hv_exists((HV*)_myHV, [propName UTF8String], (I32)[propName length])) {
        return TRUE;
    } else {
        return FALSE;
    }
}

- (id) getProperty: (NSString *)propName {
	SV** propPointer;

    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    if (SvTYPE((SV*)_myHV) == SVt_PVAV) {
        return nil;
    }

    propPointer = hv_fetch((HV*)_myHV, [propName UTF8String], (I32)[propName length], 0);
    if (propPointer) {
        return CBDerefSVtoID((SV*) *propPointer);
    } else {
        return nil;
    }
}

- (void) setProperty: (NSString *)propName toObject: (id)propValue {
	SV *propSV;

    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    if (SvTYPE((SV*)_myHV) == SVt_PVAV) {
        return;
    }

    propSV = CBDerefIDtoSV(propValue);
    hv_store((HV*)_myHV, [propName UTF8String], (I32)[propName length], propSV, 0);
}

- (void) dealloc {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    [className release];
    if (_mySV)
        SvREFCNT_dec((SV *)_mySV);
    [super dealloc];
}

- (NSString *) perlClassName {
    return [[className copy] autorelease];
}

- (BOOL) respondsToSelector: (SEL)aSelector {
    NSString *perlSelector = CBGetMethodNameForSelector(_mySV, aSelector);
    NSString *selString = NSStringFromSelector(aSelector);

    // If there's a real Perl method, return TRUE
    if (perlSelector != nil) {
        return TRUE;

    // If this is of the form setProperty:, and "Property" is a valid property name, return true
    } else if ([selString hasPrefix: @"set"]) {
        NSString *ms;
        NSRange propRange = NSMakeRange(3, [selString length] - 4);
        ms = [selString substringWithRange: propRange];
        if ([self hasProperty: ms]) {
            return TRUE;
        }

    } else if ([self hasProperty:selString]) {
        return TRUE;

    } else {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowSelectorNotFoundMessages"]) {
            NSLog(@"Selector not found: %@", selString);
        }
        return FALSE;
    }

    return FALSE;
}

- (NSMethodSignature *) methodSignatureForSelector: (SEL)aSelector {
#ifdef GNUSTEP
    Method_t m;
    const char *cEncoding;
#else
    Method m;
    char *cEncoding;
#endif
    NSString *selectorString;
    NSString *argEncoding;
    NSString *returnEncoding;
    NSMutableString *encoding;
    
    // Initialize variables to silence warnings
    argEncoding = nil;
    returnEncoding = nil;

    // This gets called for methods already defined in Objective-C, too, so check
    // for that before trying to find a Perl method.
#ifdef GNUSTEP
    m = class_get_instance_method(self->isa, aSelector);
#else
#ifdef OBJC2_UNAVAILABLE
    m = class_getInstanceMethod(object_getClass(self), aSelector);
#else
    m = class_getInstanceMethod(self->isa, aSelector);
#endif
#endif
    if (m) {
#ifdef OBJC2_UNAVAILABLE
        struct objc_method_description methodDesc = methodDescriptionForSelector(object_getClass(self), aSelector);
        cEncoding = methodDesc.types;
        encoding = [NSMutableString stringWithUTF8String: cEncoding];
#else
        cEncoding = m->method_types;
        encoding = [NSString stringWithUTF8String: cEncoding];
#endif
    } else {

        selectorString = NSStringFromSelector(aSelector);
        if (CBGetMethodNameForSelector(_mySV, aSelector)) {
            argEncoding = CBGetMethodArgumentSignatureForSelector(_mySV, aSelector);
            returnEncoding = CBGetMethodReturnSignatureForSelector(_mySV, aSelector);
        } else {
            if ([selectorString hasPrefix: @"set"] && [selectorString hasSuffix: @":"]) {
                argEncoding = @"@";
                returnEncoding = @"v";
            } else if ([self hasProperty: selectorString]) {
                argEncoding = @"";
                returnEncoding = @"@";
            }
        }

    }

    encoding = [NSMutableString stringWithString: returnEncoding];
    [encoding appendString: @"@:"];
    [encoding appendString: argEncoding];

    return [NSMethodSignature signatureWithObjCTypes: [encoding UTF8String]];
}

// Key-Value Coding/Observing methods
- (id) valueForKey: (NSString *)key {
	NSString *ucfirst;
	NSString *lcfirst;
	NSString *remainder;
	SEL aSelector;
	CBPerlHash *iVars;
		
	ucfirst = [[key substringToIndex:1] uppercaseString];
	lcfirst = [ucfirst lowercaseString];
	remainder = [key substringFromIndex:1];

	// First look for a public accessor method of the form getKey or key
	aSelector = NSSelectorFromString([NSString stringWithFormat:@"get%@%@", ucfirst, remainder]);
	if (CBGetMethodNameForSelector(_mySV, aSelector))
		return [self performSelector:aSelector];

	aSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@", lcfirst, remainder]);
	if (CBGetMethodNameForSelector(_mySV, aSelector))
		return [self performSelector:aSelector];
	
	// Next look for private accessor methods of the form _getKey or _key
	aSelector = NSSelectorFromString([NSString stringWithFormat:@"_get%@%@", ucfirst, remainder]);
	if (CBGetMethodNameForSelector(_mySV, aSelector))
		return [self performSelector:aSelector];

	aSelector = NSSelectorFromString([NSString stringWithFormat:@"_%@%@", lcfirst, remainder]);
	if (CBGetMethodNameForSelector(_mySV, aSelector))
		return [self performSelector:aSelector];

	// Now look for an iVar
	iVars = [CBPerlHash dictionaryWithHV:_myHV];
	return [iVars objectForKey:key];
}

- (void) setValue: (id)value forKey: (NSString *)key {
	NSString *ucfirst;
	NSString *remainder;
	SEL aSelector;
	CBPerlHash *iVars;
	BOOL doesKVO;
	
	ucfirst = [[key substringToIndex:1] uppercaseString];
	remainder = [key substringFromIndex:1];

	doesKVO = [super respondsToSelector: @selector(willChangeValueForKey:)];
	
	if (doesKVO) [super willChangeValueForKey:key];

	// Look for public accessor method first
	aSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", ucfirst, remainder]);
	if (CBGetMethodNameForSelector(_mySV, aSelector)) {
		[self performSelector:aSelector withObject:value];
		if (doesKVO) [super didChangeValueForKey:key];
		return;
	}

	// Failing that, look for a private accessor
	aSelector = NSSelectorFromString([NSString stringWithFormat:@"_set%@%@:", ucfirst, remainder]);
	if (CBGetMethodNameForSelector(_mySV, aSelector)) {
		[self performSelector:aSelector withObject:value];
		if (doesKVO) [super didChangeValueForKey:key];
		return;
	}

	// If all else fails, set an iVar
	iVars = [CBPerlHash dictionaryWithHV:_myHV];
	[iVars setObject:value forKey:key];

	if (doesKVO) [super didChangeValueForKey:key];
}

- (void) takeValue: (id)value forKey: (NSString *)key {
	[self setValue:value forKey:key];
}

@end
