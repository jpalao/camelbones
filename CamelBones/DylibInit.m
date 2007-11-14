#import "AppMain.h"
#import "CBPerl.h"
#import "Conversions.h"
#import "Structs.h"
#import "Runtime.h"
#import "NativeMethods.h"
#import "PerlMethods.h"
#import "Globals.h"
#import "Wrappers.h"

#ifdef GNUSTEP
#include <dlfcn.h>
#define CBResolve(name)                         \
    name = dlsym(b, "REAL_" #name);             \
    if (!name) NSLog(fmt, #name);

#else
#define CBResolve(name)                                                 \
    name = CFBundleGetFunctionPointerForName(b, (CFStringRef)@"REAL_" #name); \
	if (!name) NSLog(fmt, #name);
#endif

@implementation CBPerl (DylibInit)
+ (void) dylibInit: (const char*) archver {
    NSBundle *theBundle;
    NSEnumerator *e;

    // Get the framework with the identifier we're interested in
    e = [[NSBundle allFrameworks] objectEnumerator];
    while ((theBundle = [e nextObject]) != nil) {
        if ([[theBundle bundleIdentifier] isEqualToString:@"org.dot-app.CamelBones"]) break;
    }

    // Resolve the path to the dylib, and load it
    NSString *bundlePath = [NSString stringWithFormat:@"%@/Libraries/%s.bundle", [theBundle bundlePath], archver];

#ifdef GNUSTEP
    NSString *bundleBinPath = [NSString stringWithFormat:@"%@/%s", bundlePath, archver];
    const char *bundleBinCPath = [bundleBinPath UTF8String];
    void *b = dlopen(bundleBinCPath, RTLD_NOW | RTLD_GLOBAL);
    if (!b) {
        NSLog(@"Error loading support bundle at %s: %s", bundleBinCPath, dlerror());
    }
#else
	NSURL *bundleURL = [NSURL fileURLWithPath: bundlePath];
	CFBundleRef b = CFBundleCreate(NULL, (CFURLRef)bundleURL);
	if (!b) {

		// No joy, try looking for a shared bundle
		bundlePath = [NSString stringWithFormat:@"/Library/Frameworks/CamelBones.framework/Libraries/%s.bundle", archver];
		bundleURL = [NSURL fileURLWithPath: bundlePath];
		b = CFBundleCreate(NULL, (CFURLRef)bundleURL);

		if (!b) {

			// Give up
			NSLog(@"Error creating CFBundle from support bundle at URL %@", bundleURL);
			return;
		}
	}
	CFBundleLoadExecutable(b);
#endif

    // Conversions.m
	NSString *fmt = @"Could not load function: %s";

	CBResolve(CBDerefSVtoID)
	CBResolve(CBDerefIDtoSV)
	CBResolve(CBClassFromSV)
	CBResolve(CBSVFromClass)
	CBResolve(CBSelectorFromSV)
	CBResolve(CBSVFromSelector)
	CBResolve(CBPoke)

    // Structs.m
	CBResolve(CBPointFromAV)
	CBResolve(CBPointFromHV)
	CBResolve(CBPointFromSV)
	CBResolve(CBPointToSV)
	CBResolve(CBRectFromAV)
	CBResolve(CBRectFromHV)
	CBResolve(CBRectFromSV)
	CBResolve(CBRectToSV)
	CBResolve(CBRangeFromAV)
	CBResolve(CBRangeFromHV)
	CBResolve(CBRangeFromSV)
	CBResolve(CBRangeToSV)
	CBResolve(CBSizeFromAV)
	CBResolve(CBSizeFromHV)
	CBResolve(CBSizeFromSV)
	CBResolve(CBSizeToSV)
#ifndef GNUSTEP
	CBResolve(CBOSTypeFromSV)
	CBResolve(CBOSTypeToSV)
#endif
    


    // Runtime.m
	CBResolve(CBWrapRegisteredClasses)
	CBResolve(CBWrapNamedClasses)
	CBResolve(CBWrapObjectiveCClass)
	CBResolve(CBIsClassRegistered)
	CBResolve(CBRegisterClassWithSuperClass)
	CBResolve(CBRegisterClassHandler)


    // NativeMethods.m
	CBResolve(CBIsObjectMethodRegisteredForClass)
	CBResolve(CBIsClassMethodRegisteredForClass)
	CBResolve(CBRegisterObjectMethodsForClass)
	CBResolve(CBRegisterClassMethodsForClass)
	CBResolve(CBCallNativeMethod)


	// PerlMethods.m
	CBResolve(CBGetMethodNameForSelector)
	CBResolve(CBGetMethodArgumentSignatureForSelector)
	CBResolve(CBGetMethodReturnSignatureForSelector)
	CBResolve(CBPerlIMP)

    // Globals.m
	CBResolve(CBWrapAllGlobals)
	CBResolve(CBWrapString)



    // Wrappers.m
	CBResolve(CBCreateWrapperObject)
	CBResolve(CBCreateWrapperObjectWithClassName)
	CBResolve(CBCreateObjectOfClass)

#ifndef GNUSTEP
	CFRelease(b);
#endif
}

@end
