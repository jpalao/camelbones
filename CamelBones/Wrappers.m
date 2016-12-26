//
//  Wrappers.m
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import "CBPerl.h"
#import "Wrappers.h"
#import "PerlImports.h"

// Create a Perl object that wraps an Objective-C object
// The wrapper will be blessed into the "NSObject" package.
void* CBCreateWrapperObject(id obj) {
    return (void*)CBCreateWrapperObjectWithClassName(obj, NSStringFromClass([obj class]));
}

// Create a Perl object that wraps an Objective-C object.
// The wrapper will be blessed into className.
void* CBCreateWrapperObjectWithClassName(id obj, NSString* className) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    SV *sv = CBCreateObjectOfClass(className);
    const char *key = "NATIVE_OBJ";
    hv_store((HV*)SvRV(sv), key, (I32)strlen(key), newSViv((IV)obj), (U32)0);
    return (void*)sv;
}

// Create a new Perl object blessed into the specified package
void* CBCreateObjectOfClass(NSString *className) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    HV *hv = newHV();
    SV *ret = newRV_inc((SV *)hv);
    sv_bless(ret, gv_stashpv([className UTF8String], 0));
    return (void*)ret;
}

