//
//  CBStructureTests.c
//  CamelBones
//
//  Created by Sherm Pendley on 9/1/10.
//  Copyright 2010 Sherm Pendley.
//

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif
#import "CBStructureTests.h"

@implementation CBStructureTests

- (CGPoint)point {
    return point;
}

- (CGFloat)pointX {
    return point.x;
}

- (CGFloat)pointY {
    return point.y;
}

- (void)setPoint:(CGPoint)value {
    point = value;
}

- (NSRange)range {
    return range;
}

- (NSInteger) rangeLocation {
    return range.location;
}

- (NSInteger) rangeLength {
    return range.length;
}

- (void)setRange:(NSRange)value {
    range = value;
}

- (CGRect)rect {
    return rect;
}

- (CGFloat)rectX {
    return rect.origin.x;
}

- (CGFloat)rectY {
    return rect.origin.y;
}

- (CGFloat)rectWidth {
    return rect.size.width;
}

- (CGFloat)rectHeight {
    return rect.size.height;
}

- (void)setRect:(CGRect)value {
    rect = value;
}

- (CGSize)size {
    return size;
}

- (CGFloat)sizeWidth {
    return size.width;
}

- (CGFloat)sizeHeight {
    return size.height;
}

- (void)setSize:(CGSize)value {
    size = value;
}

@end
