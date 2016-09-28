//
//  Globals.m
//  CamelBones
//
//  Copyright (c) 2002 Sherm Pendley. All rights reserved.
//

#import "Globals_real.h"
#import "Wrappers_real.h"
#import "Conversions_real.h"
#import "PerlImports.h"
#import "CBPerlArray.h"

#import "config.h"
#ifdef HAVE_DLFCN_H
#import <dlfcn.h>
#else
CFBundleRef b;
CFBundleRef foundationFramework;
CFBundleRef uiKitFramework;
CFBundleRef coreGraphicsFramework;
#endif

void REAL_CBWrapAllGlobals(void) {
    NSBundle *thisBundle;
    NSString *plistPath;

    NSArray *exports;
    NSEnumerator *e;
    NSString *thisExport;

    CBPerlArray *foundationISA;
    CBPerlArray *foundationEXPORT;
#if TARGET_OS_IPHONE
    CBPerlArray *uikitISA;
    CBPerlArray *uikitEXPORT;
#elif TARGET_OS_MAC
    CBPerlArray *appkitISA;
    CBPerlArray *appkitEXPORT;
#endif

    // Fill out the Foundation package's ISA and EXPORT arrays
    foundationISA = [CBPerlArray newArrayNamed:@"CamelBones::Foundation::Globals::ISA"];
    [foundationISA addObject:@"Exporter"];
    foundationEXPORT = [CBPerlArray newArrayNamed:@"CamelBones::Foundation::Globals::EXPORT"];

    // Fill out the AppKit/UIKit package's ISA and EXPORT arrays
#if TARGET_OS_IPHONE
    uikitISA = [CBPerlArray newArrayNamed:@"CamelBones::UIKit::Globals::ISA"];
    [uikitISA addObject:@"Exporter"];
    uikitEXPORT = [CBPerlArray newArrayNamed:@"CamelBones::UIKit::Globals::EXPORT"];
#elif TARGET_OS_MAC
    appkitISA = [CBPerlArray newArrayNamed:@"CamelBones::AppKit::Globals::ISA"];
    [appkitISA addObject:@"Exporter"];
    appkitEXPORT = [CBPerlArray newArrayNamed:@"CamelBones::AppKit::Globals::EXPORT"];
#endif

    // Get a handle on the CamelBones framework bundle
    thisBundle = [NSBundle bundleForClass:NSClassFromString(@"CBPerl")];

    // Get the Foundation exports plist and loop over the entries
    plistPath = [thisBundle pathForResource:@"FoundationGlobalStrings" ofType:@"plist"];

    exports = [NSArray arrayWithContentsOfFile:plistPath];
    e = [exports objectEnumerator];
    while ((thisExport = [e nextObject])) {
        // Try to make a wrapper
        if (REAL_CBWrapString([thisExport UTF8String], "CamelBones::Foundation::Globals")) {
            // If successful, make the wrapper exportable
            [foundationEXPORT addObject:thisExport];
        }
    }

// Get the AppKit exports plist and loop over the entries
#if TARGET_OS_IPHONE
    plistPath = [thisBundle pathForResource:@"UIKitGlobalStrings" ofType:@"plist"];
    exports = [NSArray arrayWithContentsOfFile:plistPath];
    e = [exports objectEnumerator];
    while ((thisExport = [e nextObject])) {
        // Try to make a wrapper
        if (REAL_CBWrapString([thisExport UTF8String], "CamelBones::UIKit::Globals")) {
            // If successful, make the wrapper exportable
            [uikitEXPORT addObject:[thisExport substringFromIndex:1]];
        }
    }
#elif TARGET_OS_MAC
    plistPath = [thisBundle pathForResource:@"AppKitGlobalStrings" ofType:@"plist"];
    exports = [NSArray arrayWithContentsOfFile:plistPath];
    e = [exports objectEnumerator];
    while ((thisExport = [e nextObject])) {
        // Try to make a wrapper
        if (REAL_CBWrapString([thisExport UTF8String], "CamelBones::AppKit::Globals")) {
            // If successful, make the wrapper exportable
            [appkitEXPORT addObject:[thisExport substringFromIndex:1]];
        }
    }
#endif
}

// temporary quick and dirty function to load globals from just the three iOS fundamental frameworks
void * CBGetiOSFrameworkGlobalAddress(const char *varName, const char *pkgName){
    CFStringRef cfTotalPath;
    CFURLRef    cURL;
    CFBundleRef resultFramework = NULL;
    if (strncmp("CamelBones::Foundation::Globals", pkgName, strlen("CamelBones::Foundation::Globals")) == 0) {
        if (NULL == foundationFramework) {
            cfTotalPath = CFStringCreateWithCString (NULL, "/System/Library/Frameworks/Foundation.framework", kCFStringEncodingUTF8);
            cURL = CFURLCreateWithFileSystemPath(NULL, cfTotalPath, kCFURLPOSIXPathStyle, false);
            foundationFramework = CFBundleCreate(kCFAllocatorDefault, cURL);
        }
        resultFramework = foundationFramework;
    }
    else if (strncmp("CamelBones::UIKit::Globals", pkgName, strlen("CamelBones::UIKit::Globals")) == 0) {
        if (NULL == uiKitFramework) {
            cfTotalPath = CFStringCreateWithCString (NULL, "/System/Library/Frameworks/UIKit.framework", kCFStringEncodingUTF8);
            cURL = CFURLCreateWithFileSystemPath(NULL, cfTotalPath, kCFURLPOSIXPathStyle, false);
            uiKitFramework = CFBundleCreate(kCFAllocatorDefault, cURL);
        }
        resultFramework = uiKitFramework;
    }
    else if (strncmp("CamelBones::CoreGraphics::Globals", pkgName, strlen("CamelBones::CoreGraphics::Globals")) == 0) {
        if (NULL == coreGraphicsFramework) {
            cfTotalPath = CFStringCreateWithCString (NULL, "/System/Library/Frameworks/CoreGraphics.framework", kCFStringEncodingUTF8);
            cURL = CFURLCreateWithFileSystemPath(NULL, cfTotalPath, kCFURLPOSIXPathStyle, false);
            coreGraphicsFramework = CFBundleCreate(kCFAllocatorDefault, cURL);

        }
        resultFramework = coreGraphicsFramework;
    }
    if (resultFramework == NULL) return NULL;
    return (void*)CFBundleGetDataPointerForName(resultFramework, (CFStringRef)[NSString stringWithFormat:@"%s", varName+1]);
}

BOOL REAL_CBWrapString(const char *varName, const char *pkgName) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    void *address = NULL;
    SV *mySV;

#ifdef HAVE_DLFCN_H
    address = dlsym( NULL, varName );
#else
	if (NULL == b) { b = CFBundleGetMainBundle(); }

#if TARGET_OS_IPHONE
    address = CBGetiOSFrameworkGlobalAddress(varName, pkgName);
#elif TARGET_OS_MAC
    address = CFBundleGetDataPointerForName(b, (CFStringRef)[NSString stringWithFormat:@"%c", (int)varName]);
#endif

#endif

    if (address) {
        mySV = REAL_CBDerefIDtoSV(*(NSString**)address);
        newCONSTSUB(gv_stashpv(pkgName, 0), (char *)varName+1, mySV);
      
        return TRUE;
    } else {
        return FALSE;
    }

}
