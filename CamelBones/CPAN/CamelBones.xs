#import <CamelBones/AppMain.h>
#import <CamelBones/CBPerl.h>
#import <CamelBones/NativeMethods_real.h>
#import <CamelBones/Conversions_real.h>
#import <CamelBones/Runtime_real.h>
#import <CamelBones/PerlImports.h>

#ifdef GNUSTEP
#include <objc/objc.h>
#else
#import <objc/objc-runtime.h>
#endif

#import <XSUB.h>

MODULE = CamelBones	PACKAGE = CamelBones

PROTOTYPES: ENABLE

void
REAL_CBPoke(address, object, size=0)
	void *address;
	SV *object;
	unsigned size;
	ALIAS:
	CamelBones::CBPoke = 1
	CamelBones::REAL_CBPoke = 2

void
CBInit(archver)
    char *archver
    CODE:
    NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
    CBSetPerlArchver(archver);
    [[CBPerl alloc] initXS];

SV*
REAL_CBCallNativeMethod(this, sel, args, isSuper)
    SV* this;
    SEL sel;
    SV *args;
    BOOL isSuper;
    ALIAS:
    CamelBones::CBCallNativeMethod=1
    CamelBones::REAL_CBCallNativeMethod=2

BOOL
REAL_CBIsClassRegistered(className)
    const char *className;
    ALIAS:
    CamelBones::CBIsClassRegistered=1
    CamelBones::REAL_CBIsClassRegistered=2

void
REAL_CBRegisterClassWithSuperClass(className, superName)
    const char *className;
    const char *superName;
    ALIAS:
    CamelBones::CBRegisterClassWithSuperClass=1
    CamelBones::REAL_CBRegisterClassWithSuperClass=2

BOOL
REAL_CBIsObjectMethodRegisteredForClass(selector, class)
    SEL selector;
    Class class;
    ALIAS:
    CamelBones::CBIsObjectMethodRegisteredForClass=1
    CamelBones::REAL_CBIsObjectMethodRegisteredForClass=2

BOOL
REAL_CBIsClassMethodRegisteredForClass(selector, class)
    SEL selector;
    Class class;
    ALIAS:
    CamelBones::CBIsClassMethodRegisteredForClass=1
    CamelBones::REAL_CBIsClassMethodRegisteredForClass=2

void
REAL_CBRegisterObjectMethodsForClass(package, methods, class)
    const char *package;
    id methods;
    Class class;
    ALIAS:
    CamelBones::CBRegisterObjectMethodsForClass=1
    CamelBones::REAL_CBRegisterObjectMethodsForClass=2
    
void
REAL_CBRegisterClassMethodsForClass(package, methods, class)
    const char *package;
    id methods;
    Class class;
    ALIAS:
    CamelBones::CBRegisterClassMethodsForClass=1
    CamelBones::REAL_CBRegisterClassMethodsForClass=2

