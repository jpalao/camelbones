//
//  Runtime.h
//  CamelBones
//
//  Copyright (c) 2002 Sherm Pendley. All rights reserved.
//

@class NSArray;

// Functions to help interface with the Objective-C runtime

// Create Perl wrappers for all registered ObjC classes
void CBWrapRegisteredClasses(void);

// Create Perl wrappers for a list of ObjC classes
void CBWrapNamedClasses(NSArray *names);

// Create a Perl wrapper for a single ObjC class
void CBWrapObjectiveCClass(Class aClass);

// Query class registration
BOOL CBIsClassRegistered(const char *className);

// Register a Perl class with the runtime
void CBRegisterClassWithSuperClass(const char *className, const char *superName);

// Query method registration
BOOL CBIsObjectMethodRegisteredForClass(SEL selector, Class class);
BOOL CBIsClassMethodRegisteredForClass(SEL selector, Class class);

// Perform method registration
void CBRegisterObjectMethodsForClass(const char *package, NSArray *methods, Class class);
void CBRegisterClassMethodsForClass(const char *package, NSArray *methods, Class class);

// Class handler registration
void CBRegisterClassHandler(void);
