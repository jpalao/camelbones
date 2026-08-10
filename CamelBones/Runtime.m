//
//  Runtime.m
//  CamelBones
//
//  Copyright (c) 2002 Sherm Pendley. All rights reserved.
//

#include <sys/types.h>
#include <mach/machine.h>

#ifdef GNUSTEP
#import <objc/objc-api.h>
#else
#import <objc/runtime.h>
#endif

#import <Foundation/Foundation.h>

#import "CBPerl.h"
#import "Runtime.h"
#import "PerlImports.h"
#import "PerlMethods.h"

static void CBRegisterMethodsForClass(NSArray *methods, Class class, BOOL isClassMethod);

// Create Perl wrappers for all registered ObjC classes
void CBWrapRegisteredClasses(void) {
#ifdef GNUSTEP
	void *enum_state;
	Class thisClass;
	
	enum_state = NULL;
	while ((thisClass = objc_next_class(&enum_state))) {
		CBWrapObjectiveCClass(thisClass);
	}
#else
	int numClasses;
    Class *classes;
    int i;

    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        classes = malloc(sizeof(Class) * numClasses);
        objc_getClassList(classes, numClasses);
        for(i=0; i < numClasses; i++) {
            CBWrapObjectiveCClass(classes[i]);
        }
        free(classes);
    }
#endif
}

void CBWrapNamedClasses(NSArray *names) {
	if (nil == names) return;
	NSEnumerator *e = [names objectEnumerator];
    NSString *s;
	while ((s = [e nextObject])) {
		Class c = objc_getClass([s UTF8String]);
		CBWrapObjectiveCClass(c);
	}
}

// Create a Perl wrapper for a single ObjC class
void CBWrapObjectiveCClass(Class aClass) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    // Create the @ClassName::ISA = qw(SuperClass);
    const char *className = class_getName(aClass);
    const char *ISAName;
    const char *SuperName = NULL;
    AV *newIsaAV = NULL;
    SV *newParentSV = NULL;
    
    // Don't add NSObject to its own @ISA - Perl >= 5.10 warns about it
    if (0 == strncmp(className, "NSObject", 8)) {
        return;
    }

#if 0
    NSLog(@"Wrapping class: %s", className);
#endif

    // Get the super class name; default to "NSObject" for root classes
    Class superClass = class_getSuperclass(aClass);
    if (superClass != NULL) {
        SuperName = class_getName(superClass);
    } else {
        SuperName = "NSObject";
    }

    // Build up the PackageName::ISA array name and create the array
    ISAName = [[NSString stringWithFormat:@"%s::ISA", className] UTF8String];
    newIsaAV = get_av(ISAName, TRUE);

    // Clear any existing elements
    av_clear(newIsaAV);
            
    // Add the superclass element
    newParentSV = newSVpv(SuperName, 0);
    av_push(newIsaAV, newParentSV);
}

// Query class registration
BOOL CBIsClassRegistered(const char *className) {
    return (nil != objc_getClass(className)) ? YES : NO;
}

// Register a Perl class with the runtime
void CBRegisterClassWithSuperClass(const char *className, const char *superName) {
#ifdef GNUSTEP
    NSDictionary *ivars = [NSDictionary dictionaryWithObject:@"v" forKey:@"_sv"];
    NSValue *theClass = GSObjCMakeClass([NSString stringWithUTF8String:className],
                                        [NSString stringWithUTF8String:superName],
                                        ivars);
    GSObjCAddClasses([NSArray arrayWithObjects: theClass, nil]);
#else
    Class super_class;
    Class new_class;

    // Bail out of superName is already registered, or if className is not.
    super_class = objc_lookUpClass(superName);
    if (nil == super_class) return;
    if (nil != objc_lookUpClass(className)) return;

    // Make room, make room
    new_class = objc_allocateClassPair(super_class, className, 0);
    if (nil == new_class) return;
    // One instance variable, _sv
    class_addIvar(new_class, "_sv", 1, log2(sizeof(pointer_t)), "^v");

    // Register the class
    objc_registerClassPair(new_class);
#endif
}

