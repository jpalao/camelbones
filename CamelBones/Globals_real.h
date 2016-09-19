//
//  Globals_real.h
//  CamelBones
//
//  Copyright (c) 2001 Sherm Pendley. All rights reserved.
//



#ifdef GNUSTEP
#import <Foundation/Foundation.h>
#else
#import <objc/objc.h>
#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreGraphics/CoreGraphics.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif
#endif

// Create Perl wrappers for all global variables
extern void REAL_CBWrapAllGlobals(void);

// Create Perl wrappers for one global variable of a specific type
extern BOOL REAL_CBWrapString(const char *varName, const char *pkgName);
