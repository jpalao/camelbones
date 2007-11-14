//
//  NativeMethods.m
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import "Conversions_real.h"
#import "NativeMethods_real.h"
#import "Structs_real.h"
#import "CBPerlObjectInternals.h"

#import <avcall.h>

#ifdef GNUSTEP
#import <GNUstepBase/GSObjCRuntime.h>
#else
#import <objc/objc-class.h>
#import <objc/objc-runtime.h>
#endif

#import "PerlImports.h"
#import "perlxsi.h"

#ifdef GNUSTEP
// Call a native class or object method
void* REAL_CBCallNativeMethod(void* target, SEL sel, void *args, BOOL isSuper) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    av_alist alist;

    IMP theMethod;
    GSMethod methodInfo;
    id targetID;
    Class targetClass;

    NSMethodSignature *methodSig;
    int num_args;

    const char *return_type;
    const char *c_return_type = NULL;
    const char *arg_type;
    const char *c_arg_type = NULL;

    CB_ObjCType return_value;

    int i;
    SV *ret;

    // Instance or class?
    if (sv_isobject((SV*)target)) {
        targetID = REAL_CBDerefSVtoID(target);
    } else {
        targetID = REAL_CBClassFromSV(target);
    }

    // Get the (meta)class
    targetClass = GSObjCClass(targetID);

    // Super or self?
    if (isSuper) {
        Super super;
        super.self = targetID;
        super.class = GSObjCClass(targetID);
        theMethod = objc_msg_lookup_super(&super, sel);
    } else {
        theMethod = objc_msg_lookup(targetID, sel);
    }

    // Get the method info
    methodInfo = GSGetMethod(targetClass, sel, GSObjCIsInstance(targetID), isSuper);

    // Get the Method signature
    methodSig = [targetID methodSignatureForSelector:sel];

    // Get arguments
    num_args = methodSig ? [methodSig numberOfArguments] : 0;

    // Get the return type
    return_type = methodSig ? [methodSig methodReturnType] : "@";

    // Ignore const modifier
    if (return_type[0] == 'r') {
        return_type++;
    }

    // Start the call to the method
    av_start_ptr(alist, theMethod, id, &return_value.id_p);

    // Pass self and _cmd
    av_ptr(alist, id, targetID);
    av_ptr(alist, SEL, sel);

    // Process any other args that appear
    for(i=2; i < num_args; i++) {
        AV *av = (AV *)SvRV((SV*)args);
        SV **sv = av_fetch(av, i-2, 0);
        SV *argSV = sv ? *sv : NULL;

        if (!argSV) {
            break;
        }

        arg_type = [methodSig getArgumentTypeAtIndex:i];

        // Call the av_* that's appropriate for this argument type
        switch (*arg_type) {
            case 'c':   // char
            case 'i':   // int
            case 's':   // short
                av_int(alist, SvIV(argSV));
                break;
    
            case 'l':   // long
                av_long(alist, SvIV(argSV));
                break;
    
            case 'C':   // unsigned char
            case 'I':   // unsigned int
            case 'S':   // unsigned short
                av_uint(alist, SvUV(argSV));
                break;
    
            case 'L':   // unsigned long
                av_ulong(alist, SvUV(argSV));
                break;
    
            case 'f':   // float
            case 'd':   // double
                av_double(alist, SvNV(argSV));
                break;
    
            case 'v':   // void
                break;
    
            case '*':   // char*
                av_ptr(alist, char*, SvPV_nolen(argSV));
                break;
    
            case '@':   // id
                av_ptr(alist, id, REAL_CBDerefSVtoID(argSV));
                break;
    
            case '^':   // Pointer
                av_ptr(alist, void*, (void*)SvIV(argSV));
                break;
    
            case '#':   // Class
                av_ptr(alist, struct objc_class*, REAL_CBClassFromSV(argSV));
                break;
    
            case ':':   // SEL
                av_ptr(alist, SEL, REAL_CBSelectorFromSV(argSV));
                break;
    
            case '[':   // Array
                av_ptr(alist, void*, (void*)SvIV(argSV));
                break;
    
            case '{':   // Struct
				c_arg_type = arg_type[1] == '_' ? arg_type+2 : arg_type+1;
                if (0 == strncmp(c_arg_type, "NSPoint", strlen("NSPoint"))) {
                    av_struct(alist, NSPoint, REAL_CBPointFromSV(argSV));
                } else if (0 == strncmp(c_arg_type, "NSRange", strlen("NSRange"))) {
                    av_struct(alist, NSRange, REAL_CBRangeFromSV(argSV));
                } else if (0 == strncmp(c_arg_type, "NSRect", strlen("NSRect"))) {
                    av_struct(alist, NSRect, REAL_CBRectFromSV(argSV));
                } else if (0 == strncmp(c_arg_type, "NSSize", strlen("NSSize"))) {
                    av_struct(alist, NSSize, REAL_CBSizeFromSV(argSV));
                } else {
                    NSLog(@"Unknown structure type %s in position %d", arg_type, i);
                }
                break;
    
            // Unknown types
            case '(':   // union
            case 'b':   // bit field
            case '?':   // Unknown
    
            case 'q':   // long long
            case 'Q':   // unsigned long long
            default:
                NSLog(@"Unknown argument type %s in position %d", arg_type, i);
                return nil;
        }
    }

    // Finished processing arguments, call the method!
    NS_DURING
        av_call(alist);
    NS_HANDLER
        SV *errsv = get_sv("@", TRUE);
        sv_setsv(errsv, REAL_CBDerefIDtoSV(localException));
        croak(Nullch);
    NS_ENDHANDLER

    ret = newSV(0);
    switch (*return_type) {
        case 'c':   // char
        case 'i':   // int
        case 's':   // short
            sv_setiv(ret, return_value.sint);
            break;

        case 'l':   // long
            sv_setiv(ret, return_value.slong);
            break;

        case 'C':   // unsigned char
        case 'I':   // unsigned int
        case 'S':   // unsigned short
            sv_setuv(ret, return_value.uint);
            break;

        case 'L':   // unsigned long
            sv_setuv(ret, return_value.ulong);
            break;

        case 'f':   // float
        case 'd':   // double
            sv_setnv(ret, return_value.dfloat);
            break;

        case 'v':   // void
            sv_setsv(ret, &PL_sv_undef);
            break;

        case '*':   // char*
            sv_setpv(ret, return_value.char_p);
            break;

        case '@':   // id
            sv_setsv(ret, REAL_CBDerefIDtoSV(return_value.id_p));
            break;

        case '^':   // Pointer
            sv_setiv(ret, (int)return_value.void_p);
            break;

        case '#':   // Class
            sv_setsv(ret, REAL_CBSVFromClass(return_value.class_p));
            break;

        case ':':   // SEL
            sv_setsv(ret, REAL_CBSVFromSelector(return_value.sel_p));
            break;

        case '[':   // Array
            sv_setiv(ret, (int)return_value.void_p);
            break;

        case '{':   // Struct
            if (0 == strncmp(c_return_type, "NSPoint", strlen("NSPoint"))) {
                sv_setsv(ret, REAL_CBPointToSV(return_value.point_s));
            } else if (0 == strncmp(c_return_type, "NSRange", strlen("NSRange"))) {
				sv_setsv(ret, REAL_CBRangeToSV(return_value.range_s));
            } else if (0 == strncmp(c_return_type, "NSRect", strlen("NSRect"))) {
                sv_setsv(ret, REAL_CBRectToSV(return_value.rect_s));
            } else if (0 == strncmp(c_return_type, "NSSize", strlen("NSSize"))) {
                sv_setsv(ret, REAL_CBSizeToSV(return_value.size_s));
            } else {
                NSLog(@"Unknown structure type %s in return", return_type);
                return nil;
            }
            break;

        // Unknown types
        case '(':   // union
        case 'b':   // bit field
        case '?':   // Unknown

        case 'q':   // long long
        case 'Q':   // unsigned long long
        default:
            NSLog(@"Unknown return type %s", return_type);
            return nil;
    }

    return ret;
}