// Query method registration
BOOL CBIsObjectMethodRegisteredForClass(SEL selector, Class class) {
#ifdef GNUSTEP
    return (NULL != GSGetMethod(class, selector, YES, NO)) ? YES : NO;
#else
	return (nil != class_getInstanceMethod(class, selector)) ? YES : NO;
#endif
}

BOOL CBIsClassMethodRegisteredForClass(SEL selector, Class class) {
#ifdef GNUSTEP
    return (NULL != GSGetMethod(class, selector, NO, NO)) ? YES : NO;
#else
    return (nil != class_getClassMethod(class, selector)) ? YES : NO;
#endif
}

// Perform method registration
void CBRegisterObjectMethodsForClass(const char *package, NSArray *methods, Class class) {
#ifdef GNUSTEP
    struct objc_method_list *list;

    list = CBAllocateMethodList(methods, class);
    if (list) {
        GSAddMethodList(class, list, YES);
        GSFlushMethodCacheForClass(class);
    }
#else
    CBRegisterMethodsForClass(methods, class, NO);
#endif
}

void CBRegisterClassMethodsForClass(const char *package, NSArray *methods, Class class) {
#ifdef GNUSTEP
    struct objc_method_list *list;

    list = CBAllocateMethodList(methods, class);
    if (list) {
        GSAddMethodList(class, list, NO);
        GSFlushMethodCacheForClass(class);
    }
#else
    CBRegisterMethodsForClass(methods, class, YES);
#endif
}

// Class handler function
#ifdef GNUSTEP
Class
#else
int
#endif
__CB_classHandler(const char* className) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

	// Try to load it
	NSString *useCommand = [NSString stringWithFormat:@"eval 'use %s'", className];
    [[CBPerl getCBPerlFromPerlInterpreter:[CBPerl getPerlInterpreter]] eval:useCommand];

    // Check for an error
    if (SvTRUE(ERRSV)) {
        NSLog(@"Perl error: %s", SvPV(ERRSV, PL_na));
#ifdef GNUSTEP
        return NULL;
#else
        return 0;
#endif
    }

#ifdef GNUSTEP
    return GSClassFromName(className);
#else
	return 1;
#endif
}

void CBRegisterClassHandler(void) {
#ifdef GNUSTEP
    _objc_lookup_class = __CB_classHandler;
#else
	objc_setClassHandler(__CB_classHandler);
#endif
}

static void CBRegisterMethodsForClass(NSArray *methods, Class class, BOOL isClassMethod) {
    NSUInteger num_methods;
    NSUInteger i;
    Class targetClass;
    BOOL methodRegistered;

    num_methods = [methods count];
    if (num_methods <= 0) return;

    targetClass = isClassMethod ? object_getClass(class) : class;
    if (Nil == targetClass) return;

    for (i=0; i < num_methods; i++) {
        const char *perlSig;
        const char *selName;
        SEL selector;

        selName = [[[methods objectAtIndex:i] objectForKey:@"name"] UTF8String];
        perlSig = [[[methods objectAtIndex:i] objectForKey:@"signature"] UTF8String];
        selector = sel_registerName(selName);

        methodRegistered = isClassMethod
            ? CBIsClassMethodRegisteredForClass(selector, class)
            : CBIsObjectMethodRegisteredForClass(selector, class);
        if (methodRegistered) continue;

        class_addMethod(targetClass, selector, (void(*)(void))CBPerlIMP, perlSig);
    }
}

#ifdef GNUSTEP
// Private method
struct objc_method_list* CBAllocateMethodList(NSArray *methods, Class class) {
    struct objc_method_list *list;
    int num_methods;
    int i;

    // Basic sanity checking, for an empty list    
    num_methods = [methods count];
    if (num_methods <= 0) return NULL;

    // Allocate memory for the list and all the methods in it
    list = GSAllocMethodList(num_methods);
    if (!list) return NULL;

    // Add each method in methods to the C struct
    for (i=0; i < num_methods; i++) {
        const char *perlSig;
		const char *selName;

		selName = [[[methods objectAtIndex: i] objectForKey:@"name"] UTF8String];
        perlSig = [[[methods objectAtIndex:i] objectForKey:@"signature"] UTF8String];

        GSAppendMethodToList(list,
                             GSSelectorFromName(selName),
                             perlSig,
                             CBPerlIMP,
                             YES);
    }

    return list;
}
#endif
