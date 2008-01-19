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

#import <objc/objc-class.h>
#import <objc/objc-runtime.h>
#import "PerlImports.h"
#import "perlxsi.h"

// The BYTEORDER macro is also #defined by perl, and Perl's use
// of it should be fully expanded by now.
#undef BYTEORDER

#define MACOSX
#include "ffi.h"

typedef union {
	unsigned char schar;
	char uchar;
	unsigned short sshort;
	short ushort;
    unsigned int uint;
    int sint;
    unsigned long ulong;
    long slong;
	float ffloat;
    double fdouble;
    void *voidp;
    SEL sel;
    NSPoint struct_nspoint;
    NSRange struct_nsrange;
    NSRect struct_nsrect;
    NSSize struct_nssize;
} arg_value;

// Define ffi_type structs for NSPoint, NSRect, NSRange, and NSSize
static int ffi_type_structs_init = 0;

static ffi_type nspoint_type;
static ffi_type *nspoint_elements[3];

static ffi_type nssize_type;
static ffi_type *nssize_elements[3];

static ffi_type nsrect_type;
static ffi_type *nsrect_elements[3];

static ffi_type nsrange_type;
static ffi_type *nsrange_elements[3];

void init_ffi_types() {
	nspoint_type.size = nspoint_type.alignment = 0;
	nspoint_type.elements = (ffi_type**)&nspoint_elements;
	nspoint_elements[0] = &ffi_type_float;
	nspoint_elements[1] = &ffi_type_float;
	nspoint_elements[2] = NULL;
	
	nssize_type.size = nssize_type.alignment = 0;
	nssize_type.elements = (ffi_type**)&nssize_elements;
	nssize_elements[0] = &ffi_type_float;
	nssize_elements[1] = &ffi_type_float;
	nssize_elements[2] = NULL;
	
	nsrect_type.size = nsrect_type.alignment = 0;
	nsrect_type.elements = (ffi_type**)&nsrect_elements;
	nsrect_elements[0] = &nspoint_type;
	nsrect_elements[1] = &nssize_type;
	nsrect_elements[2] = NULL;

	nsrange_type.size = nsrange_type.alignment = 0;
	nsrange_type.elements = (ffi_type**)&nsrange_elements;
	nsrange_elements[0] = &ffi_type_uint32;
	nsrange_elements[1] = &ffi_type_uint32;
	nsrange_elements[2] = NULL;
	
	ffi_type_structs_init++;
}

