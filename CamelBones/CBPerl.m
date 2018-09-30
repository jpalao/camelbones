//
//  CBPerl.m
//  Camel Bones - a bare-bones Perl bridge for Objective-C
//  Originally written for ShuX
//
//  Copyright (c) 2002 Sherm Pendley. All rights reserved.
//


#import "AppMain.h"
#import "Conversions.h"
#import "Globals.h"
#import "Runtime.h"

#import "CBPerl.h"
#import "CBPerlArray.h"
#import "CBPerlHash.h"
#import "CBPerlObject.h"
#import "CBPerlScalar.h"

@interface CBPerl (DummyThread)
- (void) dummyThread: (id)dummy;
@end

@implementation CBPerl

@synthesize CBPerlInterpreter = _CBPerlInterpreter;
@synthesize sharedPerl = _sharedPerl;

static NSMutableDictionary *perlInstanceDict = nil;

+ (void) initPerlInstanceDictionary: (NSMutableDictionary *) dictionary {
    // prevent xs call to overwrite the perl instance dict when running from app
    if (!perlInstanceDict)
        perlInstanceDict = dictionary;
}

+ (void) clearPerlInstanceDictionary: (NSMutableDictionary *) dictionary {
    if (dictionary == perlInstanceDict)
        perlInstanceDict = nil;
}

+ (NSMutableDictionary *) getPerlInstanceDictionary {
    return perlInstanceDict;
}

+ (void) initializePerl {
    @synchronized(self) {
        char *dummy_perl_env[1] = { NULL };
        int nargs = 0;
        char *emb[] = {};

#if defined(PERL_SYS_INIT3) && !defined(MYMALLOC)
        /* only call this the first time through, as per perlembed man page */
        PERL_SYS_INIT3(&nargs, (char ***) &emb, (char***)&dummy_perl_env);
#endif
        perlInitialized = 1;
    }
}

+ (void) destroyPerl {
    PERL_SYS_TERM();
    perlInitialized = 0;
}

+ (CBPerl *) getCBPerlFromPerlInterpreter: (PerlInterpreter *) perlInterpreter {
    @synchronized(self) {
        CBPerl * result = [[CBPerl getPerlInstanceDictionary] valueForKey:[NSString stringWithFormat:@"%llx", (unsigned long long) perlInterpreter]];
        return result;
    }
}

+ (void) setCBPerl:(CBPerl *) cbperl forPerlInterpreter:(PerlInterpreter *) perlInterpreter {
    @synchronized(self) {
        NSAssert ([CBPerl getPerlInstanceDictionary] != NULL, @"perl2CBPerlDict is NULL");
        [[CBPerl getPerlInstanceDictionary] setObject:cbperl forKey:[NSString stringWithFormat:@"%llx", (unsigned long long) perlInterpreter]];
    }
}

+ (PerlInterpreter *) getPerlInterpreter {
    @synchronized(self) {
#if DEBUG
        void * vp = PERL_GET_CONTEXT;
        NSAssert(vp != NULL, @"getPerlInterpreter returning null...");
        return vp;
#else
        return PERL_GET_CONTEXT;
#endif
    }
}

- (CBPerl *) sharedPerl {
    return _sharedPerl;
}

- (void) dealloc
{
    [super dealloc];
}

-(void) camelBonesInitialization {

    NSArray *bundles;
    NSEnumerator *e;
    NSBundle *obj;
    NSString *perlArchname;
    NSString *perlVersion;

    // Get Perl's archname and version
    [self useModule: @"Config"];
    perlArchname = [self eval: @"$Config{'archname'}"];
    perlVersion = [self eval: @"$Config{'version'}"];

    // Are we threaded?
    if ([perlArchname rangeOfString:@"thread"].location != NSNotFound) {
        // Yes - start a dummy Cocoa thread
        [NSThread detachNewThreadSelector:@selector(dummyThread:) toTarget:self withObject:nil];

        // Now tell Perl to use threads.pm
        [self useModule:@"threads"];
    }

    // Add bundled resource folders to @INC
    bundles = [NSBundle allFrameworks];
    e = [bundles objectEnumerator];
    while ((obj = [e nextObject])) {
        [self useBundleLib:obj withArch: perlArchname forVersion: perlVersion];
    }

    bundles = [NSBundle allBundles];
    e = [bundles objectEnumerator];
    while ((obj = [e nextObject])) {
        [self useBundleLib:obj withArch: perlArchname forVersion: perlVersion];
    }

    [self useBundleLib:[NSBundle mainBundle] withArch: perlArchname forVersion: perlVersion];

    // Create Perl wrappers for all registered Objective-C classes
    CBWrapRegisteredClasses();

    // Export globals into Perl's name space
    CBWrapAllGlobals();

    // When bundles are loaded, we want to hear about it
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bundleDidLoad:)
                                                 name:NSBundleDidLoadNotification object:nil];
}

