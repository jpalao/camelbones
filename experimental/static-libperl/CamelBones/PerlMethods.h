//
//  PerlMethods.h
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import <Foundation/Foundation.h>

// Get information about a Perl object
NSString* CBGetMethodNameForSelector(void* sv, SEL selector);
NSString* CBGetMethodArgumentSignatureForSelector(void* sv, SEL selector);
NSString* CBGetMethodReturnSignatureForSelector(void* sv, SEL selector);

// IMP registered as a native method
id CBPerlIMP(id self, SEL _cmd, ...);
