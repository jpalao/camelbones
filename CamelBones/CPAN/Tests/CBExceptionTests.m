/*
    Exception tests
    Creates on 3/4/2007 by Sherm Pendley
*/

#import <Foundation/Foundation.h>
#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
#endif
#import <CamelBones/CamelBones.h>

#import <stdio.h>

@interface CBExceptionTests : NSObject {
}

- (void)bogusPerl;

@end


@implementation CBExceptionTests

- (void)bogusPerl {
    NS_DURING
        [[CBPerl sharedPerl] eval:@"die"];
    NS_HANDLER
        NSLog(@"%@", localException);
    NS_ENDHANDLER
}

@end