- (NSArray *) getDefaultPerlIncludes {
    NSString * bundlePath                   = [[NSBundle mainBundle] resourcePath];
    NSString * incCaches = [NSString stringWithFormat:@"-I%@/Library/Caches", bundlePath];
    NSString * inc1 = [NSString stringWithFormat:@"-I%@/perl5/%@", bundlePath, perlVersionString];
    NSString * inc2 = [NSString stringWithFormat:@"-I%@/perl5/site_perl", bundlePath];
    NSString * inc3 = [NSString stringWithFormat:@"-I%@/perl5/%@/darwin-thread-multi-2level", bundlePath, perlVersionString];
    NSString * inc4 = [NSString stringWithFormat:@"-I%@/perl5/site_perl/%@/darwin-thread-multi-2level", bundlePath, perlVersionString];
    return [NSArray arrayWithObjects:incCaches, inc1, inc2, inc3, inc4, nil];
}

- (id) initWithFileName:(NSString*)fileName withDebugger:(Boolean)debuggerEnabled withOptions:(NSArray *) options withArguments:(NSArray *) arguments {

    int embSize = 0;
    char *emb[32];

    NSArray * perlIncludes = [self getDefaultPerlIncludes];

    for (NSString * perlInclude in perlIncludes){
        if (perlInclude != nil)
            emb[embSize++] = (char *)[perlInclude UTF8String];
    }

    if (options != nil){
        for (NSString * option in options) {
            if (option != nil)
                emb[embSize++] = (char *)[option UTF8String];
        }
    }

    if ( debuggerEnabled ) {
        emb[embSize++] = "-d:ebug::Backend";
        emb[embSize++] = (char *)[fileName UTF8String];
    } else {
        emb[embSize++] = (char *)[fileName UTF8String];
    }

    if (arguments != nil){
        for (NSString * argument in arguments) {
            if (argument != nil)
                emb[embSize++] = (char *)[argument UTF8String];
        }
    }

    // No, create one and retain it
    if ((self = [super init])) {

        if (!perlInitialized) {
            [CBPerl initializePerl];
        }

        _CBPerlInterpreter = perl_alloc();
#if DEBUG
        NSLog(@"Inited Interpreter %llx", (unsigned long long)_CBPerlInterpreter);
#endif
        _sharedPerl = self;
        [CBPerl setCBPerl:_sharedPerl forPerlInterpreter:_CBPerlInterpreter];
        PERL_SET_CONTEXT(_CBPerlInterpreter);

        perl_construct(_CBPerlInterpreter);
        perl_parse(_CBPerlInterpreter, xs_init, embSize, emb, (char **)NULL);
        perl_run(_CBPerlInterpreter);

        return [_sharedPerl retain];
        
    } else {
        // Wonder what happened here?
        return nil;
    }
}

- (id) init {

    int embSize = 0;
    
#if !TARGET_OS_IPHONE
    char *emb[] = { "", "-e", "0" };
    embSize = 3;
#else
    char *emb[32];

    NSArray * perlIncludes = [self getDefaultPerlIncludes];

    emb[embSize++] = "";

    for (NSString * perlInclude in perlIncludes){
        if (perlInclude != nil)
            emb[embSize++] = (char *)[perlInclude UTF8String];
    }

    emb[embSize++] = "-e";
    emb[embSize++] = "0";
#endif

    // Is there a shared perl object already?
    if (_sharedPerl) {
        // Yes, retain and return it
        return [_sharedPerl retain];

    } else {
        // No, create one and retain it
        if ((self = [super init])) {

            if (!perlInitialized) {
                [CBPerl initializePerl];
            }

            _CBPerlInterpreter = perl_alloc();
#if DEBUG
            NSLog(@"Inited Perl Interpreter %llx", (unsigned long long)_CBPerlInterpreter);
#endif
            PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
            perl_construct(_CBPerlInterpreter);
            perl_parse(_CBPerlInterpreter, xs_init, embSize, emb, (char **)NULL);
            perl_run(_CBPerlInterpreter);
            _sharedPerl = self;

            NSAssert([CBPerl getCBPerlFromPerlInterpreter:_CBPerlInterpreter] == NULL, @"Interpreter already in DB");

            [CBPerl setCBPerl:_sharedPerl forPerlInterpreter:_CBPerlInterpreter];

            [self camelBonesInitialization];

            return [_sharedPerl retain];

        } else {
            // Wonder what happened here?
            return nil;
        }
    }
}

