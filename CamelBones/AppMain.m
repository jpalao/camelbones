//
//  AppMain.m
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppMain.h"
#import "CBPerl.h"

int CBApplicationMain(int argc, const char *argv[]) {
    return CBApplicationMain2("main.pl", argc, argv);
}

int CBApplicationMain2(const char *scriptName, int argc, const char *argv[]) {

    NSAutoreleasePool *arPool = [[NSAutoreleasePool alloc] init];
    NSString *wrapperFolder = [[NSBundle mainBundle] resourcePath];
    NSString *mainPL = [NSString stringWithFormat: @"%@/%s", wrapperFolder, scriptName];

    // Run Perl code
    CBPerl *sp = [[CBPerl alloc] initWithFileName:mainPL withDebugger:0 withOptions:nil withArguments:nil];

    // Clean up
    [sp cleanUp];
    [arPool release];
    return 0;
}

