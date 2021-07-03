//
//  CBPerl.h
//  Camel Bones - a bare-bones Perl bridge for Objective-C
//  Originally written for ShuX
//
//  Copyright (c) 2002 Sherm Pendley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PerlImports.h>
#include <perlxsi.h>

#define CBPerlErrorException @"CBPerlErrorException"

@class CBPerlScalar;
@class CBPerlArray;
@class CBPerlHash;
@class CBPerlObject;

typedef void (^PerlCompletionBlock)(int perlRunResult);

static dispatch_queue_t stdioQueue = nil;

@interface CBPerl : NSObject {
    PerlInterpreter * _CBPerlInterpreter;
}

// _CBPerlInterpreter: pointer to this CBPerl object's perl interpreter
@property (nonatomic, assign) PerlInterpreter * CBPerlInterpreter;

@property (nonatomic, assign) NSString * perlVersionString;

// getPerlInterpreter: Class method that returns the current perl Interpreter
+ (PerlInterpreter *) getPerlInterpreter;

// The following three methods handle global registration of CBPerl objects and their perl
// interpreters through perlInstanceDict and perlInitialized globals

// getPerlInterpreter: Class method that returns the global perl Interpreter dictionary
// It will initialize the dictionary if not already initialized
+ (NSMutableDictionary *) getPerlInstanceDictionary;

// init the perl instance Dictionary
+ (void) initPerlInstanceDictionary: (NSMutableDictionary *) dictionary;

// if passed the correct pointer will delete the dictionary
// make sure the dictionary is empty before using this!!!
+ (void) clearPerlInstanceDictionary: (NSMutableDictionary *) dictionary;

// getCBPerlFromPerlInterpreter: Class method that returns the CBPerl object corresponding to an embedded perl interpreter object
+ (CBPerl *) getCBPerlFromPerlInterpreter: (PerlInterpreter *) perlInterpreter;

// setCBPerl: Class method that sets the CBPerl object corresponding to an embedded perl interpreter object
+ (void) setCBPerl:(CBPerl *) cbperl forPerlInterpreter:(PerlInterpreter *) perlInterpreter;

// clean up this CBPerl object's perl interpreter
- (void) cleanUp;

// init this CBPerl object with a new perl interpreter and a queue
- (void) initWithFileName:(NSString*)fileName withAbsolutePwd:(NSString*)pwd withDebugger:(Boolean)debuggerEnabled withOptions:(NSArray *) options withArguments:(NSArray *) arguments error:(NSError **)error queue:(dispatch_queue_t) queue completion:(PerlCompletionBlock)completion;

// init this CBPerl object with a new perl interpreter
-(void) initWithFileName:(NSString*)fileName withAbsolutePwd:(NSString*)pwd withDebugger:(Boolean)debuggerEnabled withOptions:(NSArray *) options withArguments:(NSArray *) arguments error:(NSError **)error completion:(PerlCompletionBlock)completion;

- (void) syntaxCheck:(NSString*)fileName error:(NSError **)error;

// init: creates the shared CBPerl object if necessary, retains and returns it.
- (id) init;

- (void) dealloc;

// initXS: A version of init suitable for use within XS modules
- (id) initXS: (BOOL) importCocoa;

- (void) useBundleLib: (NSBundle *)aBundle
		withArch: (NSString *)perlArchName
		forVersion: (NSString *)perlVersion;

// Evaluates a string of Perl code
- (id) eval: (NSString *)perlCode;

// Standard KVC methods
- (id) valueForKey:(NSString*)key;
- (void) setValue:(id)value forKey:(NSString*)key;

// Simple access methods to get/set perl variables of known type and name.

// Perl's built-in automatic variable creation is invoked if the named variable
// does not exist.

// These methods all call the built-in Perl type conversion functions, and
// thus share Perl's type conversion rules.

// Perl variable to/from an Int
- (long) varAsInt: (NSString *)perlVar;
- (void) setVar: (NSString *)perlVar toInt: (long)newValue;

// Perl variable as a float
- (double) varAsFloat: (NSString *)perlVar;
- (void) setVar: (NSString *)perlVar toFloat: (double)newValue;

// Perl variable as a string
- (NSString *) varAsString: (NSString *)perlVar;
- (void) setVar: (NSString *)perlVar toString: (NSString *)newValue;

// Some methods for accessing Perl's "use" pragmas
- (void) useLib: (NSString *)libPath;		// Adds libPath to the library search path
- (void) useModule: (NSString *)moduleName;     // Returns TRUE if the module loaded
- (void) useWarnings;				// Enables warnings
- (void) noWarnings;				// Disables warnings
- (void) useStrict;				// Enables strict mode
- (void) useStrict: (NSString *)options;	// Enables strict mode with options
- (void) noStrict;				// Disables strict mode
- (void) noStrict: (NSString *)options;		// Disables strict mode with options

// Methods to return autoreleased handles referencing named Perl
// variables, cast as the appropriate CamelBones type.
- (CBPerlScalar *) namedScalar: (NSString *)varName;
- (CBPerlArray *) namedArray: (NSString *)varName;
- (CBPerlHash *) namedHash: (NSString *)varName;
- (CBPerlObject *) namedObject: (NSString *)varName;

// Methods to export Objective-C objects into Perl's name space
- (void) exportArray: (NSArray *)array toPerlArray: (NSString *)arrayName;
- (void) exportDictionary: (NSDictionary *)dictionary toPerlHash: (NSString *)hashName;
- (void) exportObject: (id)object toPerlObject: (NSString *)objectName;

// Notification callback method for bundle loading
- (void) bundleDidLoad: (NSNotification *)notification;

@end

