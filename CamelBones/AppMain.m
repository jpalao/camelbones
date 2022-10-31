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
    NSError *error = nil;
    char cpwd[MAXPATHLEN];
    getcwd(cpwd, MAXPATHLEN -1);
    NSURL * pwd = [NSURL URLWithString: [NSString stringWithCString:cpwd encoding:NSUTF8StringEncoding]];
    // Run Perl code
    [[CBPerl alloc] initWithFileName:mainPL withAbsolutePwd: pwd.absoluteURL.path withDebugger:0 withOptions:nil withArguments:nil error:&error completion:nil];
    //TODO handle error

    [arPool release];
    return 0;
}

