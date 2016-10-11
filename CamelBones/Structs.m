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
    PERL_SET_CONTEXT(_CBPerlInterpreter);
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
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&point, sizeof(NSPoint));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSPoint",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}
#endif

CGPoint CBCGPointFromAV(void* av) {
    CGPoint newPoint;
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

CGPoint CBCGPointFromHV(void* hv) {
    CGPoint newPoint;
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

CGPoint CBCGPointFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    CGPoint newPoint;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGPoint") ||
            sv_derived_from((SV*)sv,"CamelBones::NSPoint")) {
            pv = SvPV_nolen(target);
            memcpy(&newPoint, pv, sizeof(CGPoint));
            return newPoint;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGPointFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGPointFromHV((void*)target);
        }
    }

    return newPoint;
}


// Converting NSPoint structs to blessed scalar references
void* CBCGPointToSV(CGPoint point) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&point, sizeof(CGPoint));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGPoint",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}

#if !TARGET_OS_IPHONE
// Creating NSRect structs
NSRect CBRectFromAV(void* av) {
    NSRect newRect;
    CBPerlArray *arr;
    
    arr = [CBPerlArray arrayWithAV:av];
#if defined(__i386__) || defined(_ARM_ARCH_7)
    newRect.origin.x = [[arr objectAtIndex:0] floatValue];
    newRect.origin.y = [[arr objectAtIndex:1] floatValue];
    newRect.size.width = [[arr objectAtIndex:2] floatValue];
    newRect.size.height = [[arr objectAtIndex:3] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
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
#if defined(__i386__) || defined(_ARM_ARCH_7)
    newRect.origin.x = [[dict objectForKey:@"x"] floatValue];
    newRect.origin.y = [[dict objectForKey:@"y"] floatValue];
    newRect.size.width = [[dict objectForKey:@"width"] floatValue];
    newRect.size.height = [[dict objectForKey:@"height"] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
    newRect.origin.x = [[dict objectForKey:@"x"] doubleValue];
    newRect.origin.y = [[dict objectForKey:@"y"] doubleValue];
    newRect.size.width = [[dict objectForKey:@"width"] doubleValue];
    newRect.size.height = [[dict objectForKey:@"height"] doubleValue];
#endif

    return newRect;
}

NSRect CBRectFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
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
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&rect, sizeof(NSRect));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSRect",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}
#endif

// Creating CGRect structs
CGRect CBCGRectFromAV(void* av) {
    CGRect newRect;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];
#if defined(__i386__) || defined(_ARM_ARCH_7)
    newRect.origin.x = [[arr objectAtIndex:0] floatValue];
    newRect.origin.y = [[arr objectAtIndex:1] floatValue];
    newRect.size.width = [[arr objectAtIndex:2] floatValue];
    newRect.size.height = [[arr objectAtIndex:3] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
    newRect.origin.x = [[arr objectAtIndex:0] doubleValue];
    newRect.origin.y = [[arr objectAtIndex:1] doubleValue];
    newRect.size.width = [[arr objectAtIndex:2] doubleValue];
    newRect.size.height = [[arr objectAtIndex:3] doubleValue];
#endif

    return newRect;
}

CGRect CBCGRectFromHV(void* hv) {
    CGRect newRect;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];

#if defined(__i386__) || defined(_ARM_ARCH_7)
    newRect.origin.x = [[dict objectForKey:@"x"] floatValue];
    newRect.origin.y = [[dict objectForKey:@"y"] floatValue];
    newRect.size.width = [[dict objectForKey:@"width"] floatValue];
    newRect.size.height = [[dict objectForKey:@"height"] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
    newRect.origin.x = [[dict objectForKey:@"x"] doubleValue];
    newRect.origin.y = [[dict objectForKey:@"y"] doubleValue];
    newRect.size.width = [[dict objectForKey:@"width"] doubleValue];
    newRect.size.height = [[dict objectForKey:@"height"] doubleValue];
#endif

    return newRect;
}

CGRect CBCGRectFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    CGRect newRect;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGRect") ||
            sv_derived_from((SV*)sv,"CamelBones::NSRect")) {
            pv = SvPV_nolen(target);
            memcpy(&newRect, pv, sizeof(CGRect));
            return newRect;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGRectFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGRectFromHV((void*)target);
        }
    }

    return newRect;
}

// Converting CGRect structs to blessed scalar references
void* CBCGRectToSV(CGRect rect) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&rect, sizeof(CGRect));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGRect",TRUE));
    SvREFCNT_inc(thingRef);
    return thingRef;
}

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
    PERL_SET_CONTEXT(_CBPerlInterpreter);
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
    PERL_SET_CONTEXT(_CBPerlInterpreter);
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
#if defined(__i386__) || defined(_ARM_ARCH_7)
    newSize.width = [[arr objectAtIndex:0] floatValue];
    newSize.height = [[arr objectAtIndex:1] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
    newSize.width = [[arr objectAtIndex:0] doubleValue];
    newSize.height = [[arr objectAtIndex:1] doubleValue];
#endif

    return newSize;
}
NSSize CBSizeFromHV(void* hv) {
    NSSize newSize;
    CBPerlHash *dict;
    
    dict = [CBPerlHash dictionaryWithHV:hv];
#if defined(__i386__) || defined(_ARM_ARCH_7)
    newSize.width = [[dict objectForKey:@"width"] floatValue];
    newSize.height = [[dict objectForKey:@"height"] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
    newSize.width = [[dict objectForKey:@"width"] doubleValue];
    newSize.height = [[dict objectForKey:@"height"] doubleValue];
#endif


    return newSize;
}
NSSize CBSizeFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
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
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&size, sizeof(NSSize));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSSize",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}
#endif

// Creating CGSize structs
CGSize CBCGSizeFromAV(void* av) {
    CGSize newSize;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];
#if defined(__i386__) || defined(_ARM_ARCH_7)
    newSize.width = [[arr objectAtIndex:0] floatValue];
    newSize.height = [[arr objectAtIndex:1] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
    newSize.width = [[arr objectAtIndex:0] doubleValue];
    newSize.height = [[arr objectAtIndex:1] doubleValue];
#endif


    return newSize;
}

CGSize CBCGSizeFromHV(void* hv) {
    CGSize newSize;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];
#if defined(__i386__) || defined(_ARM_ARCH_7)
    newSize.width = [[dict objectForKey:@"width"] floatValue];
    newSize.height = [[dict objectForKey:@"height"] floatValue];
#endif
#if defined(__x86_64__) || defined(__arm64__)
    newSize.width = [[dict objectForKey:@"width"] doubleValue];
    newSize.height = [[dict objectForKey:@"height"] doubleValue];
#endif


    return newSize;
}
CGSize CBCGSizeFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    CGSize newSize;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGSize") ||
            sv_derived_from((SV*)sv,"CamelBones::NSSize")) {
            pv = SvPV_nolen(target);
            memcpy(&newSize, pv, sizeof(CGSize));
            return newSize;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return CBCGSizeFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return CBCGSizeFromHV((void*)target);
        }
    }

    return newSize;
}

// Converting CGSize structs to blessed scalar references
void* CBCGSizeToSV(CGSize size) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&size, sizeof(CGSize));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::CGSize",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}

#ifndef GNUSTEP
// Creating OSType structs
OSType CBOSTypeFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
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
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&type, sizeof(OSType));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::OSType",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}
#endif
