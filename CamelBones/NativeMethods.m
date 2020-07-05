//
//  NativeMethods.m
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import "CBPerl.h"
#import "Conversions.h"
#import "NativeMethods.h"
#import "Structs.h"
#import "CBPerlObjectInternals.h"

#if TARGET_OS_IPHONE
#import <objc/runtime.h>
#import <objc/message.h>
#elif TARGET_OS_MAC
#import <objc/objc-runtime.h>
#import <objc/objc-class.h>
#endif

#import "PerlImports.h"
#import "perlxsi.h"

// The BYTEORDER macro is also #defined by perl, and Perl's use
// of it should be fully expanded by now.
#undef BYTEORDER

#include "ffi.h"

typedef union {
    ffi_arg uarg;
    ffi_sarg sarg;
    unsigned char schar;
    char uchar;
    unsigned short sshort;
    short ushort;
    unsigned long uint;
    long sint;
    unsigned long ulong;
    long slong;
    float ffloat;
    double fdouble;
    void *voidp;
    SEL sel;
    NSRange struct_nsrange;
#if !TARGET_OS_IPHONE
    NSPoint struct_nspoint;
    NSRect struct_nsrect;
    NSSize struct_nssize;
#endif
    CGPoint struct_cgpoint;
    CGRect struct_cgrect;
    CGSize struct_cgsize;
} arg_value;

// Define ffi_type structs for NSPoint, NSRect, NSRange, and NSSize
static int ffi_type_structs_init = 0;

static ffi_type nsrange_type;
static ffi_type *nsrange_elements[3];

#if !TARGET_OS_IPHONE
static ffi_type nspoint_type;
static ffi_type *nspoint_elements[3];

static ffi_type nssize_type;
static ffi_type *nssize_elements[3];

static ffi_type nsrect_type;
static ffi_type *nsrect_elements[3];
#endif

static ffi_type cgpoint_type;
static ffi_type *cgpoint_elements[3];

static ffi_type cgsize_type;
static ffi_type *cgsize_elements[3];

static ffi_type cgrect_type;
static ffi_type *cgrect_elements[3];

void init_ffi_types() {

    nsrange_type.size = nsrange_type.alignment = 0;
    nsrange_type.elements = (ffi_type**)&nsrange_elements;
    nsrange_type.type = FFI_TYPE_STRUCT;
#if defined(__i386__) || defined(_ARM_ARCH_7)
    nsrange_elements[0] = &ffi_type_uint32;
    nsrange_elements[1] = &ffi_type_uint32;
#endif
#if defined(__x86_64__) || defined(__arm64__)
    nsrange_elements[0] = &ffi_type_uint64;
    nsrange_elements[1] = &ffi_type_uint64;
#endif
    nsrange_elements[2] = NULL;

#if !TARGET_OS_IPHONE
    nspoint_type.size = nspoint_type.alignment = 0;
    nspoint_type.elements = (ffi_type**)&nspoint_elements;
    nspoint_type.type = FFI_TYPE_STRUCT;
#if defined(__i386__) || defined(_ARM_ARCH_7)
    nspoint_elements[0] = &ffi_type_float;
    nspoint_elements[1] = &ffi_type_float;
#endif
#if defined(__x86_64__) || defined(__arm64__)
    nspoint_elements[0] = &ffi_type_double;
    nspoint_elements[1] = &ffi_type_double;
#endif
    nspoint_elements[2] = NULL;

    nssize_type.size = nssize_type.alignment = 0;
    nssize_type.elements = (ffi_type**)&nssize_elements;
    nssize_type.type = FFI_TYPE_STRUCT;
#if defined(__i386__) || defined(_ARM_ARCH_7)
    nssize_elements[0] = &ffi_type_float;
    nssize_elements[1] = &ffi_type_float;
#endif
#if defined(__x86_64__) || defined(__arm64__)
    nssize_elements[0] = &ffi_type_double;
    nssize_elements[1] = &ffi_type_double;
#endif
    nssize_elements[2] = NULL;

    nsrect_type.size = nsrect_type.alignment = 0;
    nsrect_type.elements = (ffi_type**)&nsrect_elements;
    nsrect_type.type = FFI_TYPE_STRUCT;
    nsrect_elements[0] = &nspoint_type;
    nsrect_elements[1] = &nssize_type;
    nsrect_elements[2] = NULL;
#endif

    cgpoint_type.size = cgpoint_type.alignment = 0;
    cgpoint_type.elements = (ffi_type**)&cgpoint_elements;
    cgpoint_type.type = FFI_TYPE_STRUCT;
#if defined(__i386__) || defined(_ARM_ARCH_7)
    cgpoint_elements[0] = &ffi_type_float;
    cgpoint_elements[1] = &ffi_type_float;
#endif
#if defined(__x86_64__) || defined(__arm64__)
    cgpoint_elements[0] = &ffi_type_double;
    cgpoint_elements[1] = &ffi_type_double;
#endif
    cgpoint_elements[2] = NULL;

    cgrect_type.size = cgrect_type.alignment = 0;
    cgrect_type.elements = (ffi_type**)&cgrect_elements;
    cgrect_type.type = FFI_TYPE_STRUCT;
    cgrect_elements[0] = &cgpoint_type;
    cgrect_elements[1] = &cgsize_type;
    cgrect_elements[2] = NULL;

    cgsize_type.size = cgsize_type.alignment = 0;
    cgsize_type.elements = (ffi_type**)&cgsize_elements;
    cgsize_type.type = FFI_TYPE_STRUCT;
#if defined(__i386__) || defined(_ARM_ARCH_7)
    cgsize_elements[0] = &ffi_type_float;
    cgsize_elements[1] = &ffi_type_float;
#endif
#if defined(__x86_64__) || defined(__arm64__)
    cgsize_elements[0] = &ffi_type_double;
    cgsize_elements[1] = &ffi_type_double;
#endif
    cgsize_elements[2] = NULL;

    ffi_type_structs_init++;
}

