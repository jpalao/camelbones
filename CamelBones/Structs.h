//
//  Structs.h
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

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

#if !TARGET_OS_IPHONE
// Creating NSRect structs
extern NSRect CBRectFromAV(void* av);
extern NSRect CBRectFromHV(void* hv);
extern NSRect CBRectFromSV(void* sv);

// Converting NSRect structs to blessed scalar references
extern void* CBRectToSV(NSRect rect);
#endif

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

// The following aren't needed on GNUStep
#ifndef GNUSTEP
// Creating OSType structs
extern OSType CBOSTypeFromSV(void* sv);

// Converting OSType structs to blessed scalar references
extern void* CBOSTypeToSV(OSType type);
#endif

extern CGAffineTransform CBCGAffineTransformFromAV(void* av);
extern CGAffineTransform CBCGAffineTransformFromHV(void* hv);
extern CGAffineTransform CBCGAffineTransformFromSV(void* sv);
extern void* CBCGAffineTransformToSV(CGAffineTransform cStruct);
extern CGPathElement CBCGPathElementFromAV(void* av);
extern CGPathElement CBCGPathElementFromHV(void* hv);
extern CGPathElement CBCGPathElementFromSV(void* sv);
extern void* CBCGPathElementToSV(CGPathElement cStruct);
extern CGPoint CBCGPointFromAV(void* av);
extern CGPoint CBCGPointFromHV(void* hv);
extern CGPoint CBCGPointFromSV(void* sv);
extern void* CBCGPointToSV(CGPoint cStruct);
extern CGRect CBCGRectFromAV(void* av);
extern CGRect CBCGRectFromHV(void* hv);
extern CGRect CBCGRectFromSV(void* sv);
extern void* CBCGRectToSV(CGRect cStruct);
extern CGSize CBCGSizeFromAV(void* av);
extern CGSize CBCGSizeFromHV(void* hv);
extern CGSize CBCGSizeFromSV(void* sv);
extern void* CBCGSizeToSV(CGSize cStruct);
extern CGVector CBCGVectorFromAV(void* av);
extern CGVector CBCGVectorFromHV(void* hv);
extern CGVector CBCGVectorFromSV(void* sv);
extern void* CBCGVectorToSV(CGVector cStruct);

#if !TARGET_OS_IPHONE
extern CGDeviceColor CBCGDeviceColorFromAV(void* av);
extern CGDeviceColor CBCGDeviceColorFromHV(void* hv);
extern CGDeviceColor CBCGDeviceColorFromSV(void* sv);
extern void* CBCGDeviceColorToSV(CGDeviceColor cStruct);
extern CGEventTapInformation CBCGEventTapInformationFromAV(void* av);
extern CGEventTapInformation CBCGEventTapInformationFromHV(void* hv);
extern CGEventTapInformation CBCGEventTapInformationFromSV(void* sv);
extern void* CBCGEventTapInformationToSV(CGEventTapInformation cStruct);
extern CGScreenUpdateMoveDelta CBCGScreenUpdateMoveDeltaFromAV(void* av);
extern CGScreenUpdateMoveDelta CBCGScreenUpdateMoveDeltaFromHV(void* hv);
extern CGScreenUpdateMoveDelta CBCGScreenUpdateMoveDeltaFromSV(void* sv);
extern void* CBCGScreenUpdateMoveDeltaToSV(CGScreenUpdateMoveDelta cStruct);
#endif










