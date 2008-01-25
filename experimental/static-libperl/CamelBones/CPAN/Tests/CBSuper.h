/*
 *  CBSuper.h
 *  CamelBones
 *
 *
 */

@interface CBSuper : NSObject {
    double f;
    long i;
}

- (double) floatValue;
- (long) intValue;

- (void) setFloat: (double)newVal;
- (void) setInt: (long)newInt;
@end


