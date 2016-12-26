//
//  Structs.m
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#endif
#import "CBPerl.h"
#import "Structs.h"
#import "CBPerlArray.h"
#import "CBPerlArrayInternals.h"
#import "CBPerlHash.h"
#import "CBPerlHashInternals.h"

#if !TARGET_OS_IPHONE
// Creating NSPoint structs
NSPoint CBPointFromAV(void* av) {
    NSPoint newPoint;
    CBPerlArray *arr;
    
    arr = [CBPerlArray arrayWithAV:av];
#if defined(__i386__) || defined(_ARM_ARCH_7)
    newPoint.x = [[arr objectAtIndex:0] floatValue];
    newPoint.y = [[arr objectAtIndex:1] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
    newPoint.x = [[arr objectAtIndex:0] doubleValue];
    newPoint.y = [[arr objectAtIndex:1] doubleValue];
#endif

    return newPoint;
}

NSPoint CBPointFromHV(void* hv) {
    NSPoint newPoint;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];
#if defined(__i386__) || defined(_ARM_ARCH_7)
    newPoint.x = [[dict objectForKey:@"x"] floatValue];
    newPoint.y = [[dict objectForKey:@"y"] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
    newPoint.x = [[dict objectForKey:@"x"] doubleValue];
    newPoint.y = [[dict objectForKey:@"y"] doubleValue];
#endif

    return newPoint;
}

NSPoint CBPointFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    NSPoint newPoint;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::NSPoint") ||
            sv_derived_from((SV*)sv,"CamelBones::CGPoint")) {
            pv = SvPV_nolen(target);
            memcpy(&newPoint, pv, sizeof(NSPoint));
            return newPoint;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBPointFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBPointFromHV((void*)target);
        }
    }

    return newPoint;
}

// Converting NSPoint structs to blessed scalar references
void* CBPointToSV(NSPoint point) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&point, sizeof(NSPoint));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSPoint",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}
#endif



#if !TARGET_OS_IPHONE
// Creating NSRect structs
NSRect CBRectFromAV(void* av) {
    NSRect newRect;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];
#ifdef __i386__
    newRect.origin.x = [[arr objectAtIndex:0] floatValue];
    newRect.origin.y = [[arr objectAtIndex:1] floatValue];
    newRect.size.width = [[arr objectAtIndex:2] floatValue];
    newRect.size.height = [[arr objectAtIndex:3] floatValue];
#endif
#ifdef __x86_64__
    newRect.origin.x = [[arr objectAtIndex:0] doubleValue];
    newRect.origin.y = [[arr objectAtIndex:1] doubleValue];
    newRect.size.width = [[arr objectAtIndex:2] doubleValue];
    newRect.size.height = [[arr objectAtIndex:3] doubleValue];
#endif

    return newRect;
}

NSRect CBRectFromHV(void* hv) {
    NSRect newRect;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];
#ifdef __i386__
    newRect.origin.x = [[dict objectForKey:@"x"] floatValue];
    newRect.origin.y = [[dict objectForKey:@"y"] floatValue];
    newRect.size.width = [[dict objectForKey:@"width"] floatValue];
    newRect.size.height = [[dict objectForKey:@"height"] floatValue];
#endif
#ifdef __x86_64__
    newRect.origin.x = [[dict objectForKey:@"x"] doubleValue];
    newRect.origin.y = [[dict objectForKey:@"y"] doubleValue];
    newRect.size.width = [[dict objectForKey:@"width"] doubleValue];
    newRect.size.height = [[dict objectForKey:@"height"] doubleValue];
#endif

    return newRect;
}

NSRect CBRectFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    NSRect newRect;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::NSRect") ||
            sv_derived_from((SV*)sv,"CamelBones::CGRect")) {
            pv = SvPV_nolen(target);
            memcpy(&newRect, pv, sizeof(NSRect));
            return newRect;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBRectFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBRectFromHV((void*)target);
        }
    }

    return newRect;
}

// Converting NSRect structs to blessed scalar references

void* CBRectToSV(NSRect rect) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&rect, sizeof(NSRect));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSRect",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}
#endif



// Creating NSRange structs
NSRange CBRangeFromAV(void* av) {
    NSRange newRange;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];
    newRange.location = [[arr objectAtIndex:0] intValue];
    newRange.length = [[arr objectAtIndex:1] intValue];

    return newRange;
}

NSRange CBRangeFromHV(void* hv) {
    NSRange newRange;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];
    newRange.location = [[dict objectForKey:@"location"] intValue];
    newRange.length = [[dict objectForKey:@"length"] intValue];

    return newRange;
}

