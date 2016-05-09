//
//  CBStructureTests.c
//  CamelBones
//
//  Created by Sherm Pendley on 9/1/10.
//  Copyright 2010 Sherm Pendley.
//

@interface CBStructureTests : NSObject {
    NSPoint point;
    NSRange range;
    NSRect rect;
    NSSize size;
}

- (NSPoint)point;
- (CGFloat)pointX;
- (CGFloat)pointY;
- (void)setPoint:(NSPoint)value;

- (NSRange)range;
- (unsigned int) rangeLocation;
- (unsigned int) rangeLength;
- (void)setRange:(NSRange)value;

- (NSRect)rect;

- (CGFloat)rectX;
- (CGFloat)rectY;

- (CGFloat)rectWidth;
- (CGFloat)rectHeight;

- (void)setRect:(NSRect)value;

- (NSSize)size;

- (CGFloat)sizeWidth;
- (CGFloat)sizeHeight;
- (void)setSize:(NSSize)value;

@end

