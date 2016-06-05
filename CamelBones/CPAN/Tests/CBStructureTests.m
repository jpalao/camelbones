//
//  CBStructureTests.c
//  CamelBones
//
//  Created by Sherm Pendley on 9/1/10.
//  Copyright 2010 Sherm Pendley.
//

#import <Cocoa/Cocoa.h>
#import "CBStructureTests.h"

@implementation CBStructureTests

- (NSPoint)point {
    return point;
}

- (CGFloat)pointX {
    return point.x;
}

- (CGFloat)pointY {
    return point.y;
}

- (void)setPoint:(NSPoint)value {
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

- (NSRect)rect {
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

- (void)setRect:(NSRect)value {
    rect = value;
}

- (NSSize)size {
    return size;
}

- (CGFloat)sizeWidth {
    return size.width;
}

- (CGFloat)sizeHeight {
    return size.height;
}

- (void)setSize:(NSSize)value {
    size = value;
}

@end