// Given an ffi_type describing the return value, and a BOOL indicating
// whether a call to super is to be made, return a pointer to the correct
// objc_msgSend() variant to use
//
// This assumes the ffi_type has been properly initialized with its size
// and alignment info - call ffi_prep_cif before calling this.
void* CBMessengerFunctionForFFIType(ffi_type *theType, BOOL isSuper) {
    // On Intel, floats and doubles call objc_msgSend_fpret()
#ifdef __i386__
    if (theType == &ffi_type_float || theType == &ffi_type_double)
        // There is no objc_msgSendSuper_fpret() - why not?
        return isSuper ? (void*)&objc_msgSendSuper : (void*)&objc_msgSend_fpret;
#endif
#ifdef __x86_64__
    if (theType == &ffi_type_longdouble)
        // There is no objc_msgSendSuper_fpret() - why not?
        return isSuper ? (void*)&objc_msgSendSuper : (void*)&objc_msgSend_fpret;
#endif

    // If this is a struct, whether to call _stret() depends on the
    // structure size and platform
#ifdef __i386__
    if (theType->type == FFI_TYPE_STRUCT && theType->size > 8)
        return isSuper ? (void*)&objc_msgSendSuper_stret : (void*)&objc_msgSend_stret;
#endif
#ifdef __x86_64__
    if (theType->type == FFI_TYPE_STRUCT && theType->size > 16)
        return isSuper ? (void*)&objc_msgSendSuper_stret : (void*)&objc_msgSend_stret;
#endif
#ifdef __ppc__
    if (theType->type == FFI_TYPE_STRUCT)
        return isSuper ? (void*)&objc_msgSendSuper_stret : (void*)&objc_msgSend_stret;
#endif
#ifdef _ARM_ARCH_7
    if (theType->type == FFI_TYPE_STRUCT && theType->size > 4) {
        return isSuper ? (void*)&objc_msgSendSuper_stret : (void*)&objc_msgSend_stret;
    }
#endif

    // Otherwise, use vanilla
    return isSuper ? (void*)&objc_msgSendSuper : (void*)&objc_msgSend;
}

