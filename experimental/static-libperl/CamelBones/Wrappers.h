//
//  Wrappers.h
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import <Foundation/Foundation.h>

// Create a Perl object that "wraps" an Objective-C object
void* CBCreateWrapperObject(id obj);
void* CBCreateWrapperObjectWithClassName(id obj, NSString* className);

// Create a new Perl object blessed into the specified package
void* CBCreateObjectOfClass(NSString *className);

