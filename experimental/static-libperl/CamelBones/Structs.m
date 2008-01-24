//
//  Structs.m
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "Structs.h"
#import "CBPerlArray.h"
#import "CBPerlArrayInternals.h"
#import "CBPerlHash.h"
#import "CBPerlHashInternals.h"

// Creating NSPoint structs
NSPoint CBPointFromAV(void* av) {
    NSPoint newPoint;
    CBPerlArray *arr;
    
    arr = [CBPerlArray arrayWithAV:av];
    newPoint.x = [[arr objectAtIndex:0] floatValue];
    newPoint.y = [[arr objectAtIndex:1] floatValue];

    return newPoint;
}

NSPoint CBPointFromHV(void* hv) {
    NSPoint newPoint;
    CBPerlHash *dict;
    
    dict = [CBPerlHash dictionaryWithHV:hv];
    newPoint.x = [[dict objectForKey:@"x"] floatValue];
    newPoint.y = [[dict objectForKey:@"y"] floatValue];

    return newPoint;
}

NSPoint CBPointFromSV(void* sv) {
    NSPoint newPoint;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::NSPoint")) {
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
    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&point, sizeof(NSPoint));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSPoint",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}

// Creating NSRect structs
NSRect CBRectFromAV(void* av) {
    NSRect newRect;
    CBPerlArray *arr;
    
    arr = [CBPerlArray arrayWithAV:av];
    newRect.origin.x = [[arr objectAtIndex:0] floatValue];
    newRect.origin.y = [[arr objectAtIndex:1] floatValue];
    newRect.size.width = [[arr objectAtIndex:2] floatValue];
    newRect.size.height = [[arr objectAtIndex:3] floatValue];

    return newRect;
}

NSRect CBRectFromHV(void* hv) {
    NSRect newRect;
    CBPerlHash *dict;
    
    dict = [CBPerlHash dictionaryWithHV:hv];
    newRect.origin.x = [[dict objectForKey:@"x"] floatValue];
    newRect.origin.y = [[dict objectForKey:@"y"] floatValue];
    newRect.size.width = [[dict objectForKey:@"width"] floatValue];
    newRect.size.height = [[dict objectForKey:@"height"] floatValue];

    return newRect;
}

NSRect CBRectFromSV(void* sv) {
    NSRect newRect;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::NSRect")) {
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

// Converting NSRange structs to blessed scalar references

void* CBRectToSV(NSRect rect) {
    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&rect, sizeof(NSRect));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSRect",TRUE));
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
    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&range, sizeof(NSRange));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSRange",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}

// Creating NSSize structs
NSSize CBSizeFromAV(void* av) {
    NSSize newSize;
    CBPerlArray *arr;
    
    arr = [CBPerlArray arrayWithAV:av];
    newSize.width = [[arr objectAtIndex:0] floatValue];
    newSize.height = [[arr objectAtIndex:1] floatValue];

    return newSize;
}
NSSize CBSizeFromHV(void* hv) {
    NSSize newSize;
    CBPerlHash *dict;
    
    dict = [CBPerlHash dictionaryWithHV:hv];
    newSize.width = [[dict objectForKey:@"width"] floatValue];
    newSize.height = [[dict objectForKey:@"height"] floatValue];

    return newSize;
}
NSSize CBSizeFromSV(void* sv) {
    NSSize newSize;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::NSSize")) {
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
    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&size, sizeof(NSSize));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::NSSize",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}

#ifndef GNUSTEP
// Creating OSType structs
OSType CBOSTypeFromSV(void* sv) {
    OSType newType;
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
    SV *thing;
    SV *thingRef;
    thing = newSVpvn((char*)&type, sizeof(OSType));
    thingRef = sv_bless(newRV(thing),gv_stashpv("CamelBones::OSType",TRUE));
    SvREFCNT_inc(thingRef);
    return (void*)thingRef;
}
#endif