void*
CBRunPerl (char * json) {

    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;

    int retval = 0;
    SV *ret = newSV(retval);

    NSData * data = nil;
    NSDictionary *jsonResponse = nil;
    NSString * absPwd = nil;
    NSArray * args = nil;
    NSString * filePath = nil;
    NSArray * switches = nil;
    NSError *error = nil;

    if (!json) {
        return nil;
    }
    @try {
        data = [[NSString stringWithCString: json encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
        jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            retval = 3;
        }
        if (!jsonResponse) {
            retval = 4;
        }
        // this is the only mandatory element
        filePath = [jsonResponse valueForKey:@"filePath"];
        if (!filePath) {
            retval = 5;
        } else {
            @try {
                absPwd = [jsonResponse valueForKey:@"absPwd"];
            } @finally {
                if (!absPwd) absPwd = @"";
            }
            @try {
                switches = [jsonResponse valueForKey:@"switches"];
            } @finally {
                if (!switches) switches = @[];
            }
            @try {
                args = [jsonResponse valueForKey:@"args"];
            } @finally {
                if (!args) args = @[];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, (unsigned long)NULL), ^(void) {
                if (retval == 0) {
                    @autoreleasepool {
                        NSError *perlError = nil;
                        [[CBPerl alloc] initWithFileName:filePath withAbsolutePwd:absPwd withDebugger:FALSE withOptions:switches withArguments:args error:&perlError completion:^ (int perlStatus) {
                            NSLog(@"kk");
                        }];
                        if (perlError) {
                            NSDictionary * userInfo = [error userInfo];
                            NSString * perlOutput = [userInfo objectForKey:@"reason"];
                            NSLog(@"Error: %@", perlOutput);
                        }
                    }
                }
            });
        });

    } @catch (NSException * exception) {
        retval = 2;
    }
    if (retval) {
        sv_setiv(ret, 2);
    }
    return (void *)ret;
}