// Call a native class or object method
void* CBCallNativeMethod(void* target, SEL sel, void *args, BOOL isSuper) {
    // Define a Perl context
    PERL_SET_CONTEXT(_CBPerlInterpreter);
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
	
    // Get argument count
    int num_args = methodSig ? [methodSig numberOfArguments] : 0;
	
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
			return_type = &ffi_type_uchar;
			break;
		
		case 'I':   // unsigned int
			return_type = &ffi_type_uint32;
			break;
		
		case 'S':   // unsigned short
			return_type = &ffi_type_ushort;
			break;
			
		case 'L':   // unsigned long
			return_type = &ffi_type_ulong;
			break;
			
		case 'f':   // float
			return_type = &ffi_type_float;
			
		case 'd':   // double
			return_type = &ffi_type_double;
			break;
			
		case 'v':   // void
			return_type = &ffi_type_void;
			break;
			
		case '*':   // char*
			return_type = &ffi_type_pointer;
			break;
			
		case '@':
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
			if (0 == strncmp(c_return_type, "NSPoint", strlen("NSPoint"))) {
				return_type = &nspoint_type;
			} else if (0 == strncmp(c_return_type, "NSRange", strlen("NSRange"))) {
				return_type = &nsrange_type;
			} else if (0 == strncmp(c_return_type, "NSRect", strlen("NSRect"))) {
				return_type = &nsrect_type;
			} else if (0 == strncmp(c_return_type, "NSSize", strlen("NSSize"))) {
				return_type = &nssize_type;
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
	
	struct objc_super context;

	// First arg is either super context or self
	if (isSuper) {
		context.receiver = targetID;
		context.class = targetID->isa->super_class;
		arg_ffi_types[0] = &ffi_type_pointer;
		arg_values[0].voidp = &context;

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
		
        if (!argSV) {
            break;
        }

        const char *arg_type = [methodSig getArgumentTypeAtIndex:i];
		
        // Call the av_* that's appropriate for this argument type
        switch (*arg_type) {
            case 'c':
				// char
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
				// unsigned char
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
				arg_values[i].voidp = CBDerefSVtoID(argSV);
				break;
			
			case '^':
				// Pointer to id?
				if (*(arg_type+1) == '@' && argSV != &PL_sv_undef) {
					arg_ffi_types[i] = &ffi_type_pointer;
					arg_values[i].voidp = &output_values[i];
				} else {
					arg_ffi_types[i] = &ffi_type_pointer;
					arg_values[i].voidp = (void*)SvIV(argSV);
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
                if (0 == strncmp(c_arg_type, "NSPoint", strlen("NSPoint"))) {
					arg_ffi_types[i] = &nspoint_type;
					arg_values[i].struct_nspoint = CBPointFromSV(argSV);
                } else if (0 == strncmp(c_arg_type, "NSRange", strlen("NSRange"))) {
					arg_ffi_types[i] = &nsrange_type;
					arg_values[i].struct_nsrange = CBRangeFromSV(argSV);
                } else if (0 == strncmp(c_arg_type, "NSRect", strlen("NSRect"))) {
					arg_ffi_types[i] = &nsrect_type;
					arg_values[i].struct_nsrect = CBRectFromSV(argSV);
                } else if (0 == strncmp(c_arg_type, "NSSize", strlen("NSSize"))) {
					arg_ffi_types[i] = &nssize_type;
					arg_values[i].struct_nssize = CBSizeFromSV(argSV);
                } else {
                    NSLog(@"Unknown structure type %s in position %d", arg_type, i);
                }
				
				break;
				
            case '(':
				// union

            case 'b':
				// bit field
            
			case '?':
				// Unknown
				
            case 'q':
				// long long
				
            case 'Q':
				// unsigned long long
				
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
					 num_args,
					 return_type,
					 arg_ffi_types)
		!= FFI_OK ) {
		
		NSLog(@"Error creating ffi cif");
		return nil;
	}

    // Finished processing arguments, call the method!
    NS_DURING

		if (isSuper) {
			ffi_call(&cif, (void*)objc_msgSendSuper, &return_value.voidp, arg_value_ptrs);

		} else {
#ifdef __i386__
			if (return_type == &ffi_type_float || return_type == &ffi_type_double) {
				ffi_call(&cif, (void*)objc_msgSend_fpret, &return_value.voidp, arg_value_ptrs);
			} else {
				ffi_call(&cif, (void*)objc_msgSend, &return_value.voidp, arg_value_ptrs);
			}
#else
			ffi_call(&cif, (void*)objc_msgSend, &return_value.voidp, arg_value_ptrs);
#endif
		}
	
    NS_HANDLER
        SV *errsv = get_sv("@", TRUE);
        sv_setsv(errsv, CBDerefIDtoSV(localException));
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
		
        const char *arg_type = [methodSig getArgumentTypeAtIndex:i];
		
        switch (*arg_type) {
			
            case '^':   // Pointer
						// Pointer to id?
				if (*(arg_type+1) == '@' && argSV != &PL_sv_undef) {
					sv_setsv(argSV, CBDerefIDtoSV(output_values[i].voidp));
				}
                break;
		}
	}

	// Handle return value
	SV *ret = newSV(0);
    switch (*return_type_string) {
        case 'c':
			// char
            sv_setiv(ret, return_value.schar);
            break;
			
        case 'i':
			// int
            sv_setiv(ret, return_value.sint);
            break;

        case 's':
			// short
            sv_setiv(ret, return_value.sshort);
            break;
        
		case 'l':
			// long
            sv_setiv(ret, return_value.slong);
            break;
			
        case 'C':
			// unsigned char
            sv_setuv(ret, return_value.uchar);
            break;
        
		case 'I':
			// unsigned int
            sv_setuv(ret, return_value.uint);
            break;
        
		case 'S':
			// unsigned short
            sv_setuv(ret, return_value.ushort);
            break;
			
		case 'L':
			// unsigned long
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
            sv_setiv(ret, (int)return_value.voidp);
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
            if (0 == strncmp(c_return_type, "NSPoint", strlen("NSPoint"))) {
                sv_setsv(ret, CBPointToSV(return_value.struct_nspoint));
            } else if (0 == strncmp(c_return_type, "NSRange", strlen("NSRange"))) {
				sv_setsv(ret, CBRangeToSV(return_value.struct_nsrange));
            } else if (0 == strncmp(c_return_type, "NSRect", strlen("NSRect"))) {
                sv_setsv(ret, CBRectToSV(return_value.struct_nsrect));
            } else if (0 == strncmp(c_return_type, "NSSize", strlen("NSSize"))) {
                sv_setsv(ret, CBSizeToSV(return_value.struct_nssize));
            } else {
                NSLog(@"Unknown structure type %s in return", return_type);
                return nil;
            }
            break;
			
        case '(':   // union
        case 'b':   // bit field
        case '?':   // Unknown
        case 'q':   // long long
        case 'Q':   // unsigned long long
        default:
            NSLog(@"Unknown return type %s", return_type_string);
            ret = nil;
	}
	
	return ret;
}