NSRange CBRangeFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    NSRange newRange;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::NSRange")) {
            pv = SvPV_nolen(target);
            memcpy(&newRange, pv, sizeof(NSRange));
            return newRange;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBRangeFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBRangeFromHV((void*)target);
        }
    }

    return newRange;
}

// Converting NSRange structs to blessed scalar references
void* CBRangeToSV(NSRange range) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&range, sizeof(NSRange));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSRange",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}

#if !TARGET_OS_IPHONE
// Creating NSSize structs
NSSize CBSizeFromAV(void* av) {
    NSSize newSize;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];
#ifdef __i386__
    newSize.width = [[arr objectAtIndex:0] floatValue];
    newSize.height = [[arr objectAtIndex:1] floatValue];
#endif
#ifdef __x86_64__
    newSize.width = [[arr objectAtIndex:0] doubleValue];
    newSize.height = [[arr objectAtIndex:1] doubleValue];
#endif

    return newSize;
}
NSSize CBSizeFromHV(void* hv) {
    NSSize newSize;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];
#ifdef __i386__
    newSize.width = [[dict objectForKey:@"width"] floatValue];
    newSize.height = [[dict objectForKey:@"height"] floatValue];
#endif
#ifdef __x86_64__
    newSize.width = [[dict objectForKey:@"width"] doubleValue];
    newSize.height = [[dict objectForKey:@"height"] doubleValue];
#endif


    return newSize;
}
NSSize CBSizeFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    NSSize newSize;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::NSSize") ||
            sv_derived_from((SV*)sv,"CamelBones::CGSize")) {
            pv = SvPV_nolen(target);
            memcpy(&newSize, pv, sizeof(NSSize));
            return newSize;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBSizeFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBSizeFromHV((void*)target);
        }
    }

    return newSize;
}

// Converting NSSize structs to blessed scalar references
void* CBSizeToSV(NSSize size) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&size, sizeof(NSSize));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSSize",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}
#endif



#ifndef GNUSTEP
// Creating OSType structs
OSType CBOSTypeFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    OSType newType = 0;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::OSType")) {
            pv = SvPV_nolen(target);
            memcpy(&newType, pv, sizeof(OSType));
            return newType;
        }
    }

    return newType;
}

// Converting OSType structs to blessed scalar references
void* CBOSTypeToSV(OSType type) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&type, sizeof(OSType));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::OSType",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}
#endif

// Creating CGAffineTransform structs
CGAffineTransform CBCGAffineTransformFromAV(void* av) {
    CGAffineTransform newStruct;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.a        = [[arr objectAtIndex:0] doubleValue];
    newStruct.b        = [[arr objectAtIndex:1] doubleValue];
    newStruct.c        = [[arr objectAtIndex:2] doubleValue];
    newStruct.d        = [[arr objectAtIndex:3] doubleValue];
    newStruct.tx        = [[arr objectAtIndex:4] doubleValue];
    newStruct.ty        = [[arr objectAtIndex:5] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.a        = [[arr objectAtIndex:0] floatValue];
    newStruct.b        = [[arr objectAtIndex:1] floatValue];
    newStruct.c        = [[arr objectAtIndex:2] floatValue];
    newStruct.d        = [[arr objectAtIndex:3] floatValue];
    newStruct.tx        = [[arr objectAtIndex:4] floatValue];
    newStruct.ty        = [[arr objectAtIndex:5] floatValue];
#endif

    return newStruct;
}

CGAffineTransform CBCGAffineTransformFromHV(void* hv) {
    CGAffineTransform newStruct;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.a        = [[dict objectForKey:@"a"] doubleValue];
    newStruct.b        = [[dict objectForKey:@"b"] doubleValue];
    newStruct.c        = [[dict objectForKey:@"c"] doubleValue];
    newStruct.d        = [[dict objectForKey:@"d"] doubleValue];
    newStruct.tx        = [[dict objectForKey:@"tx"] doubleValue];
    newStruct.ty        = [[dict objectForKey:@"ty"] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.a        = [[dict objectForKey:@"a"] floatValue];
    newStruct.b        = [[dict objectForKey:@"b"] floatValue];
    newStruct.c        = [[dict objectForKey:@"c"] floatValue];
    newStruct.d        = [[dict objectForKey:@"d"] floatValue];
    newStruct.tx        = [[dict objectForKey:@"tx"] floatValue];
    newStruct.ty        = [[dict objectForKey:@"ty"] floatValue];
#endif

    return newStruct;
}

CGAffineTransform CBCGAffineTransformFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    CGAffineTransform newStruct;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGAffineTransform")) {
            pv = SvPV_nolen(target);
            memcpy(&newStruct, pv, sizeof(CGAffineTransform));
            return newStruct;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGAffineTransformFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGAffineTransformFromHV((void*)target);
        }
    }

    return newStruct;
}