// Call a native class or object method
void* CBCallNativeMethod(void* target, SEL sel, void *args, BOOL isSuper) {
    // Define a Perl context
    PERL_SET_CONTEXT([CBPerl getPerlInterpreter]);
    dTHX;
    
    if (0 == ffi_type_structs_init) {
        init_ffi_types();
    }

    // Instance or class?
    id targetID;
    if (sv_isobject((SV*)target)) {
        targetID = CBDerefSVtoID(target);
    } else {
        targetID = CBClassFromSV(target);
    }
    
    // Get the Method signature
    NSMethodSignature *methodSig = [targetID methodSignatureForSelector:sel];
    
    // Unknown method
    if (!methodSig) {
        croak("Call to unknown method: %s", [NSStringFromSelector(sel) UTF8String]);
    }
    
    // Get argument count
    unsigned long num_args = methodSig ? [methodSig numberOfArguments] : 0;
    
    // Get the return type
    const char *return_type_string = methodSig ? [methodSig methodReturnType] : "@";
    
    // Ignore modifiers
    while ( return_type_string[0] == 'r' || // const
            return_type_string[0] == 'n' || // in
            return_type_string[0] == 'N' || // inout
            return_type_string[0] == 'o' || // out
            return_type_string[0] == 'O' || // bycopy
            return_type_string[0] == 'R' || // byref
            return_type_string[0] == 'V'    // oneway
            ) {
        return_type_string++;
    };

    // Return data and type info
    ffi_type *return_type = &ffi_type_void;
    const char *c_return_type = NULL;
    arg_value return_value;

    // Set up the return type
    switch ( return_type_string[0] ) {
        case 'c':   // char
        case 'B':
            return_type = &ffi_type_schar;
            break;

        case 'i':   // int
            return_type = &ffi_type_sint;
            break;

        case 's':   // short
            return_type = &ffi_type_sshort;
            break;

        case 'l':   // long
            return_type = &ffi_type_slong;
            break;

        case 'C':   // unsigned char
            return_type = &ffi_type_schar;
            break;
            
        case 'I':   // unsigned int
            return_type = &ffi_type_sint;
            break;
            
        case 'S':   // unsigned short
            return_type = &ffi_type_sshort;
            break;
            
        case 'L':   // unsigned long
            return_type = &ffi_type_ulong;
            break;

        case 'f':   // float
            return_type = &ffi_type_float;
            break;
            
        case 'd':   // double
            return_type = &ffi_type_double;
            break;

        case 'v':   // void
            return_type = &ffi_type_void;
            break;
            
        case '*':   // char*
            return_type = &ffi_type_pointer;
            break;
            
        case '@': // id
            return_type = &ffi_type_pointer;
            break;

        case '^':   // Pointer
            return_type = &ffi_type_pointer;
            break;
            
        case '#':   // Class
            return_type = &ffi_type_pointer;
            break;
            
        case ':':   // SEL
            return_type = &ffi_type_pointer;
            break;
            
        case '[':   // Array
            return_type = &ffi_type_pointer;
            break;
            
        case '{':   // Struct
            c_return_type = (return_type_string[1] == '_') ? return_type_string+2 : return_type_string+1;

            if (0 == strncmp(c_return_type, "NSRange", strlen("NSRange"))) {
                return_type = &nsrange_type;
#if !(TARGET_OS_IPHONE)
            } else if (0 == strncmp(c_return_type, "NSPoint", strlen("NSPoint"))) {
                return_type = &nspoint_type;
            } else if (0 == strncmp(c_return_type, "NSSize", strlen("NSSize"))) {
                return_type = &nssize_type;
            } else if (0 == strncmp(c_return_type, "NSRect", strlen("NSRect"))) {
                return_type = &nsrect_type;
#endif
            } else if (0 == strncmp(c_return_type, "CGPoint", strlen("CGPoint"))) {
                return_type = &cgpoint_type;
            } else if (0 == strncmp(c_return_type, "CGRect", strlen("CGRect"))) {
                return_type = &cgrect_type;
            } else if (0 == strncmp(c_return_type, "CGSize", strlen("CGSize"))) {
                return_type = &cgsize_type;
            } else {
                NSLog(@"Unknown structure type %c in return", return_type_string[0]);
            }
                
            break;
            
        case 'q':   // long long
            return_type = &ffi_type_sint64;
            break;
        case 'Q':   // unsigned long long
            return_type = &ffi_type_uint64;
            break;

        // Unknown types
        case '(':   // union
        case 'b':   // bit field
        case '?':   // Unknown
            
        default:
            NSLog(@"Unknown return type %s", return_type_string);
            return nil;
    }
    
    // The foreign call interface
    ffi_cif cif;
    
    // Method argument data and type info
    ffi_type *arg_ffi_types[16];
    arg_value arg_values[16];
    void *arg_value_ptrs[16];
    arg_value output_values[16];

#ifndef OBJC2_UNAVAILABLE
    struct objc_super context;
#endif

    // First arg is either super context or self
    if (isSuper) {
#ifdef OBJC2_UNAVAILABLE
        Class parentClass = object_getClass(targetID);
        object_setClass(targetID, parentClass);
#else
        context.receiver = targetID;
        context.class = targetID->isa->super_class;
#endif
        arg_ffi_types[0] = &ffi_type_pointer;
#ifdef OBJC2_UNAVAILABLE        
        arg_values[0].voidp = parentClass;
#else
        arg_values[0].voidp = (void*)targetID;
#endif

    } else {
        arg_ffi_types[0] = &ffi_type_pointer;
        arg_values[0].voidp = (void*)targetID;
    }

    // Second arg is always _sel
    arg_ffi_types[1] = &ffi_type_pointer;
    arg_values[1].sel = sel;
    
    const char *c_arg_type;

    // Process any other args that appear
    int i;
    for(i=2; i < num_args; i++) {
        AV *av = (AV *)SvRV((SV*)args);
        SV **sv = av_fetch(av, i-2, 0);
        SV *argSV = sv ? *sv : NULL;
        
        const char *arg_type = [methodSig getArgumentTypeAtIndex:i];
        
        // Call the av_* that's appropriate for this argument type
        switch (*arg_type) {
            case 'c':
                arg_ffi_types[i] = &ffi_type_schar;
                arg_values[i].schar = SvIV(argSV);
                break;

            case 'i':   
                // int
                arg_ffi_types[i] = &ffi_type_sint;
                arg_values[i].sint = SvIV(argSV);
                break;

            case 's':   
                // short
                arg_ffi_types[i] = &ffi_type_sshort;
                arg_values[i].sshort = SvIV(argSV);
                break;

            case 'l': 
                // long
                arg_ffi_types[i] = &ffi_type_slong;
                arg_values[i].slong = SvIV(argSV);
                break;

            case 'C':
                arg_ffi_types[i] = &ffi_type_uchar;
                arg_values[i].uchar = SvUV(argSV);
                break;
            
            case 'I':
                // unsigned int
                arg_ffi_types[i] = &ffi_type_uint;
                arg_values[i].uint = SvUV(argSV);
                break;
                
            case 'S':
                // unsigned short
                arg_ffi_types[i] = &ffi_type_ushort;
                arg_values[i].ushort = SvUV(argSV);
                break;
            
            case 'L':
                // unsigned long
                arg_ffi_types[i] = &ffi_type_ulong;
                arg_values[i].ulong = SvUV(argSV);
                break;

            case 'f':
                // float
                arg_ffi_types[i] = &ffi_type_float;
                arg_values[i].ffloat = SvNV(argSV);
                break;
                
            case 'd':
                // double
                arg_ffi_types[i] = &ffi_type_double;
                arg_values[i].fdouble = SvNV(argSV);
                break;
                
            case '*':
                // char *
                arg_ffi_types[i] = &ffi_type_pointer;
                arg_values[i].voidp = SvPV_nolen(argSV);
                break;
                
            case '@':
                // id
                arg_ffi_types[i] = &ffi_type_pointer;
                arg_values[i].voidp = argSV ? CBDerefSVtoID(argSV) : NULL;
                break;
            
            case '^':
                arg_ffi_types[i] = &ffi_type_pointer;

                if (argSV) {
                    // Pointer to id?
                    if (*(arg_type+1) == '@') {
                        arg_values[i].voidp = &(output_values[i].voidp);
                    } else {
                        if (SvOK(argSV)) {
                            arg_values[i].voidp = INT2PTR(void*,SvIV(argSV));
                        } else {
                            arg_values[i].voidp = NULL;
                        }
                    }
                } else {
                    arg_values[i].voidp = NULL;
                }
                
                break;

            case '#':
                // Class
                arg_ffi_types[i] = &ffi_type_pointer;
                arg_values[i].voidp = CBClassFromSV(argSV);
                break;
                
            case ':':
                // SEL
                arg_ffi_types[i] = &ffi_type_pointer;
                arg_values[i].sel = CBSelectorFromSV(argSV);
                break;
                
            case '[':   // Array
                arg_ffi_types[i] = &ffi_type_pointer;
                arg_values[i].voidp = (void*)SvIV(argSV);
                break;
                
            case '{':   // Struct
                c_arg_type = arg_type[1] == '_' ? arg_type+2 : arg_type+1;

                if (0 == strncmp(c_arg_type, "NSRange", strlen("NSRange"))) {
                    arg_ffi_types[i] = &nsrange_type;
                    arg_values[i].struct_nsrange = CBRangeFromSV(argSV);
                }
#if !(TARGET_OS_IPHONE)
                else if (0 == strncmp(c_arg_type, "NSPoint", strlen("NSPoint"))) {
                    arg_ffi_types[i] = &nspoint_type;
                    arg_values[i].struct_nspoint = CBPointFromSV(argSV);
                }
                else if (0 == strncmp(c_arg_type, "NSRect", strlen("NSRect"))) {
                    arg_ffi_types[i] = &nsrect_type;
                    arg_values[i].struct_nsrect = CBRectFromSV(argSV);
                }
                else if (0 == strncmp(c_arg_type, "NSSize", strlen("NSSize"))) {
                    arg_ffi_types[i] = &nssize_type;
                    arg_values[i].struct_nssize = CBSizeFromSV(argSV);
                }
#endif
                else if (0 == strncmp(c_arg_type, "CGPoint", strlen("CGPoint"))) {
                    arg_ffi_types[i] = &cgpoint_type;
                    arg_values[i].struct_cgpoint = CBCGPointFromSV(argSV);
                }
                else if (0 == strncmp(c_arg_type, "CGRect", strlen("CGRect"))) {
                    arg_ffi_types[i] = &cgrect_type;
                    arg_values[i].struct_cgrect = CBCGRectFromSV(argSV);
                }
                else if (0 == strncmp(c_arg_type, "CGSize", strlen("CGSize"))) {
                    arg_ffi_types[i] = &cgsize_type;
                    arg_values[i].struct_cgsize = CBCGSizeFromSV(argSV);
                }
                else {
                    NSLog(@"Unknown structure type %s in position %d", arg_type, i);
                }
                
                break;
                
            case 'q':
                // unsigned quad
                arg_ffi_types[i] = &ffi_type_sint64;
                arg_values[i].slong = SvIV(argSV);
                break;
            case 'Q':
                // unsigned quad
                arg_ffi_types[i] = &ffi_type_uint64;
                arg_values[i].ulong = SvUV(argSV);
                break;

            case '(':
                // union

            case 'b':
                // bit field
            
            case '?':
                // Unknown
                
            default:
                NSLog(@"Unknown argument type %s in position %d", arg_type, i);
                return nil;
        }
    }
    
    for(i=0; i<num_args; i++) {
        arg_value_ptrs[i] = &arg_values[i];
    }
        
    // Try to create the interface
    if (ffi_prep_cif(&cif,
                     FFI_DEFAULT_ABI,
                     (unsigned int)num_args,
                     return_type,
                     arg_ffi_types)
        != FFI_OK ) {
        
        NSLog(@"Error creating ffi cif");
        return nil;
    }

    void* messenger_func = CBMessengerFunctionForFFIType(return_type, isSuper);

    // Finished processing arguments, call the method!
    NS_DURING
        ffi_call(&cif, messenger_func, &return_value.voidp, arg_value_ptrs);
    NS_HANDLER
        SV *errsv = get_sv("@", TRUE);
        NSLog(@"NSException raised: %@. %@", [localException name], [localException reason]);
        sv_setsv(errsv, CBDerefIDtoSV(localException));
        croak("Died.");
    NS_ENDHANDLER
    
    // Process output arguments
    for(i=2; i < num_args; i++) {
        AV *av = (AV *)SvRV((SV*)args);
        SV **sv = av_fetch(av, i-2, 0);
        SV *argSV = sv ? *sv : NULL;
        
        if (!argSV) {
            continue;
        }
        
        const char *arg_type = [methodSig getArgumentTypeAtIndex:i];
        
        switch (*arg_type) {
            
            case '^':   // Pointer
                        // Pointer to id?
                if (*(arg_type+1) == '@' && argSV && SvOK(argSV)) {
                    sv_setsv(argSV, CBDerefIDtoSV(output_values[i].voidp));
                }
                break;
        }
    }

    // Handle return value
    SV *ret = newSV(0);
    switch (*return_type_string) {
        case 'c':
        case 'B':
            sv_setiv(ret, return_value.schar);
            break;

        case 's':
            sv_setiv(ret, return_value.sshort);
            break;
            
        case 'i':
            sv_setiv(ret, return_value.sint);
            break;
            
        case 'l':
            sv_setiv(ret, return_value.slong);
            break;

        case 'C':
            sv_setuv(ret, return_value.uchar);
            break;
            
        case 'S':
            sv_setuv(ret, return_value.ushort);
            break;
            
        case 'I':
            sv_setuv(ret, return_value.uint);
            break;

        case 'L':
            sv_setuv(ret, return_value.ulong);
            break;

        case 'f':
            // float
            sv_setnv(ret, return_value.ffloat);
            break;
        
        case 'd':   
            // double
            sv_setnv(ret, return_value.fdouble);
            break;

        case 'v':   // void
            sv_setsv(ret, &PL_sv_undef);
            break;
            
        case '*':   // char*
            sv_setpv(ret, return_value.voidp);
            break;
            
        case '@':   // id
            sv_setsv(ret, CBDerefIDtoSV(return_value.voidp));
            break;
            
        case '^':   // Pointer
            sv_setiv(ret, PTR2IV(return_value.voidp));
            break;
            
        case '#':   // Class
            sv_setsv(ret, CBSVFromClass(return_value.voidp));
            break;
            
        case ':':   // SEL
            sv_setsv(ret, CBSVFromSelector(return_value.sel));
            break;
            
        case '[':   // Array
            sv_setiv(ret, (int)return_value.voidp);
            break;
            
        case '{':   // Struct
            if (0 == strncmp(c_return_type, "NSRange", strlen("NSRange"))) {
                sv_setsv(ret, CBRangeToSV(return_value.struct_nsrange));
            }
#if !TARGET_OS_IPHONE
            else if (0 == strncmp(c_return_type, "NSPoint", strlen("NSPoint"))) {
                sv_setsv(ret, CBPointToSV(return_value.struct_nspoint));
            }
            else if (0 == strncmp(c_return_type, "NSRect", strlen("NSRect"))) {
                sv_setsv(ret, CBRectToSV(return_value.struct_nsrect));
            }
            else if (0 == strncmp(c_return_type, "NSSize", strlen("NSSize"))) {
                sv_setsv(ret, CBSizeToSV(return_value.struct_nssize));
            }
#endif
            else if (0 == strncmp(c_return_type, "CGPoint", strlen("CGPoint"))) {
                sv_setsv(ret, CBCGPointToSV(return_value.struct_cgpoint));
            }
            else if (0 == strncmp(c_return_type, "CGRect", strlen("CGRect"))) {
                sv_setsv(ret, CBCGRectToSV(return_value.struct_cgrect));
            }
            else if (0 == strncmp(c_return_type, "CGSize", strlen("CGSize"))) {
                sv_setsv(ret, CBCGSizeToSV(return_value.struct_cgsize));
            }
            else {
                NSLog(@"Unknown structure type %s in return", return_type_string);
                return nil;
            }
            break;
            
        case 'q':   // long long
            sv_setiv(ret, return_value.slong);
            break;
        case 'Q':   // unsigned long long
            sv_setuv(ret, return_value.ulong);
            break;

        case '(':   // union
        case 'b':   // bit field
        case '?':   // Unknown

        default:
            NSLog(@"Unknown return type %s", return_type_string);
            ret = nil;
    }
    
    return ret;
}
