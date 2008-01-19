//
//  Conversions.h
//  CamelBones
//
//  Copyright (c) 2004 Sherm Pendley. All rights reserved.
//

#import <Foundation/Foundation.h>

id CBDerefSVtoID(void* sv);
void* CBDerefIDtoSV(id target);

Class CBClassFromSV(void* sv);
void* CBSVFromClass(Class c);

SEL CBSelectorFromSV(void* sv);
void* CBSVFromSelector(SEL aSel);

void CBPoke(void *address, void *object, unsigned length);