-(void) cleanUp {
    @synchronized(self) {
        PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
#if DEBUG
        NSLog(@"Cleanup Interpreter %llx", (unsigned long long)_CBPerlInterpreter);
#endif
        [[CBPerl getPerlInstanceDictionary] removeObjectForKey:[NSString stringWithFormat:@"%llx", (unsigned long long) _CBPerlInterpreter]];
        perl_destruct(_CBPerlInterpreter);
        perl_free(_CBPerlInterpreter);

//      TODO: PERL_SYS_TERM will kill the app, cannot be called at least on iOS

//        if (![perl2CBPerlDict count]) {
//            [CBPerl destroyPerl];
//            perlInitialized = false;
//        }
    }
}

- (id) initXS {

    [CBPerl initPerlInstanceDictionary: [NSMutableDictionary dictionaryWithCapacity:128]];

    if ((self = [super init])) {
        NSArray *bundles;
        NSEnumerator *e;
        NSBundle *obj;
        NSString *perlArchname;
        NSString *perlVersion;

        NSAutoreleasePool *p;
        
        // Set up housekeeping
        p = [[NSAutoreleasePool alloc] init];
        _sharedPerl = self;
        _CBPerlInterpreter = PERL_GET_CONTEXT;
        [CBPerl setCBPerl:_sharedPerl forPerlInterpreter:_CBPerlInterpreter];

        // Get Perl's archname and version
        [self useModule: @"Config"];
        perlArchname = [self eval: @"$Config{'archname'}"];
        perlVersion = [self eval: @"$Config{'version'}"];

        // Are we threaded?
        if ([perlArchname rangeOfString:@"thread"].location != NSNotFound) {
            // Yes - start a dummy Cocoa thread
            [NSThread detachNewThreadSelector:@selector(dummyThread:) toTarget:self withObject:nil];

            // Now tell Perl to use threads.pm
            [self useModule:@"threads"];
        }

        // Add bundled resource folders to @INC
        bundles = [NSBundle allFrameworks];
        e = [bundles objectEnumerator];
        while ((obj = [e nextObject])) {
            [self useBundleLib:obj withArch: perlArchname forVersion: perlVersion];
        }
        
        bundles = [NSBundle allBundles];
        e = [bundles objectEnumerator];
        while ((obj = [e nextObject])) {
            [self useBundleLib:obj withArch: perlArchname forVersion: perlVersion];
        }
        
        // Create Perl wrappers for all registered Objective-C classes
        CBWrapRegisteredClasses();
        
        // Export globals into Perl's name space
        CBWrapAllGlobals();

        // When bundles are loaded, we want to hear about it
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bundleDidLoad:)
                                              name:NSBundleDidLoadNotification object:nil];

        [p release];

        // Register the class handler
#ifndef OBJC2_UNAVAILABLE
        //http://lists.apple.com/archives/cocoa-dev/2009/Jan/msg02484.html
        CBRegisterClassHandler();
#endif

        //_CBPerlInterpreter = checkCBPerl;
        //[CBPerl setCBPerl:_sharedPerl forPerlInterpreter:_CBPerlInterpreter];
        return [_sharedPerl retain];

    } else {
        // Wonder what happened here?
        return nil;
    }
}

- (void) useBundleLib: (NSBundle *)aBundle
		withArch: (NSString *)perlArchName
		forVersion: (NSString *)perlVersion {

	NSString *bundleFolder;
	
	bundleFolder = [aBundle resourcePath];

	[self useLib: bundleFolder];
	[self useLib: [NSString stringWithFormat: @"%@/Resources", bundleFolder]];

	if (perlArchName != nil) {
		[self useLib: [NSString stringWithFormat: @"%@/Resources/%@", bundleFolder, perlArchName]];
	}
	
	if (perlArchName != nil && perlVersion != nil) {
		[self useLib: [NSString stringWithFormat: @"%@/Resources/%@", bundleFolder, perlVersion]];
		[self useLib: [NSString stringWithFormat: @"%@/Resources/%@/%@", bundleFolder, perlVersion, perlArchName]];
	}
}

- (id) eval: (NSString *)perlCode {
    // Define a Perl context
    @synchronized(self) {
        PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
        dTHX;

        SV *result = eval_pv([perlCode UTF8String], FALSE);

        // Check for an error
        if (SvTRUE(ERRSV)) {
            NSString * message = [NSString stringWithFormat:@"Perl exception: %s", SvPV(ERRSV, PL_na)];
#if DEBUG
            NSLog(@"%@", message);
#endif
            [NSException raise:CBPerlErrorException format:message];

            return nil;
        }

        if (result == &PL_sv_undef || result == NULL) {
            return nil;
        }

    	return CBDerefSVtoID(result);
    }
}

