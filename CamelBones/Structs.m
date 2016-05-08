//
//  Structs.m
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "Structs_real.h"
#import "CBPerlArray.h"
#import "CBPerlArrayInternals.h"
#import "CBPerlHash.h"
#import "CBPerlHashInternals.h"

// Creating NSPoint structs
NSPoint REAL_CBPointFromAV(void* av) {
    NSPoint newPoint;
    CBPerlArray *arr;
    
    arr = [CBPerlArray arrayWithAV:av];
#ifdef __i386__
    newPoint.x = [[arr objectAtIndex:0] floatValue];
    newPoint.y = [[arr objectAtIndex:1] floatValue];
#endif
#ifdef __x86_64__
    newPoint.x = [[arr objectAtIndex:0] doubleValue];
    newPoint.y = [[arr objectAtIndex:1] doubleValue];
#endif


    return newPoint;
}

NSPoint REAL_CBPointFromHV(void* hv) {
    NSPoint newPoint;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];
#ifdef __i386__
    newPoint.x = [[dict objectForKey:@"x"] floatValue];
    newPoint.y = [[dict objectForKey:@"y"] floatValue];
#endif
#ifdef __x86_64__
    newPoint.x = [[dict objectForKey:@"x"] doubleValue];
    newPoint.y = [[dict objectForKey:@"y"] doubleValue];
#endif

    return newPoint;
}

NSPoint REAL_CBPointFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

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
            return REAL_CBPointFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return REAL_CBPointFromHV((void*)target);
        }
    }

    return newPoint;
}

// Converting NSPoint structs to blessed scalar references
void* REAL_CBPointToSV(NSPoint point) {
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

CGPoint REAL_CBCGPointFromAV(void* av) {
    CGPoint newPoint;
    CBPerlArray *arr;

    arr = [CBPerlArray arrayWithAV:av];
#ifdef __i386__
    newPoint.x = [[arr objectAtIndex:0] floatValue];
    newPoint.y = [[arr objectAtIndex:1] floatValue];
#endif
#ifdef __x86_64__
    newPoint.x = [[arr objectAtIndex:0] doubleValue];
    newPoint.y = [[arr objectAtIndex:1] doubleValue];
#endif

    return newPoint;
}

CGPoint REAL_CBCGPointFromHV(void* hv) {
    CGPoint newPoint;
    CBPerlHash *dict;

    dict = [CBPerlHash dictionaryWithHV:hv];
#ifdef __i386__
    newPoint.x = [[dict objectForKey:@"x"] floatValue];
    newPoint.y = [[dict objectForKey:@"y"] floatValue];
#endif
#ifdef __x86_64__
    newPoint.x = [[dict objectForKey:@"x"] doubleValue];
    newPoint.y = [[dict objectForKey:@"y"] doubleValue];
#endif

    return newPoint;
}

CGPoint REAL_CBCGPointFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    CGPoint newPoint;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGPoint")) {
            pv = SvPV_nolen(target);
            memcpy(&newPoint, pv, sizeof(CGPoint));
            return newPoint;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return REAL_CBCGPointFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return REAL_CBCGPointFromHV((void*)target);
        }
    }

    return newPoint;
}


// Converting NSPoint structs to blessed scalar references
void* REAL_CBCGPointToSV(CGPoint point) {
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


// Creating NSRect structs
NSRect REAL_CBRectFromAV(void* av) {
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

NSRect REAL_CBRectFromHV(void* hv) {
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

NSRect REAL_CBRectFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

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
            return REAL_CBRectFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return REAL_CBRectFromHV((void*)target);
        }
    }

    return newRect;
}

// Converting NSRect structs to blessed scalar references

void* REAL_CBRectToSV(NSRect rect) {
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

// Creating CGRect structs
CGRect REAL_CBCGRectFromAV(void* av) {
    CGRect newRect;
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

CGRect REAL_CBCGRectFromHV(void* hv) {
    CGRect newRect;
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

CGRect REAL_CBCGRectFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    CGRect newRect;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGRect")) {
            pv = SvPV_nolen(target);
            memcpy(&newRect, pv, sizeof(CGRect));
            return newRect;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return REAL_CBCGRectFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return REAL_CBCGRectFromHV((void*)target);
        }
    }

    return newRect;
}

// Converting CGRect structs to blessed scalar references
void* REAL_CBCGRectToSV(CGRect rect) {
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
NSRange REAL_CBRangeFromAV(void* av) {
    NSRange newRange;
    CBPerlArray *arr;
    
    arr = [CBPerlArray arrayWithAV:av];
    newRange.location = [[arr objectAtIndex:0] intValue];
    newRange.length = [[arr objectAtIndex:1] intValue];

    return newRange;
}

NSRange REAL_CBRangeFromHV(void* hv) {
    NSRange newRange;
    CBPerlHash *dict;
    
    dict = [CBPerlHash dictionaryWithHV:hv];
    newRange.location = [[dict objectForKey:@"location"] intValue];
    newRange.length = [[dict objectForKey:@"length"] intValue];

    return newRange;
}

NSRange REAL_CBRangeFromSV(void* sv) {
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
            return REAL_CBRangeFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return REAL_CBRangeFromHV((void*)target);
        }
    }

    return newRange;
}

// Converting NSRange structs to blessed scalar references
void* REAL_CBRangeToSV(NSRange range) {
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

// Creating NSSize structs
NSSize REAL_CBSizeFromAV(void* av) {
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
NSSize REAL_CBSizeFromHV(void* hv) {
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
NSSize REAL_CBSizeFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

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
            return REAL_CBSizeFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return REAL_CBSizeFromHV((void*)target);
        }
    }

    return newSize;
}

// Converting NSSize structs to blessed scalar references
void* REAL_CBSizeToSV(NSSize size) {
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

// Creating CGSize structs
CGSize REAL_CBCGSizeFromAV(void* av) {
    CGSize newSize;
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

CGSize REAL_CBCGSizeFromHV(void* hv) {
    CGSize newSize;
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
CGSize REAL_CBCGSizeFromSV(void* sv) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    CGSize newSize;
    SV *target;
    char *pv;

    if (SvROK((SV*)sv)) {
        target = SvRV((SV*)sv);
        if (sv_derived_from((SV*)sv,"CamelBones::CGSize")) {
            pv = SvPV_nolen(target);
            memcpy(&newSize, pv, sizeof(CGSize));
            return newSize;
        } else if (SvTYPE(target) == SVt_PVAV) {
            return REAL_CBCGSizeFromAV((void*)target);
        } else if (SvTYPE(target) == SVt_PVHV) {
            return REAL_CBCGSizeFromHV((void*)target);
        }
    }

    return newSize;
}

// Converting CGSize structs to blessed scalar references
void* REAL_CBCGSizeToSV(CGSize size) {
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
OSType REAL_CBOSTypeFromSV(void* sv) {
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
void* REAL_CBOSTypeToSV(OSType type) {
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
