/*
    Super class for subclass tests
    Created on June 26, 2006 by Sherm Pendley
*/

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif
#import "CBSuper.h"
#if TARGET_OS_SIMULATOR
#import <objc/runtime.h>
#endif

@implementation CBSuper

// Disable non pointer isa obj-c runtimes, needed on iOS arm64/macOS x86_64
+(id)allocWithZone:(NSZone *)zone{
    return NSAllocateObject(objc_getClass("CBSuper"), NULL, NULL);
}

+(id)alloc{
    return [super allocWithZone:nil];
}

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
