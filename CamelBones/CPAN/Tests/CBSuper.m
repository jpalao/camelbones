/*
    Super class for subclass tests
    Created on June 26, 2006 by Sherm Pendley
*/

#if TARGET_OS_IPHONE
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif
#import "CBSuper.h"

@implementation CBSuper

- (double) floatValue { return f; }
- (long) intValue { return i; }

- (void) setFloat: (double)newFloat {
    f = newFloat;
    i = (long)newFloat;
}
- (void) setInt: (long)newInt {
    i = newInt;
    f = (double)newInt;
}

@end
