//
//  Globals.h
//  CamelBones
//
//  Copyright (c) 2001 Sherm Pendley. All rights reserved.
//

#ifdef GNUSTEP
#import <Foundation/Foundation.h>
#else
#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#elif TARGET_OS_MAC
#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif
#endif
#endif

// Create Perl wrappers for all global variables
extern void (*CBWrapAllGlobals)(void);

// Create Perl wrappers for one global variable of a specific type
extern BOOL (*CBWrapString)(const char *varName, const char *pkgName);
