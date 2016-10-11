#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#endif
#import <stdio.h>

#import <CamelBones/PerlImports.h>
#import <CamelBones/Conversions.h>
#import <CamelBones/Structs.h>

#import "CBSuper.h"
#import "CBStructureTests.h"
#import "CBPropertyTests.h"

MODULE = CamelBones::Tests		PACKAGE = CamelBones::Tests

PROTOTYPES: ENABLE

void
force_link()
CODE:
    id foo = [[CBSuper alloc] init];
    id bar = [[CBStructureTests alloc] init];
    id baz = [[CBPropertyTests alloc] init];

SV*
cbt_isNil(obj)
	id obj;
CODE:
	if (obj == nil) {
		XSRETURN_YES;
	} else {
		XSRETURN_NO;
	}

id
cbt_char2string(aChar)
    char aChar;
CODE:
    RETVAL=[NSString stringWithFormat:@"%d", aChar];


id
cbt_uchar2string(aChar)
    unsigned char aChar;
CODE:
    RETVAL=[NSString stringWithFormat:@"%u", aChar];


id
cbt_int2string(anInt)
    int anInt;
CODE:
    RETVAL=[NSString stringWithFormat:@"%d", anInt];


id
cbt_uint2string(anInt)
    unsigned int anInt;
CODE:
    RETVAL=[NSString stringWithFormat:@"%u", anInt];


id
cbt_long2string(aLong)
    long aLong;
CODE:
    RETVAL=[NSString stringWithFormat:@"%ld", aLong];


id
cbt_ulong2string(aLong)
    unsigned long aLong;
CODE:
    RETVAL=[NSString stringWithFormat:@"%lu", aLong];
