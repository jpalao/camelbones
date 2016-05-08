//
//  CBStructureTests.c
//  CamelBones
//
//  Created by Sherm Pendley on 9/1/10.
//  Copyright 2010 Sherm Pendley.
//

@interface CBStructureTests : NSObject {
    CGPoint point;
    NSRange range;
    CGRect rect;
    CGSize size;
}

- (CGPoint)point;
- (CGFloat)pointX;
- (CGFloat)pointY;
- (void)setPoint:(CGPoint)value;

- (NSRange)range;
- (unsigned int) rangeLocation;
- (unsigned int) rangeLength;
- (void)setRange:(NSRange)value;

- (CGRect)rect;

- (CGFloat)rectX;
- (CGFloat)rectY;

- (CGFloat)rectWidth;
- (CGFloat)rectHeight;

- (void)setRect:(CGRect)value;

- (CGSize)size;

- (CGFloat)sizeWidth;
- (CGFloat)sizeHeight;
- (void)setSize:(CGSize)value;

@end

