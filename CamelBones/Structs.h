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
// Creating NSPoint structs
#if !TARGET_OS_IPHONE
extern NSPoint (*CBPointFromAV)(void* av);
extern NSPoint (*CBPointFromHV)(void* hv);
extern NSPoint (*CBPointFromSV)(void* sv);
#endif

extern CGPoint (*CBCGPointFromAV)(void* av);
extern CGPoint (*CBCGPointFromHV)(void* hv);
extern CGPoint (*CBCGPointFromSV)(void* sv);


// Converting NSPoint structs to blessed scalar references
#if !TARGET_OS_IPHONE
extern void* (*CBPointToSV)(NSPoint point);
#endif
extern void* (*CBCGPointToSV)(CGPoint point);

// Creating NSRect structs
#if !TARGET_OS_IPHONE
extern NSRect (*CBRectFromAV)(void* av);
extern NSRect (*CBRectFromHV)(void* hv);
extern NSRect (*CBRectFromSV)(void* sv);
#endif
extern CGRect (*CBCGRectFromAV)(void* av);
extern CGRect (*CBCGRectFromHV)(void* hv);
extern CGRect (*CBCGRectFromSV)(void* sv);

// Converting NSRect structs to blessed scalar references
#if !TARGET_OS_IPHONE
extern void* (*CBRectToSV)(NSRect rect);
#endif
extern void* (*CBCGRectToSV)(CGRect rect);

// Creating NSRange structs
extern NSRange (*CBRangeFromAV)(void* av);
extern NSRange (*CBRangeFromHV)(void* hv);
extern NSRange (*CBRangeFromSV)(void* sv);

// Converting NSRange structs to blessed scalar references
extern void* (*CBRangeToSV)(NSRange range);

// Creating NSSize structs
#if !TARGET_OS_IPHONE
extern NSSize (*CBSizeFromAV)(void* av);
extern NSSize (*CBSizeFromHV)(void* hv);
extern NSSize (*CBSizeFromSV)(void* sv);
#endif
extern CGSize (*CBCGSizeFromAV)(void* av);
extern CGSize (*CBCGSizeFromHV)(void* hv);
extern CGSize (*CBCGSizeFromSV)(void* sv);

// Converting NSSize structs to blessed scalar references
#if !TARGET_OS_IPHONE
extern void* (*CBSizeToSV)(NSSize size);
#endif
extern void* (*CBCGSizeToSV)(CGSize size);

// The following aren't needed on GNUStep
#ifndef GNUSTEP
// Creating OSType structs
extern OSType (*CBOSTypeFromSV)(void* sv);

// Converting OSType structs to blessed scalar references
extern void* (*CBOSTypeToSV)(OSType type);
#endif