#else /* Cocoa */

// Call a native class or object method
void* REAL_CBCallNativeMethod(void* target, SEL sel, void *args, BOOL isSuper) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
    dTHX;

    av_alist alist;
    NSMethodSignature *methodSig;
    struct objc_super context;

    id targetID;

    const char *return_type;
    const char *c_return_type = NULL;
    const char *arg_type;
    const char *c_arg_type = NULL;

    int arg_offset;
    CB_ObjCType return_value;
	CB_ObjCType arg_values[32];

    int i;
    SV* ret;
    int num_args;

    i = 0;
    ret = NULL;
    num_args = 0;

    // Instance or class?
    if (sv_isobject((SV*)target)) {
        targetID = REAL_CBDerefSVtoID(target);
    } else {
        targetID = REAL_CBClassFromSV(target);
    }

    // Get the Method signature
    methodSig = [targetID methodSignatureForSelector:sel];

    // Get arguments
    num_args = methodSig ? [methodSig numberOfArguments] : 0;

    // Get the return type
    return_type = methodSig ? [methodSig methodReturnType] : "@";

    // Ignore modifiers
    if (return_type[0] == 'r' || // const
		return_type[0] == 'n' || // in
		return_type[0] == 'N' || // inout
		return_type[0] == 'o' || // out
		return_type[0] == 'O' || // bycopy
		return_type[0] == 'R' || // byref
		return_type[0] == 'V'    // oneway
		) {
        return_type++;
    }

    // Start the call to objc_msgSend*
    if (isSuper) {
        switch (return_type[0]) {
            case 'c':   // char
            case 'i':   // int
            case 's':   // short
                av_start_int(alist, &objc_msgSendSuper, &return_value.sint);
                break;

            case 'l':   // long
                av_start_long(alist, &objc_msgSendSuper, &return_value.slong);
                break;

            case 'C':   // unsigned char
            case 'I':   // unsigned int
            case 'S':   // unsigned short
                av_start_uint(alist, &objc_msgSendSuper, &return_value.uint);
                break;
    
            case 'L':   // unsigned long
                av_start_ulong(alist, &objc_msgSendSuper, &return_value.ulong);
                break;
    
            case 'f':   // float
            case 'd':   // double
                av_start_double(alist, &objc_msgSendSuper, &return_value.dfloat);
                break;

            case 'v':   // void
                av_start_void(alist, &objc_msgSendSuper);
                break;
    
            case '*':   // char*
                av_start_ptr(alist, &objc_msgSendSuper, char*, &return_value.char_p);
                break;
    
            case '@':
                av_start_ptr(alist, &objc_msgSendSuper, id, &return_value.id_p);
                break;

            case '^':   // Pointer
                av_start_ptr(alist, &objc_msgSendSuper, void*, &return_value.id_p);
                break;
    
            case '#':   // Class
                av_start_ptr(alist, &objc_msgSendSuper, Class, &return_value.id_p);
                break;
    
            case ':':   // SEL
                av_start_ptr(alist, &objc_msgSendSuper, SEL, &return_value.id_p);
                break;
    
            case '[':   // Array
                av_start_ptr(alist, &objc_msgSendSuper, void*, &return_value.id_p);
                break;
    
            case '{':   // Struct
				c_return_type = (return_type[1] == '_') ? return_type+2 : return_type+1;
                if (0 == strncmp(c_return_type, "NSPoint", strlen("NSPoint"))) {
                    av_start_void(alist, &objc_msgSendSuper_stret);
					av_ptr(alist, void*, &return_value.point_s);
                } else if (0 == strncmp(c_return_type, "NSRange", strlen("NSRange"))) {
                    av_start_void(alist, &objc_msgSendSuper_stret);
					av_ptr(alist, void*, &return_value.range_s);
                } else if (0 == strncmp(c_return_type, "NSRect", strlen("NSRect"))) {
                    av_start_void(alist, &objc_msgSendSuper_stret);
					av_ptr(alist, void*, &return_value.rect_s);
                } else if (0 == strncmp(c_return_type, "NSSize", strlen("NSSize"))) {
                    av_start_void(alist, &objc_msgSendSuper_stret);
					av_ptr(alist, void*, &return_value.size_s);
                } else {
                    NSLog(@"Unknown structure type %s in return", return_type);
                }
                break;

            // Unknown types
            case '(':   // union
            case 'b':   // bit field
            case '?':   // Unknown
    
            case 'q':   // long long
            case 'Q':   // unsigned long long

            default:
                NSLog(@"Unknown return type %s", return_type);
                return nil;
        }

        context.receiver = targetID;
        context.class = targetID->isa->super_class;
        av_struct(alist, struct objc_super*, &context);

    } else {
        switch (return_type[0]) {
            case 'c':   // char
            case 'i':   // int
            case 's':   // short
                av_start_int(alist, &objc_msgSend, &return_value.sint);
                break;

            case 'l':   // long
                av_start_long(alist, &objc_msgSend, &return_value.slong);
                break;

            case 'C':   // unsigned char
            case 'I':   // unsigned int
            case 'S':   // unsigned short
                av_start_uint(alist, &objc_msgSend, &return_value.uint);
                break;
    
            case 'L':   // unsigned long
                av_start_ulong(alist, &objc_msgSend, &return_value.ulong);
                break;
    
            case 'f':   // float
            case 'd':   // double
#ifdef __i386__
                av_start_double(alist, &objc_msgSend_fpret, &return_value.dfloat);
#else
                av_start_double(alist, &objc_msgSend, &return_value.dfloat);
#endif
                break;
    
            case 'v':   // void
                av_start_void(alist, &objc_msgSend);
                break;
    
            case '*':   // char*
                av_start_ptr(alist, &objc_msgSend, char*, &return_value.char_p);
                break;
    
            case '@':
                av_start_ptr(alist, &objc_msgSend, id, &return_value.id_p);
                break;

            case '^':   // Pointer
                av_start_ptr(alist, &objc_msgSend, void*, &return_value.id_p);
                break;
    
            case '#':   // Class
                av_start_ptr(alist, &objc_msgSend, Class, &return_value.id_p);
                break;
    
            case ':':   // SEL
                av_start_ptr(alist, &objc_msgSend, SEL, &return_value.id_p);
                break;
    
            case '[':   // Array
                av_start_ptr(alist, &objc_msgSend, void*, &return_value.id_p);
                break;
    
            case '{':   // Struct
				c_return_type = (return_type[1] == '_') ? return_type+2 : return_type+1;
                if (0 == strncmp(c_return_type, "NSPoint", strlen("NSPoint"))) {
                    av_start_void(alist, &objc_msgSend_stret);
					av_ptr(alist, void*, &return_value.point_s);
                } else if (0 == strncmp(c_return_type, "NSRange", strlen("NSRange"))) {
                    av_start_void(alist, &objc_msgSend_stret);
					av_ptr(alist, void*, &return_value.range_s);
                } else if (0 == strncmp(c_return_type, "NSRect", strlen("NSRect"))) {
                    av_start_void(alist, &objc_msgSend_stret);
					av_ptr(alist, void*, &return_value.rect_s);
                } else if (0 == strncmp(c_return_type, "NSSize", strlen("NSSize"))) {
                    av_start_void(alist, &objc_msgSend_stret);
					av_ptr(alist, void*, &return_value.size_s);
                } else {
                    NSLog(@"Unknown structure type %s in return", return_type);
                }
                break;

            // Unknown types
            case '(':   // union
            case 'b':   // bit field
            case '?':   // Unknown
    
            case 'q':   // long long
            case 'Q':   // unsigned long long

            default:
                NSLog(@"Unknown return type %s", return_type);
                return nil;

        }

        av_ptr(alist, id, targetID);
    }

    av_ptr(alist, SEL, sel);

    // Process any other args that appear
    for(i=2; i < num_args; i++) {
        AV *av = (AV *)SvRV((SV*)args);
        SV **sv = av_fetch(av, i-2, 0);
        SV *argSV = sv ? *sv : NULL;

        if (!argSV) {
            break;
        }

        arg_type = [methodSig getArgumentTypeAtIndex:i];

        // Call the av_* that's appropriate for this argument type
        switch (*arg_type) {
            case 'c':   // char
            case 'i':   // int
            case 's':   // short
                av_int(alist, SvIV(argSV));
                break;
    
            case 'l':   // long
                av_long(alist, SvIV(argSV));
                break;
    
            case 'C':   // unsigned char
            case 'I':   // unsigned int
            case 'S':   // unsigned short
                av_uint(alist, SvUV(argSV));
                break;
    
            case 'L':   // unsigned long
                av_ulong(alist, SvUV(argSV));
                break;
    
            case 'f':   // float
            case 'd':   // double
                av_double(alist, SvNV(argSV));
                break;
    
            case 'v':   // void
                break;
    
            case '*':   // char*
                av_ptr(alist, char*, SvPV_nolen(argSV));
                break;
    
            case '@':   // id
                av_ptr(alist, id, REAL_CBDerefSVtoID(argSV));
                break;
    
            case '^':   // Pointer
				// Pointer to id?
				if (*(arg_type+1) == '@' && argSV != &PL_sv_undef) {
					av_ptr(alist, void*, &(arg_values[i].id_p));
				} else {
					av_ptr(alist, void*, (void*)SvIV(argSV));
				}
                break;
    
            case '#':   // Class
                av_ptr(alist, struct objc_class*, REAL_CBClassFromSV(argSV));
                break;
    
            case ':':   // SEL
                av_ptr(alist, SEL, REAL_CBSelectorFromSV(argSV));
                break;
    
            case '[':   // Array
                av_ptr(alist, void*, (void*)SvIV(argSV));
                break;
    
            case '{':   // Struct
				c_arg_type = arg_type[1] == '_' ? arg_type+2 : arg_type+1;
                if (0 == strncmp(c_arg_type, "NSPoint", strlen("NSPoint"))) {
                    av_struct(alist, NSPoint, REAL_CBPointFromSV(argSV));
                } else if (0 == strncmp(c_arg_type, "NSRange", strlen("NSRange"))) {
                    av_struct(alist, NSRange, REAL_CBRangeFromSV(argSV));
                } else if (0 == strncmp(c_arg_type, "NSRect", strlen("NSRect"))) {
                    av_struct(alist, NSRect, REAL_CBRectFromSV(argSV));
                } else if (0 == strncmp(c_arg_type, "NSSize", strlen("NSSize"))) {
                    av_struct(alist, NSSize, REAL_CBSizeFromSV(argSV));
                } else {
                    NSLog(@"Unknown structure type %s in position %d", arg_type, i);
                }
                break;
    
            // Unknown types
            case '(':   // union
            case 'b':   // bit field
            case '?':   // Unknown
    
            case 'q':   // long long
            case 'Q':   // unsigned long long
            default:
                NSLog(@"Unknown argument type %s in position %d", arg_type, i);
                return nil;
        }
    }

    // Finished processing arguments, call the method!
    NS_DURING
        av_call(alist);
    NS_HANDLER
        SV *errsv = get_sv("@", TRUE);
        sv_setsv(errsv, REAL_CBDerefIDtoSV(localException));
        croak(Nullch);
    NS_ENDHANDLER
    
    // Process output arguments
    for(i=2; i < num_args; i++) {
        AV *av = (AV *)SvRV((SV*)args);
        SV **sv = av_fetch(av, i-2, 0);
        SV *argSV = sv ? *sv : NULL;

        if (!argSV) {
            break;
        }

        arg_type = [methodSig getArgumentTypeAtIndex:i];

        switch (*arg_type) {

            case '^':   // Pointer
				// Pointer to id?
				if (*(arg_type+1) == '@' && argSV != &PL_sv_undef) {
					sv_setsv(argSV, REAL_CBDerefIDtoSV(arg_values[i].id_p));
				}
                break;
		}
	}

    ret = newSV(0);
    switch (*return_type) {
        case 'c':   // char
        case 'i':   // int
        case 's':   // short
            sv_setiv(ret, return_value.sint);
            break;

        case 'l':   // long
            sv_setiv(ret, return_value.slong);
            break;

        case 'C':   // unsigned char
        case 'I':   // unsigned int
        case 'S':   // unsigned short
            sv_setuv(ret, return_value.uint);
            break;

        case 'L':   // unsigned long
            sv_setuv(ret, return_value.ulong);
            break;

        case 'f':   // float
        case 'd':   // double
            sv_setnv(ret, return_value.dfloat);
            break;

        case 'v':   // void
            sv_setsv(ret, &PL_sv_undef);
            break;

        case '*':   // char*
            sv_setpv(ret, return_value.char_p);
            break;

        case '@':   // id
            sv_setsv(ret, REAL_CBDerefIDtoSV(return_value.id_p));
            break;

        case '^':   // Pointer
            sv_setiv(ret, (int)return_value.void_p);
            break;

        case '#':   // Class
            sv_setsv(ret, REAL_CBSVFromClass(return_value.class_p));
            break;

        case ':':   // SEL
            sv_setsv(ret, REAL_CBSVFromSelector(return_value.sel_p));
            break;

        case '[':   // Array
            sv_setiv(ret, (int)return_value.void_p);
            break;

        case '{':   // Struct
            if (0 == strncmp(c_return_type, "NSPoint", strlen("NSPoint"))) {
                sv_setsv(ret, REAL_CBPointToSV(return_value.point_s));
            } else if (0 == strncmp(c_return_type, "NSRange", strlen("NSRange"))) {
				sv_setsv(ret, REAL_CBRangeToSV(return_value.range_s));
            } else if (0 == strncmp(c_return_type, "NSRect", strlen("NSRect"))) {
                sv_setsv(ret, REAL_CBRectToSV(return_value.rect_s));
            } else if (0 == strncmp(c_return_type, "NSSize", strlen("NSSize"))) {
                sv_setsv(ret, REAL_CBSizeToSV(return_value.size_s));
            } else {
                NSLog(@"Unknown structure type %s in return", return_type);
                return nil;
            }
            break;

        // Unknown types
        case '(':   // union
        case 'b':   // bit field
        case '?':   // Unknown

        case 'q':   // long long
        case 'Q':   // unsigned long long
        default:
            NSLog(@"Unknown return type %s", return_type);
            return nil;
    }

    return ret;
}
#endif /* GNUSTEP */
