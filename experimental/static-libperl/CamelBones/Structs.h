//
//  Structs.h
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import <Foundation/Foundation.h>

// Creating NSPoint structs
NSPoint CBPointFromAV(void* av);
NSPoint CBPointFromHV(void* hv);
NSPoint CBPointFromSV(void* sv);

// Converting NSPoint structs to blessed scalar references
void* CBPointToSV(NSPoint point);

// Creating NSRect structs
NSRect CBRectFromAV(void* av);
NSRect CBRectFromHV(void* hv);
NSRect CBRectFromSV(void* sv);

// Converting NSRect structs to blessed scalar references
void* CBRectToSV(NSRect rect);

// Creating NSRange structs
NSRange CBRangeFromAV(void* av);
NSRange CBRangeFromHV(void* hv);
NSRange CBRangeFromSV(void* sv);

// Converting NSRange structs to blessed scalar references
void* CBRangeToSV(NSRange range);

// Creating NSSize structs
NSSize CBSizeFromAV(void* av);
NSSize CBSizeFromHV(void* hv);
NSSize CBSizeFromSV(void* sv);

// Converting NSSize structs to blessed scalar references
void* CBSizeToSV(NSSize size);

// The following aren't needed on GNUStep
#ifndef GNUSTEP
// Creating OSType structs
OSType CBOSTypeFromSV(void* sv);

// Converting OSType structs to blessed scalar references
void* CBOSTypeToSV(OSType type);
#endif