// Converting CGAffineTransform structs to blessed scalar references
void* CBCGAffineTransformToSV(CGAffineTransform cStruct) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&cStruct, sizeof(CGAffineTransform));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGAffineTransform",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}

#if !TARGET_OS_IPHONE

// Creating CGDeviceColor structs
CGDeviceColor CBCGDeviceColorFromAV(void* av) {
    CGDeviceColor newStruct;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];

#if defined(__x86_64__) || defined(__arm64__)
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.red        = [[arr objectAtIndex:0] floatValue];
    newStruct.green        = [[arr objectAtIndex:1] floatValue];
    newStruct.blue        = [[arr objectAtIndex:2] floatValue];
#endif

    return newStruct;
}

CGDeviceColor CBCGDeviceColorFromHV(void* hv) {
    CGDeviceColor newStruct;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__x86_64__) || defined(__arm64__)
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.red        = [[dict objectForKey:@"red"] floatValue];
    newStruct.green        = [[dict objectForKey:@"green"] floatValue];
    newStruct.blue        = [[dict objectForKey:@"blue"] floatValue];
#endif

    return newStruct;
}

CGDeviceColor CBCGDeviceColorFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    CGDeviceColor newStruct;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGDeviceColor")) {
            pv = SvPV_nolen(target);
            memcpy(&newStruct, pv, sizeof(CGDeviceColor));
            return newStruct;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGDeviceColorFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGDeviceColorFromHV((void*)target);
        }
    }

    return newStruct;
}

// Converting CGDeviceColor structs to blessed scalar references
void* CBCGDeviceColorToSV(CGDeviceColor cStruct) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&cStruct, sizeof(CGDeviceColor));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGDeviceColor",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}


// Creating CGEventTapInformation structs
CGEventTapInformation CBCGEventTapInformationFromAV(void* av) {
    CGEventTapInformation newStruct;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];

#if defined(__x86_64__) || defined(__arm64__)
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.eventTapID        = [[arr objectAtIndex:0] unsignedIntegerValue];
    newStruct.tapPoint        = [[arr objectAtIndex:1] unsignedIntegerValue];
    newStruct.options        = [[arr objectAtIndex:2] unsignedIntegerValue];
    newStruct.eventsOfInterest        = [[arr objectAtIndex:3] unsignedLongLongValue];
    newStruct.tappingProcess        = [[arr objectAtIndex:4] integerValue];
    newStruct.processBeingTapped        = [[arr objectAtIndex:5] integerValue];
    newStruct.enabled        = [[arr objectAtIndex:6] booleanValue];
    newStruct.minUsecLatency        = [[arr objectAtIndex:7] floatValue];
    newStruct.avgUsecLatency        = [[arr objectAtIndex:8] floatValue];
    newStruct.maxUsecLatency        = [[arr objectAtIndex:9] floatValue];
#endif

    return newStruct;
}

CGEventTapInformation CBCGEventTapInformationFromHV(void* hv) {
    CGEventTapInformation newStruct;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__x86_64__) || defined(__arm64__)
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.eventTapID        = [[dict objectForKey:@"eventTapID"] unsignedIntegerValue];
    newStruct.tapPoint        = [[dict objectForKey:@"tapPoint"] unsignedIntegerValue];
    newStruct.options        = [[dict objectForKey:@"options"] unsignedIntegerValue];
    newStruct.eventsOfInterest        = [[dict objectForKey:@"eventsOfInterest"] unsignedLongLongValue];
    newStruct.tappingProcess        = [[dict objectForKey:@"tappingProcess"] integerValue];
    newStruct.processBeingTapped        = [[dict objectForKey:@"processBeingTapped"] integerValue];
    newStruct.enabled        = [[dict objectForKey:@"enabled"] booleanValue];
    newStruct.minUsecLatency        = [[dict objectForKey:@"minUsecLatency"] floatValue];
    newStruct.avgUsecLatency        = [[dict objectForKey:@"avgUsecLatency"] floatValue];
    newStruct.maxUsecLatency        = [[dict objectForKey:@"maxUsecLatency"] floatValue];
#endif

    return newStruct;
}

CGEventTapInformation CBCGEventTapInformationFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    CGEventTapInformation newStruct;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGEventTapInformation")) {
            pv = SvPV_nolen(target);
            memcpy(&newStruct, pv, sizeof(CGEventTapInformation));
            return newStruct;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGEventTapInformationFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGEventTapInformationFromHV((void*)target);
        }
    }

    return newStruct;
}

