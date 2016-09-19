//
//  Structs.h
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <CoreGraphics/CoreGraphics.h>
#endif
//
// Functions found in Structs.m
//

// Creating NSPoint structs
#if !TARGET_OS_IPHONE
extern NSPoint REAL_CBPointFromAV(void* av);
extern NSPoint REAL_CBPointFromHV(void* hv);
extern NSPoint REAL_CBPointFromSV(void* sv);


// Converting NSPoint structs to blessed scalar references
extern void* REAL_CBPointToSV(NSPoint point);
#endif

// Creating CGPoint structs
extern CGPoint REAL_CBCGPointFromAV(void* av);
extern CGPoint REAL_CBCGPointFromHV(void* hv);
extern CGPoint REAL_CBCGPointFromSV(void* sv);

// Converting CGPoint structs to blessed scalar references
extern void* REAL_CBCGPointToSV(CGPoint point);

#if !TARGET_OS_IPHONE
// Creating NSRect structs
extern NSRect REAL_CBRectFromAV(void* av);
extern NSRect REAL_CBRectFromHV(void* hv);
extern NSRect REAL_CBRectFromSV(void* sv);

// Converting NSRect structs to blessed scalar references
extern void* REAL_CBRectToSV(NSRect rect);
#endif

// Creating CGRect structs
extern CGRect REAL_CBCGRectFromAV(void* av);
extern CGRect REAL_CBCGRectFromHV(void* hv);
extern CGRect REAL_CBCGRectFromSV(void* sv);

// Converting CGRect structs to blessed scalar references
extern void* REAL_CBCGRectToSV(CGRect rect);

// Creating NSRange structs
extern NSRange REAL_CBRangeFromAV(void* av);
extern NSRange REAL_CBRangeFromHV(void* hv);
extern NSRange REAL_CBRangeFromSV(void* sv);

// Converting NSRange structs to blessed scalar references
extern void* REAL_CBRangeToSV(NSRange range);

#if !TARGET_OS_IPHONE
// Creating NSSize structs
extern NSSize REAL_CBSizeFromAV(void* av);
extern NSSize REAL_CBSizeFromHV(void* hv);
extern NSSize REAL_CBSizeFromSV(void* sv);

// Converting NSSize structs to blessed scalar references
extern void* REAL_CBSizeToSV(NSSize size);
#endif

// Creating CGSize structs
extern CGSize REAL_CBCGSizeFromAV(void* av);
extern CGSize REAL_CBCGSizeFromHV(void* hv);
extern CGSize REAL_CBCGSizeFromSV(void* sv);

// Converting CGSize structs to blessed scalar references
extern void* REAL_CBCGSizeToSV(CGSize size);


// The following aren't needed on GNUStep
#ifndef GNUSTEP
// Creating OSType structs
extern OSType REAL_CBOSTypeFromSV(void* sv);

// Converting OSType structs to blessed scalar references
extern void* REAL_CBOSTypeToSV(OSType type);
#endif


