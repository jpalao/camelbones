//
//  CBPropertyTests.h
//  CamelBones
//
//  Created by Sherm Pendley on 9/2/10.
//  Copyright 2010 Sherm Pendley.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif


@interface CBPropertyTests : NSObject {
}

- (BOOL)testObject:(id)target withChar:(char)value;
- (BOOL)testObject:(id)target withUchar:(unsigned char)value;
- (BOOL)testObject:(id)target withInt:(int)value;
- (BOOL)testObject:(id)target withUint:(unsigned int)value;
- (BOOL)testObject:(id)target withLong:(long)value;
- (BOOL)testObject:(id)target withUlong:(unsigned long)value;
- (BOOL)testObject:(id)target withFloat:(float)value;
- (BOOL)testObject:(id)target withDouble:(double)value;
- (BOOL)testObject:(id)target withString:(char*)value;
- (BOOL)testObject:(id)target withObject:(id)value;
- (BOOL)testObject:(id)target withPointer:(void*)value;
- (BOOL)testObject:(id)target withSelector:(SEL)value;
- (BOOL)testObject:(id)target withRange:(NSRange)value;
- (BOOL)testObject:(id)target withPoint:(CGPoint)value;
- (BOOL)testObject:(id)target withRect:(CGRect)value;
- (BOOL)testObject:(id)target withSize:(CGSize)value;

@end