// Converting CGEventTapInformation structs to blessed scalar references
void* CBCGEventTapInformationToSV(CGEventTapInformation cStruct) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&cStruct, sizeof(CGEventTapInformation));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGEventTapInformation",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}

#endif

// Creating CGPathElement structs
CGPathElement CBCGPathElementFromAV(void* av) {
    CGPathElement newStruct;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];

#if defined(__x86_64__) || defined(__arm64__)
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.type        = [[arr objectAtIndex:0] integerValue];
    newStruct.points        = [[arr objectAtIndex:1] pointerValue];
#endif

    return newStruct;
}

CGPathElement CBCGPathElementFromHV(void* hv) {
    CGPathElement newStruct;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__x86_64__) || defined(__arm64__)
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.type        = [[dict objectForKey:@"type"] integerValue];
    newStruct.points        = [[dict objectForKey:@"points"] pointerValue];
#endif

    return newStruct;
}

CGPathElement CBCGPathElementFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    CGPathElement newStruct;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGPathElement")) {
            pv = SvPV_nolen(target);
            memcpy(&newStruct, pv, sizeof(CGPathElement));
            return newStruct;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGPathElementFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGPathElementFromHV((void*)target);
        }
    }

    return newStruct;
}

// Converting CGPathElement structs to blessed scalar references
void* CBCGPathElementToSV(CGPathElement cStruct) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&cStruct, sizeof(CGPathElement));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGPathElement",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}


// Creating CGPoint structs
CGPoint CBCGPointFromAV(void* av) {
    CGPoint newStruct;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.x        = [[arr objectAtIndex:0] doubleValue];
    newStruct.y        = [[arr objectAtIndex:1] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.x        = [[arr objectAtIndex:0] floatValue];
    newStruct.y        = [[arr objectAtIndex:1] floatValue];
#endif

    return newStruct;
}

CGPoint CBCGPointFromHV(void* hv) {
    CGPoint newStruct;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.x        = [[dict objectForKey:@"x"] doubleValue];
    newStruct.y        = [[dict objectForKey:@"y"] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.x        = [[dict objectForKey:@"x"] floatValue];
    newStruct.y        = [[dict objectForKey:@"y"] floatValue];
#endif

    return newStruct;
}

CGPoint CBCGPointFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    CGPoint newStruct;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGPoint")) {
            pv = SvPV_nolen(target);
            memcpy(&newStruct, pv, sizeof(CGPoint));
            return newStruct;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGPointFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGPointFromHV((void*)target);
        }
    }

    return newStruct;
}

// Converting CGPoint structs to blessed scalar references
void* CBCGPointToSV(CGPoint cStruct) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&cStruct, sizeof(CGPoint));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGPoint",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}


// Creating CGRect structs
CGRect CBCGRectFromAV(void* av) {
    CGRect newStruct;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.origin.x        = [[arr objectAtIndex:0] doubleValue];
    newStruct.origin.y        = [[arr objectAtIndex:1] doubleValue];
    newStruct.size.width        = [[arr objectAtIndex:2] doubleValue];
    newStruct.size.height        = [[arr objectAtIndex:3] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.origin.x        = [[arr objectAtIndex:0] floatValue];
    newStruct.origin.y        = [[arr objectAtIndex:1] floatValue];
    newStruct.size.width        = [[arr objectAtIndex:2] floatValue];
    newStruct.size.height        = [[arr objectAtIndex:3] floatValue];
#endif

    return newStruct;
}

CGRect CBCGRectFromHV(void* hv) {
    CGRect newStruct;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.origin.x        = [[dict objectForKey:@"x"] doubleValue];
    newStruct.origin.y        = [[dict objectForKey:@"y"] doubleValue];
    newStruct.size.width        = [[dict objectForKey:@"width"] doubleValue];
    newStruct.size.height        = [[dict objectForKey:@"height"] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.origin.x        = [[dict objectForKey:@"x"] floatValue];
    newStruct.origin.y        = [[dict objectForKey:@"y"] floatValue];
    newStruct.size.width        = [[dict objectForKey:@"width"] floatValue];
    newStruct.size.height        = [[dict objectForKey:@"height"] floatValue];
#endif

    return newStruct;
}

CGRect CBCGRectFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    CGRect newStruct;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGRect")) {
            pv = SvPV_nolen(target);
            memcpy(&newStruct, pv, sizeof(CGRect));
            return newStruct;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGRectFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGRectFromHV((void*)target);
        }
    }

    return newStruct;
}