// Standard KVC methods
- (id) valueForKey:(NSString*)key {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;
    SV* sv;
    if ([key hasPrefix:@"@"]) {
        sv = (SV*)get_av([key UTF8String], TRUE);
    } else if ([key hasPrefix:@"%"]) {
        sv = (SV*)get_hv([key UTF8String], TRUE);
    } else {
        sv = get_sv([key UTF8String], TRUE);
    }
    return CBDerefSVtoID(sv);
}

- (void) setValue:(id)value forKey:(NSString*)key {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;
    SV* newVal = CBDerefIDtoSV(value);
    SV* sv = get_sv([key UTF8String], TRUE);
    sv_setsv_mg(sv, newVal);
}

- (long) varAsInt: (NSString *)perlVar {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;
    
    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    return SvIV(get_sv([perlVar UTF8String], TRUE));
}

- (void) setVar: (NSString *)perlVar toInt: (long)newValue {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    sv_setiv_mg(get_sv([perlVar UTF8String], TRUE), newValue);
}

- (double) varAsFloat: (NSString *)perlVar {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    return SvNV(get_sv([perlVar UTF8String], TRUE));
}

- (void) setVar: (NSString *)perlVar toFloat: (double)newValue {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    sv_setnv_mg(get_sv([perlVar UTF8String], TRUE), newValue);
}

- (NSString *) varAsString: (NSString *)perlVar {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    STRLEN n_a;
    return [NSString stringWithUTF8String: SvPV(get_sv([perlVar UTF8String], TRUE), n_a)];
}

- (void) setVar: (NSString *)perlVar toString: (NSString *)newValue {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    sv_setpv_mg(get_sv([perlVar UTF8String], TRUE), [newValue UTF8String]);
}

- (void) useLib: (NSString *)libPath {
	NSFileManager *manager;
	BOOL isDir;

	manager = [NSFileManager defaultManager];
	if ([manager fileExistsAtPath:libPath isDirectory:&isDir] && isDir) {
	    [_sharedPerl eval: [NSString stringWithFormat: @"use lib '%@';", libPath]];
	}
}

- (void) useModule: (NSString *)moduleName {
    [_sharedPerl eval: [NSString stringWithFormat: @"use %@;", moduleName]];
}

- (void) useWarnings {
    [_sharedPerl eval: @"use warnings;"];
}

- (void) noWarnings {
    [_sharedPerl eval: @"no warnings;"];
}

- (void) useStrict {
    [self useStrict: nil];
}

- (void) useStrict: (NSString *)options {
    if (options) {
        [_sharedPerl eval: [NSString stringWithFormat: @"use strict '%@';", options]];
    } else {
        [_sharedPerl eval: @"use strict;"];
    }
}

- (void) noStrict {
    [self noStrict: nil];
}

- (void) noStrict: (NSString *)options {
    if (options) {
        [_sharedPerl eval: [NSString stringWithFormat: @"no strict '%@';", options]];
    } else {
        [_sharedPerl eval: @"no strict;"];
    }
}

- (CBPerlScalar *) namedScalar: (NSString *)varName {
    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    return [CBPerlScalar namedScalar: varName];
}

- (CBPerlArray *) namedArray: (NSString *)varName {
    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    return [CBPerlArray arrayNamed: varName];
}

- (CBPerlHash *) namedHash: (NSString *)varName {
    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    return [CBPerlHash dictionaryNamed: varName];
}

- (CBPerlObject *) namedObject: (NSString *)varName {
    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));

    return [CBPerlObject namedObject: varName];
}

- (void) exportArray: (NSArray *)array toPerlArray: (NSString *)arrayName {
    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));
}
- (void) exportDictionary: (NSDictionary *)dictionary toPerlHash: (NSString *)hashName {
    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));
}
- (void) exportObject: (id)object toPerlObject: (NSString *)objectName {
    NSLog(@"Warning: %@ has been deprecated and will soon be removed. Use KVC methods valueForKey: and setValue:forKey: instead.", NSStringFromSelector(_cmd));
}


// A bundle was loaded - wrap its classes
- (void) bundleDidLoad: (NSNotification *)notification {
	NSArray *classes = [[notification userInfo] valueForKey:@"NSLoadedClasses"];

	// Add the bundle's Resource dir to @INC
	NSString *perlArchname = [self eval: @"$Config{'archname'}"];
	NSString *perlVersion = [self eval: @"$Config{'version'}"];

	// Add bundle's resource folder to @INC
	NSBundle *bundle = [notification object];
	[self useBundleLib:bundle  withArch: perlArchname forVersion: perlVersion];
            
	CBWrapNamedClasses(classes);
}

- (void) dummyThread: (id)dummy {
    return;
}

@end
