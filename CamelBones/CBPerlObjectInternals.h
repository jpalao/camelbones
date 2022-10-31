//
//  CBPerlObjectInternals.h
//  Camel Bones - a bare-bones Perl bridge for Objective-C
//  Originally written for ShuX
//
//  Copyright (c) 2002-2010 Sherm Pendley. All rights reserved.

#import "CBPerlObject.h"

#ifdef GNUSTEP
#import <objc/objc-api.h>
#else
#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#elif TARGET_OS_MAC
#import <objc/objc-class.h>
#import <objc/objc.h>
#endif

#endif

#if TARGET_OS_IPHONE
#import <CoreGraphics/CoreGraphics.h>
#endif

union _CB_OBJC_T {
    unsigned long uint;
    long sint;
    unsigned long ulong;
    long slong;
    float sfloat;
    double dfloat;
    char *char_p;
    const char *cchar_p;
    id id_p;
    void *void_p;
    Class class_p;
    SEL sel_p;
    NSRange range_s;
#if !(TARGET_OS_IPHONE)
    NSPoint point_s;
    NSRect rect_s;
    NSSize size_s;
#endif
    CGPoint cgpoint_s;
    CGRect cgrect_s;
    CGSize cgsize_s;
};
typedef union _CB_OBJC_T CB_ObjCType;


@interface CBPerlObject (Internals)

+ (CBPerlObject *) objectWithSV: (void *)newSV;
- (CBPerlObject *) initObjectWithSV: (void *)newSV;

- (void *)getSV;
// - (void *)getHV;

@end