// Converting CGRect structs to blessed scalar references
void* CBCGRectToSV(CGRect cStruct) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&cStruct, sizeof(CGRect));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGRect",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}

#if !TARGET_OS_IPHONE

// Creating CGScreenUpdateMoveDelta structs
CGScreenUpdateMoveDelta CBCGScreenUpdateMoveDeltaFromAV(void* av) {
    CGScreenUpdateMoveDelta newStruct;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];

#if defined(__x86_64__) || defined(__arm64__)
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.dX        = [[arr objectAtIndex:0] integerValue];
    newStruct.dY        = [[arr objectAtIndex:1] integerValue];
#endif

    return newStruct;
}

CGScreenUpdateMoveDelta CBCGScreenUpdateMoveDeltaFromHV(void* hv) {
    CGScreenUpdateMoveDelta newStruct;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__x86_64__) || defined(__arm64__)
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.dX        = [[dict objectForKey:@"dX"] integerValue];
    newStruct.dY        = [[dict objectForKey:@"dY"] integerValue];
#endif

    return newStruct;
}

CGScreenUpdateMoveDelta CBCGScreenUpdateMoveDeltaFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    CGScreenUpdateMoveDelta newStruct;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGScreenUpdateMoveDelta")) {
            pv = SvPV_nolen(target);
            memcpy(&newStruct, pv, sizeof(CGScreenUpdateMoveDelta));
            return newStruct;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGScreenUpdateMoveDeltaFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGScreenUpdateMoveDeltaFromHV((void*)target);
        }
    }

    return newStruct;
}

// Converting CGScreenUpdateMoveDelta structs to blessed scalar references
void* CBCGScreenUpdateMoveDeltaToSV(CGScreenUpdateMoveDelta cStruct) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&cStruct, sizeof(CGScreenUpdateMoveDelta));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGScreenUpdateMoveDelta",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}

#endif


// Creating CGSize structs
CGSize CBCGSizeFromAV(void* av) {
    CGSize newStruct;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.width        = [[arr objectAtIndex:0] doubleValue];
    newStruct.height        = [[arr objectAtIndex:1] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.width        = [[arr objectAtIndex:0] floatValue];
    newStruct.height        = [[arr objectAtIndex:1] floatValue];
#endif

    return newStruct;
}

CGSize CBCGSizeFromHV(void* hv) {
    CGSize newStruct;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.width        = [[dict objectForKey:@"width"] doubleValue];
    newStruct.height        = [[dict objectForKey:@"height"] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.width        = [[dict objectForKey:@"width"] floatValue];
    newStruct.height        = [[dict objectForKey:@"height"] floatValue];
#endif

    return newStruct;
}

CGSize CBCGSizeFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    CGSize newStruct;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGSize")) {
            pv = SvPV_nolen(target);
            memcpy(&newStruct, pv, sizeof(CGSize));
            return newStruct;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGSizeFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGSizeFromHV((void*)target);
        }
    }

    return newStruct;
}

// Converting CGSize structs to blessed scalar references
void* CBCGSizeToSV(CGSize cStruct) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&cStruct, sizeof(CGSize));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGSize",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}


// Creating CGVector structs
CGVector CBCGVectorFromAV(void* av) {
    CGVector newStruct;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.dx        = [[arr objectAtIndex:0] doubleValue];
    newStruct.dy        = [[arr objectAtIndex:1] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.dx        = [[arr objectAtIndex:0] floatValue];
    newStruct.dy        = [[arr objectAtIndex:1] floatValue];
#endif

    return newStruct;
}

CGVector CBCGVectorFromHV(void* hv) {
    CGVector newStruct;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__x86_64__) || defined(__arm64__)
    newStruct.dx        = [[dict objectForKey:@"dx"] doubleValue];
    newStruct.dy        = [[dict objectForKey:@"dy"] doubleValue];
#elif defined(__i386__) || defined(_ARM_ARCH_7)
    newStruct.dx        = [[dict objectForKey:@"dx"] floatValue];
    newStruct.dy        = [[dict objectForKey:@"dy"] floatValue];
#endif

    return newStruct;
}

CGVector CBCGVectorFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    CGVector newStruct;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGVector")) {
            pv = SvPV_nolen(target);
            memcpy(&newStruct, pv, sizeof(CGVector));
            return newStruct;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGVectorFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGVectorFromHV((void*)target);
        }
    }
    
    return newStruct;
}

// Converting CGVector structs to blessed scalar references
void* CBCGVectorToSV(CGVector cStruct) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;
    
    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&cStruct, sizeof(CGVector));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGVector",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}

