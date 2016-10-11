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
extern NSPoint CBPointFromAV(void* av);
extern NSPoint CBPointFromHV(void* hv);
extern NSPoint CBPointFromSV(void* sv);


// Converting NSPoint structs to blessed scalar references
extern void* CBPointToSV(NSPoint point);
#endif

// Creating CGPoint structs
extern CGPoint CBCGPointFromAV(void* av);
extern CGPoint CBCGPointFromHV(void* hv);
extern CGPoint CBCGPointFromSV(void* sv);

// Converting CGPoint structs to blessed scalar references
extern void* CBCGPointToSV(CGPoint point);

#if !TARGET_OS_IPHONE
// Creating NSRect structs
extern NSRect CBRectFromAV(void* av);
extern NSRect CBRectFromHV(void* hv);
extern NSRect CBRectFromSV(void* sv);

// Converting NSRect structs to blessed scalar references
extern void* CBRectToSV(NSRect rect);
#endif

// Creating CGRect structs
extern CGRect CBCGRectFromAV(void* av);
extern CGRect CBCGRectFromHV(void* hv);
extern CGRect CBCGRectFromSV(void* sv);

// Converting CGRect structs to blessed scalar references
extern void* CBCGRectToSV(CGRect rect);

// Creating NSRange structs
extern NSRange CBRangeFromAV(void* av);
extern NSRange CBRangeFromHV(void* hv);
extern NSRange CBRangeFromSV(void* sv);

// Converting NSRange structs to blessed scalar references
extern void* CBRangeToSV(NSRange range);

#if !TARGET_OS_IPHONE
// Creating NSSize structs
extern NSSize CBSizeFromAV(void* av);
extern NSSize CBSizeFromHV(void* hv);
extern NSSize CBSizeFromSV(void* sv);

// Converting NSSize structs to blessed scalar references
extern void* CBSizeToSV(NSSize size);
#endif

// Creating CGSize structs
extern CGSize CBCGSizeFromAV(void* av);
extern CGSize CBCGSizeFromHV(void* hv);
extern CGSize CBCGSizeFromSV(void* sv);

// Converting CGSize structs to blessed scalar references
extern void* CBCGSizeToSV(CGSize size);


// The following aren't needed on GNUStep
#ifndef GNUSTEP
// Creating OSType structs
extern OSType CBOSTypeFromSV(void* sv);

// Converting OSType structs to blessed scalar references
extern void* CBOSTypeToSV(OSType type);
#endif


