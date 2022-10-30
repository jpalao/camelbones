
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#if !TARGET_OS_IPHONE
#import <AppKit/AppKit.h>
#endif

#import <CamelBones/PerlImports.h>
#import <CamelBones/Conversions.h>
#import <CamelBones/Structs.h>

MODULE = CamelBones::CoreGraphics		PACKAGE = CamelBones::CoreGraphics

PROTOTYPES: ENABLE


TYPEMAP: <<EMBEDDED_TYPEMAP

TYPEMAP

unsigned long long      T_U_LONG_LONG
uint64_t                T_U_LONG_LONG   
unsigned long long *    T_PTR
uint64_t *              T_PTR

long long           	T_LONG_LONG
int64_t                 T_LONG_LONG
long long *             T_PTR
int64_t *               T_PTR

unsigned short * 		T_PTR
unsigned int *   		T_PTR

CGPatternRef				T_PTR
OpaqueCMProfileRef *				T_PTR
CFDateRef				T_PTR
CGDataProviderRef				T_PTR
CGFontRef				T_PTR
CGVector 				T_CGVECTOR
CFStringRef				T_PTR
CGPDFPageRef				T_PTR
CGDataConsumerRef				T_PTR
CGFunctionRef				T_PTR
CGAffineTransform 				T_CGAFFINETRANSFORM
CGPDFDictionaryRef				T_PTR
CFDataRef				T_PTR
CGPDFArrayRef				T_PTR
CGColorRef				T_PTR
CGPDFDictionaryRef *				T_PTR
CGDisplayStreamRef				T_PTR
CGPDFStringRef *				T_PTR
CGLayerRef				T_PTR
CGContextRef				T_PTR
CFAllocatorRef				T_PTR
CFArrayRef				T_PTR
CGColorSpaceRef				T_PTR
CGPDFOperatorTableRef				T_PTR
CFRunLoopSourceRef				T_PTR
CGPDFStreamRef *				T_PTR
CGPDFStreamRef				T_PTR
CGPathRef				T_PTR
CGGradientRef				T_PTR
CGShadingRef				T_PTR
CGPDFContentStreamRef				T_PTR
CFURLRef				T_PTR
CFDictionaryRef				T_PTR
__CGEventTapProxy *				T_PTR
CGScreenUpdateMoveDelta *				T_PTR
char* * 				T_PTR
CFMachPortRef				T_PTR
CGImageRef				T_PTR
CGRect **				T_PTR
CGAffineTransform *				T_PTR
CGPDFDocumentRef				T_PTR
CGPDFScannerRef				T_PTR
CGPDFStringRef				T_PTR
ProcessSerialNumber *				T_PTR

INPUT

T_U_LONG_LONG
    $var = (unsigned long long)SvUV($arg);

T_LONG_LONG
    $var = (long long)SvIV($arg);
    
T_CGVECTOR
    $var = CBCGVectorFromSV($arg);

T_CGAFFINETRANSFORM
    $var = CBCGAffineTransformFromSV($arg);


OUTPUT

T_U_LONG_LONG
    sv_setuv($arg, (UV)$var);

T_LONG_LONG    
    sv_setiv($arg, (IV)$var);
   
T_CGVECTOR
    $arg = CBCGVectorToSV($var);

T_CGAFFINETRANSFORM
    $arg = CBCGAffineTransformToSV($var);

EMBEDDED_TYPEMAP



#if !TARGET_OS_IPHONE
int
CGAcquireDisplayFadeReservation(arg0 ,arg1)
    float arg0;
    unsigned int *  arg1;

#endif


CGAffineTransform 
CGAffineTransformConcat(arg0 ,arg1)
    CGAffineTransform  arg0;
    CGAffineTransform  arg1;



bool
CGAffineTransformEqualToTransform(arg0 ,arg1)
    CGAffineTransform  arg0;
    CGAffineTransform  arg1;



CGAffineTransform 
CGAffineTransformInvert(arg0)
    CGAffineTransform  arg0;



bool
CGAffineTransformIsIdentity(arg0)
    CGAffineTransform  arg0;



#if defined(__x86_64__) || defined(__arm64__)
CGAffineTransform 
CGAffineTransformMake(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;

#else
CGAffineTransform 
CGAffineTransformMake(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    float arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGAffineTransform 
CGAffineTransformMakeRotation(arg0)
    double arg0;

#else
CGAffineTransform 
CGAffineTransformMakeRotation(arg0)
    float arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGAffineTransform 
CGAffineTransformMakeScale(arg0 ,arg1)
    double arg0;
    double arg1;

#else
CGAffineTransform 
CGAffineTransformMakeScale(arg0 ,arg1)
    float arg0;
    float arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGAffineTransform 
CGAffineTransformMakeTranslation(arg0 ,arg1)
    double arg0;
    double arg1;

#else
CGAffineTransform 
CGAffineTransformMakeTranslation(arg0 ,arg1)
    float arg0;
    float arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGAffineTransform 
CGAffineTransformRotate(arg0 ,arg1)
    CGAffineTransform  arg0;
    double arg1;

#else
CGAffineTransform 
CGAffineTransformRotate(arg0 ,arg1)
    CGAffineTransform  arg0;
    float arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGAffineTransform 
CGAffineTransformScale(arg0 ,arg1 ,arg2)
    CGAffineTransform  arg0;
    double arg1;
    double arg2;

#else
CGAffineTransform 
CGAffineTransformScale(arg0 ,arg1 ,arg2)
    CGAffineTransform  arg0;
    float arg1;
    float arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGAffineTransform 
CGAffineTransformTranslate(arg0 ,arg1 ,arg2)
    CGAffineTransform  arg0;
    double arg1;
    double arg2;

#else
CGAffineTransform 
CGAffineTransformTranslate(arg0 ,arg1 ,arg2)
    CGAffineTransform  arg0;
    float arg1;
    float arg2;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
int
CGAssociateMouseAndMouseCursorPosition(arg0)
    unsigned int arg0;

#else
int
CGAssociateMouseAndMouseCursorPosition(arg0)
    int arg0;

#endif
#endif


#if defined(__x86_64__) || defined(__arm64__)
CGContextRef
CGBitmapContextCreate(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    void *  arg0;
    unsigned long long arg1;
    unsigned long long arg2;
    unsigned long long arg3;
    unsigned long long arg4;
    CGColorSpaceRef arg5;
    unsigned int arg6;

#else
CGContextRef
CGBitmapContextCreate(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    void *  arg0;
    unsigned long arg1;
    unsigned long arg2;
    unsigned long arg3;
    unsigned long arg4;
    CGColorSpaceRef arg5;
    unsigned int arg6;

#endif


CGImageRef
CGBitmapContextCreateImage(arg0)
    CGContextRef arg0;



unsigned int
CGBitmapContextGetAlphaInfo(arg0)
    CGContextRef arg0;



unsigned int
CGBitmapContextGetBitmapInfo(arg0)
    CGContextRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGBitmapContextGetBitsPerComponent(arg0)
    CGContextRef arg0;

#else
unsigned long
CGBitmapContextGetBitsPerComponent(arg0)
    CGContextRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGBitmapContextGetBitsPerPixel(arg0)
    CGContextRef arg0;

#else
unsigned long
CGBitmapContextGetBitsPerPixel(arg0)
    CGContextRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGBitmapContextGetBytesPerRow(arg0)
    CGContextRef arg0;

#else
unsigned long
CGBitmapContextGetBytesPerRow(arg0)
    CGContextRef arg0;

#endif


CGColorSpaceRef
CGBitmapContextGetColorSpace(arg0)
    CGContextRef arg0;



void * 
CGBitmapContextGetData(arg0)
    CGContextRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGBitmapContextGetHeight(arg0)
    CGContextRef arg0;

#else
unsigned long
CGBitmapContextGetHeight(arg0)
    CGContextRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGBitmapContextGetWidth(arg0)
    CGContextRef arg0;

#else
unsigned long
CGBitmapContextGetWidth(arg0)
    CGContextRef arg0;

#endif


#if !TARGET_OS_IPHONE
int
CGCaptureAllDisplays()

#endif


#if !TARGET_OS_IPHONE
int
CGCaptureAllDisplaysWithOptions(arg0)
    unsigned int arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGColorRef
CGColorCreate(arg0 ,arg1)
    CGColorSpaceRef arg0;
    double *  arg1;

#else
CGColorRef
CGColorCreate(arg0 ,arg1)
    CGColorSpaceRef arg0;
    float *  arg1;

#endif


CGColorRef
CGColorCreateCopy(arg0)
    CGColorRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
CGColorRef
CGColorCreateCopyWithAlpha(arg0 ,arg1)
    CGColorRef arg0;
    double arg1;

#else
CGColorRef
CGColorCreateCopyWithAlpha(arg0 ,arg1)
    CGColorRef arg0;
    float arg1;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
CGColorRef
CGColorCreateGenericCMYK(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;

#else
CGColorRef
CGColorCreateGenericCMYK(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    float arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
CGColorRef
CGColorCreateGenericGray(arg0 ,arg1)
    double arg0;
    double arg1;

#else
CGColorRef
CGColorCreateGenericGray(arg0 ,arg1)
    float arg0;
    float arg1;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
CGColorRef
CGColorCreateGenericRGB(arg0 ,arg1 ,arg2 ,arg3)
    double arg0;
    double arg1;
    double arg2;
    double arg3;

#else
CGColorRef
CGColorCreateGenericRGB(arg0 ,arg1 ,arg2 ,arg3)
    float arg0;
    float arg1;
    float arg2;
    float arg3;

#endif
#endif


#if defined(__x86_64__) || defined(__arm64__)
CGColorRef
CGColorCreateWithPattern(arg0 ,arg1 ,arg2)
    CGColorSpaceRef arg0;
    CGPatternRef arg1;
    double *  arg2;

#else
CGColorRef
CGColorCreateWithPattern(arg0 ,arg1 ,arg2)
    CGColorSpaceRef arg0;
    CGPatternRef arg1;
    float *  arg2;

#endif


bool
CGColorEqualToColor(arg0 ,arg1)
    CGColorRef arg0;
    CGColorRef arg1;



#if defined(__x86_64__) || defined(__arm64__)
double
CGColorGetAlpha(arg0)
    CGColorRef arg0;

#else
float
CGColorGetAlpha(arg0)
    CGColorRef arg0;

#endif


CGColorSpaceRef
CGColorGetColorSpace(arg0)
    CGColorRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
double * 
CGColorGetComponents(arg0)
    CGColorRef arg0;

#else
float * 
CGColorGetComponents(arg0)
    CGColorRef arg0;

#endif


#if !TARGET_OS_IPHONE
CGColorRef
CGColorGetConstantColor(arg0)
    CFStringRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGColorGetNumberOfComponents(arg0)
    CGColorRef arg0;

#else
unsigned long
CGColorGetNumberOfComponents(arg0)
    CGColorRef arg0;

#endif


CGPatternRef
CGColorGetPattern(arg0)
    CGColorRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGColorGetTypeID()

#else
unsigned long
CGColorGetTypeID()

#endif


void
CGColorRelease(arg0)
    CGColorRef arg0;



CGColorRef
CGColorRetain(arg0)
    CGColorRef arg0;



CFDataRef
CGColorSpaceCopyICCProfile(arg0)
    CGColorSpaceRef arg0;



#if !TARGET_OS_IPHONE
CFStringRef
CGColorSpaceCopyName(arg0)
    CGColorSpaceRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGColorSpaceRef
CGColorSpaceCreateCalibratedGray(arg0 ,arg1 ,arg2)
    double *  arg0;
    double *  arg1;
    double arg2;

#else
CGColorSpaceRef
CGColorSpaceCreateCalibratedGray(arg0 ,arg1 ,arg2)
    float *  arg0;
    float *  arg1;
    float arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGColorSpaceRef
CGColorSpaceCreateCalibratedRGB(arg0 ,arg1 ,arg2 ,arg3)
    double *  arg0;
    double *  arg1;
    double *  arg2;
    double *  arg3;

#else
CGColorSpaceRef
CGColorSpaceCreateCalibratedRGB(arg0 ,arg1 ,arg2 ,arg3)
    float *  arg0;
    float *  arg1;
    float *  arg2;
    float *  arg3;

#endif


CGColorSpaceRef
CGColorSpaceCreateDeviceCMYK()



CGColorSpaceRef
CGColorSpaceCreateDeviceGray()



CGColorSpaceRef
CGColorSpaceCreateDeviceRGB()



#if defined(__x86_64__) || defined(__arm64__)
CGColorSpaceRef
CGColorSpaceCreateICCBased(arg0 ,arg1 ,arg2 ,arg3)
    unsigned long long arg0;
    double *  arg1;
    CGDataProviderRef arg2;
    CGColorSpaceRef arg3;

#else
CGColorSpaceRef
CGColorSpaceCreateICCBased(arg0 ,arg1 ,arg2 ,arg3)
    unsigned long arg0;
    float *  arg1;
    CGDataProviderRef arg2;
    CGColorSpaceRef arg3;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGColorSpaceRef
CGColorSpaceCreateIndexed(arg0 ,arg1 ,arg2)
    CGColorSpaceRef arg0;
    unsigned long long arg1;
    char* arg2;

#else
CGColorSpaceRef
CGColorSpaceCreateIndexed(arg0 ,arg1 ,arg2)
    CGColorSpaceRef arg0;
    unsigned long arg1;
    char* arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGColorSpaceRef
CGColorSpaceCreateLab(arg0 ,arg1 ,arg2)
    double *  arg0;
    double *  arg1;
    double *  arg2;

#else
CGColorSpaceRef
CGColorSpaceCreateLab(arg0 ,arg1 ,arg2)
    float *  arg0;
    float *  arg1;
    float *  arg2;

#endif


CGColorSpaceRef
CGColorSpaceCreatePattern(arg0)
    CGColorSpaceRef arg0;



CGColorSpaceRef
CGColorSpaceCreateWithICCProfile(arg0)
    CFDataRef arg0;



CGColorSpaceRef
CGColorSpaceCreateWithName(arg0)
    CFStringRef arg0;


#if 0
CGColorSpaceRef
CGColorSpaceCreateWithPlatformColorSpace(arg0)
    OpaqueCMProfileRef * arg0;

#endif


CGColorSpaceRef
CGColorSpaceGetBaseColorSpace(arg0)
    CGColorSpaceRef arg0;



void
CGColorSpaceGetColorTable(arg0 ,arg1)
    CGColorSpaceRef arg0;
    char* arg1;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGColorSpaceGetColorTableCount(arg0)
    CGColorSpaceRef arg0;

#else
unsigned long
CGColorSpaceGetColorTableCount(arg0)
    CGColorSpaceRef arg0;

#endif


int
CGColorSpaceGetModel(arg0)
    CGColorSpaceRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGColorSpaceGetNumberOfComponents(arg0)
    CGColorSpaceRef arg0;

#else
unsigned long
CGColorSpaceGetNumberOfComponents(arg0)
    CGColorSpaceRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGColorSpaceGetTypeID()

#else
unsigned long
CGColorSpaceGetTypeID()

#endif


void
CGColorSpaceRelease(arg0)
    CGColorSpaceRef arg0;



CGColorSpaceRef
CGColorSpaceRetain(arg0)
    CGColorSpaceRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextAddArc(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGContextRef arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;
    int arg6;

#else
void
CGContextAddArc(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGContextRef arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;
    int arg6;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextAddArcToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGContextRef arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;

#else
void
CGContextAddArcToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGContextRef arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextAddCurveToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGContextRef arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;
    double arg6;

#else
void
CGContextAddCurveToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGContextRef arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;
    float arg6;

#endif


void
CGContextAddEllipseInRect(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextAddLineToPoint(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    double arg1;
    double arg2;

#else
void
CGContextAddLineToPoint(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    float arg1;
    float arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextAddLines(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPoint * arg1;
    unsigned long long arg2;

#else
void
CGContextAddLines(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPoint * arg1;
    unsigned long arg2;

#endif


void
CGContextAddPath(arg0 ,arg1)
    CGContextRef arg0;
    CGPathRef arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextAddQuadCurveToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;

#else
void
CGContextAddQuadCurveToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;

#endif


void
CGContextAddRect(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextAddRects(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect * arg1;
    unsigned long long arg2;

#else
void
CGContextAddRects(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect * arg1;
    unsigned long arg2;

#endif


void
CGContextBeginPage(arg0 ,arg1)
    CGContextRef arg0;
    CGRect * arg1;



void
CGContextBeginPath(arg0)
    CGContextRef arg0;



void
CGContextBeginTransparencyLayer(arg0 ,arg1)
    CGContextRef arg0;
    CFDictionaryRef arg1;



void
CGContextBeginTransparencyLayerWithRect(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect  arg1;
    CFDictionaryRef arg2;



void
CGContextClearRect(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



void
CGContextClip(arg0)
    CGContextRef arg0;



void
CGContextClipToMask(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect  arg1;
    CGImageRef arg2;



void
CGContextClipToRect(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextClipToRects(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect * arg1;
    unsigned long long arg2;

#else
void
CGContextClipToRects(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect * arg1;
    unsigned long arg2;

#endif


void
CGContextClosePath(arg0)
    CGContextRef arg0;



void
CGContextConcatCTM(arg0 ,arg1)
    CGContextRef arg0;
    CGAffineTransform  arg1;



CGPoint 
CGContextConvertPointToDeviceSpace(arg0 ,arg1)
    CGContextRef arg0;
    CGPoint  arg1;



CGPoint 
CGContextConvertPointToUserSpace(arg0 ,arg1)
    CGContextRef arg0;
    CGPoint  arg1;



CGRect 
CGContextConvertRectToDeviceSpace(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



CGRect 
CGContextConvertRectToUserSpace(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



CGSize 
CGContextConvertSizeToDeviceSpace(arg0 ,arg1)
    CGContextRef arg0;
    CGSize  arg1;



CGSize 
CGContextConvertSizeToUserSpace(arg0 ,arg1)
    CGContextRef arg0;
    CGSize  arg1;



CGPathRef
CGContextCopyPath(arg0)
    CGContextRef arg0;



void
CGContextDrawImage(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect  arg1;
    CGImageRef arg2;



void
CGContextDrawLayerAtPoint(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPoint  arg1;
    CGLayerRef arg2;



void
CGContextDrawLayerInRect(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect  arg1;
    CGLayerRef arg2;



void
CGContextDrawLinearGradient(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    CGGradientRef arg1;
    CGPoint  arg2;
    CGPoint  arg3;
    unsigned int arg4;



#if !TARGET_OS_IPHONE
void
CGContextDrawPDFDocument(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    CGRect  arg1;
    CGPDFDocumentRef arg2;
    int arg3;

#endif


void
CGContextDrawPDFPage(arg0 ,arg1)
    CGContextRef arg0;
    CGPDFPageRef arg1;



void
CGContextDrawPath(arg0 ,arg1)
    CGContextRef arg0;
    int arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextDrawRadialGradient(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGContextRef arg0;
    CGGradientRef arg1;
    CGPoint  arg2;
    double arg3;
    CGPoint  arg4;
    double arg5;
    unsigned int arg6;

#else
void
CGContextDrawRadialGradient(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGContextRef arg0;
    CGGradientRef arg1;
    CGPoint  arg2;
    float arg3;
    CGPoint  arg4;
    float arg5;
    unsigned int arg6;

#endif


void
CGContextDrawShading(arg0 ,arg1)
    CGContextRef arg0;
    CGShadingRef arg1;



void
CGContextDrawTiledImage(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect  arg1;
    CGImageRef arg2;



void
CGContextEOClip(arg0)
    CGContextRef arg0;



void
CGContextEOFillPath(arg0)
    CGContextRef arg0;



void
CGContextEndPage(arg0)
    CGContextRef arg0;



void
CGContextEndTransparencyLayer(arg0)
    CGContextRef arg0;



void
CGContextFillEllipseInRect(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



void
CGContextFillPath(arg0)
    CGContextRef arg0;



void
CGContextFillRect(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextFillRects(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect * arg1;
    unsigned long long arg2;

#else
void
CGContextFillRects(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect * arg1;
    unsigned long arg2;

#endif


void
CGContextFlush(arg0)
    CGContextRef arg0;



CGAffineTransform 
CGContextGetCTM(arg0)
    CGContextRef arg0;



CGRect 
CGContextGetClipBoundingBox(arg0)
    CGContextRef arg0;



int
CGContextGetInterpolationQuality(arg0)
    CGContextRef arg0;



CGRect 
CGContextGetPathBoundingBox(arg0)
    CGContextRef arg0;



CGPoint 
CGContextGetPathCurrentPoint(arg0)
    CGContextRef arg0;



CGAffineTransform 
CGContextGetTextMatrix(arg0)
    CGContextRef arg0;



CGPoint 
CGContextGetTextPosition(arg0)
    CGContextRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGContextGetTypeID()

#else
unsigned long
CGContextGetTypeID()

#endif


CGAffineTransform 
CGContextGetUserSpaceToDeviceSpaceTransform(arg0)
    CGContextRef arg0;



bool
CGContextIsPathEmpty(arg0)
    CGContextRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextMoveToPoint(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    double arg1;
    double arg2;

#else
void
CGContextMoveToPoint(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    float arg1;
    float arg2;

#endif


bool
CGContextPathContainsPoint(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPoint  arg1;
    int arg2;



void
CGContextRelease(arg0)
    CGContextRef arg0;



void
CGContextReplacePathWithStrokedPath(arg0)
    CGContextRef arg0;



void
CGContextRestoreGState(arg0)
    CGContextRef arg0;



CGContextRef
CGContextRetain(arg0)
    CGContextRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextRotateCTM(arg0 ,arg1)
    CGContextRef arg0;
    double arg1;

#else
void
CGContextRotateCTM(arg0 ,arg1)
    CGContextRef arg0;
    float arg1;

#endif


void
CGContextSaveGState(arg0)
    CGContextRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextScaleCTM(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    double arg1;
    double arg2;

#else
void
CGContextScaleCTM(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    float arg1;
    float arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSelectFont(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    char* arg1;
    double arg2;
    int arg3;

#else
void
CGContextSelectFont(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    char* arg1;
    float arg2;
    int arg3;

#endif


void
CGContextSetAllowsAntialiasing(arg0 ,arg1)
    CGContextRef arg0;
    bool arg1;



void
CGContextSetAllowsFontSmoothing(arg0 ,arg1)
    CGContextRef arg0;
    bool arg1;



void
CGContextSetAllowsFontSubpixelPositioning(arg0 ,arg1)
    CGContextRef arg0;
    bool arg1;



void
CGContextSetAllowsFontSubpixelQuantization(arg0 ,arg1)
    CGContextRef arg0;
    bool arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetAlpha(arg0 ,arg1)
    CGContextRef arg0;
    double arg1;

#else
void
CGContextSetAlpha(arg0 ,arg1)
    CGContextRef arg0;
    float arg1;

#endif


void
CGContextSetBlendMode(arg0 ,arg1)
    CGContextRef arg0;
    int arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetCMYKFillColor(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGContextRef arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;

#else
void
CGContextSetCMYKFillColor(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGContextRef arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetCMYKStrokeColor(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGContextRef arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;

#else
void
CGContextSetCMYKStrokeColor(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGContextRef arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetCharacterSpacing(arg0 ,arg1)
    CGContextRef arg0;
    double arg1;

#else
void
CGContextSetCharacterSpacing(arg0 ,arg1)
    CGContextRef arg0;
    float arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetFillColor(arg0 ,arg1)
    CGContextRef arg0;
    double *  arg1;

#else
void
CGContextSetFillColor(arg0 ,arg1)
    CGContextRef arg0;
    float *  arg1;

#endif


void
CGContextSetFillColorSpace(arg0 ,arg1)
    CGContextRef arg0;
    CGColorSpaceRef arg1;



void
CGContextSetFillColorWithColor(arg0 ,arg1)
    CGContextRef arg0;
    CGColorRef arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetFillPattern(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPatternRef arg1;
    double *  arg2;

#else
void
CGContextSetFillPattern(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPatternRef arg1;
    float *  arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetFlatness(arg0 ,arg1)
    CGContextRef arg0;
    double arg1;

#else
void
CGContextSetFlatness(arg0 ,arg1)
    CGContextRef arg0;
    float arg1;

#endif


void
CGContextSetFont(arg0 ,arg1)
    CGContextRef arg0;
    CGFontRef arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetFontSize(arg0 ,arg1)
    CGContextRef arg0;
    double arg1;

#else
void
CGContextSetFontSize(arg0 ,arg1)
    CGContextRef arg0;
    float arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetGrayFillColor(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    double arg1;
    double arg2;

#else
void
CGContextSetGrayFillColor(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    float arg1;
    float arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetGrayStrokeColor(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    double arg1;
    double arg2;

#else
void
CGContextSetGrayStrokeColor(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    float arg1;
    float arg2;

#endif


void
CGContextSetInterpolationQuality(arg0 ,arg1)
    CGContextRef arg0;
    int arg1;



void
CGContextSetLineCap(arg0 ,arg1)
    CGContextRef arg0;
    int arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetLineDash(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    double arg1;
    double *  arg2;
    unsigned long long arg3;

#else
void
CGContextSetLineDash(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    float arg1;
    float *  arg2;
    unsigned long arg3;

#endif


void
CGContextSetLineJoin(arg0 ,arg1)
    CGContextRef arg0;
    int arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetLineWidth(arg0 ,arg1)
    CGContextRef arg0;
    double arg1;

#else
void
CGContextSetLineWidth(arg0 ,arg1)
    CGContextRef arg0;
    float arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetMiterLimit(arg0 ,arg1)
    CGContextRef arg0;
    double arg1;

#else
void
CGContextSetMiterLimit(arg0 ,arg1)
    CGContextRef arg0;
    float arg1;

#endif


void
CGContextSetPatternPhase(arg0 ,arg1)
    CGContextRef arg0;
    CGSize  arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetRGBFillColor(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;

#else
void
CGContextSetRGBFillColor(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetRGBStrokeColor(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;

#else
void
CGContextSetRGBStrokeColor(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;

#endif


void
CGContextSetRenderingIntent(arg0 ,arg1)
    CGContextRef arg0;
    int arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetShadow(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGSize  arg1;
    double arg2;

#else
void
CGContextSetShadow(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGSize  arg1;
    float arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetShadowWithColor(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    CGSize  arg1;
    double arg2;
    CGColorRef arg3;

#else
void
CGContextSetShadowWithColor(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    CGSize  arg1;
    float arg2;
    CGColorRef arg3;

#endif


void
CGContextSetShouldAntialias(arg0 ,arg1)
    CGContextRef arg0;
    bool arg1;



void
CGContextSetShouldSmoothFonts(arg0 ,arg1)
    CGContextRef arg0;
    bool arg1;



void
CGContextSetShouldSubpixelPositionFonts(arg0 ,arg1)
    CGContextRef arg0;
    bool arg1;



void
CGContextSetShouldSubpixelQuantizeFonts(arg0 ,arg1)
    CGContextRef arg0;
    bool arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetStrokeColor(arg0 ,arg1)
    CGContextRef arg0;
    double *  arg1;

#else
void
CGContextSetStrokeColor(arg0 ,arg1)
    CGContextRef arg0;
    float *  arg1;

#endif


void
CGContextSetStrokeColorSpace(arg0 ,arg1)
    CGContextRef arg0;
    CGColorSpaceRef arg1;



void
CGContextSetStrokeColorWithColor(arg0 ,arg1)
    CGContextRef arg0;
    CGColorRef arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetStrokePattern(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPatternRef arg1;
    double *  arg2;

#else
void
CGContextSetStrokePattern(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPatternRef arg1;
    float *  arg2;

#endif


void
CGContextSetTextDrawingMode(arg0 ,arg1)
    CGContextRef arg0;
    int arg1;



void
CGContextSetTextMatrix(arg0 ,arg1)
    CGContextRef arg0;
    CGAffineTransform  arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextSetTextPosition(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    double arg1;
    double arg2;

#else
void
CGContextSetTextPosition(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    float arg1;
    float arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextShowGlyphs(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    unsigned short *  arg1;
    unsigned long long arg2;

#else
void
CGContextShowGlyphs(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    unsigned short *  arg1;
    unsigned long arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextShowGlyphsAtPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    double arg1;
    double arg2;
    unsigned short *  arg3;
    unsigned long long arg4;

#else
void
CGContextShowGlyphsAtPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    float arg1;
    float arg2;
    unsigned short *  arg3;
    unsigned long arg4;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextShowGlyphsAtPositions(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    unsigned short *  arg1;
    CGPoint * arg2;
    unsigned long long arg3;

#else
void
CGContextShowGlyphsAtPositions(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    unsigned short *  arg1;
    CGPoint * arg2;
    unsigned long arg3;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextShowGlyphsWithAdvances(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    unsigned short *  arg1;
    CGSize * arg2;
    unsigned long long arg3;

#else
void
CGContextShowGlyphsWithAdvances(arg0 ,arg1 ,arg2 ,arg3)
    CGContextRef arg0;
    unsigned short *  arg1;
    CGSize * arg2;
    unsigned long arg3;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextShowText(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    char* arg1;
    unsigned long long arg2;

#else
void
CGContextShowText(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    char* arg1;
    unsigned long arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGContextShowTextAtPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    double arg1;
    double arg2;
    char* arg3;
    unsigned long long arg4;

#else
void
CGContextShowTextAtPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGContextRef arg0;
    float arg1;
    float arg2;
    char* arg3;
    unsigned long arg4;

#endif


void
CGContextStrokeEllipseInRect(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextStrokeLineSegments(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPoint * arg1;
    unsigned long long arg2;

#else
void
CGContextStrokeLineSegments(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGPoint * arg1;
    unsigned long arg2;

#endif


void
CGContextStrokePath(arg0)
    CGContextRef arg0;



void
CGContextStrokeRect(arg0 ,arg1)
    CGContextRef arg0;
    CGRect  arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextStrokeRectWithWidth(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect  arg1;
    double arg2;

#else
void
CGContextStrokeRectWithWidth(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGRect  arg1;
    float arg2;

#endif


void
CGContextSynchronize(arg0)
    CGContextRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
void
CGContextTranslateCTM(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    double arg1;
    double arg2;

#else
void
CGContextTranslateCTM(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    float arg1;
    float arg2;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGCursorIsDrawnInFramebuffer()

#else
int
CGCursorIsDrawnInFramebuffer()

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGCursorIsVisible()

#else
int
CGCursorIsVisible()

#endif
#endif


CGDataConsumerRef
CGDataConsumerCreateWithCFData(arg0)
    CFDataRef arg0;



CGDataConsumerRef
CGDataConsumerCreateWithURL(arg0)
    CFURLRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGDataConsumerGetTypeID()

#else
unsigned long
CGDataConsumerGetTypeID()

#endif


void
CGDataConsumerRelease(arg0)
    CGDataConsumerRef arg0;



CGDataConsumerRef
CGDataConsumerRetain(arg0)
    CGDataConsumerRef arg0;



CFDataRef
CGDataProviderCopyData(arg0)
    CGDataProviderRef arg0;



CGDataProviderRef
CGDataProviderCreateWithCFData(arg0)
    CFDataRef arg0;



CGDataProviderRef
CGDataProviderCreateWithFilename(arg0)
    char* arg0;



CGDataProviderRef
CGDataProviderCreateWithURL(arg0)
    CFURLRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGDataProviderGetTypeID()

#else
unsigned long
CGDataProviderGetTypeID()

#endif


void
CGDataProviderRelease(arg0)
    CGDataProviderRef arg0;



CGDataProviderRef
CGDataProviderRetain(arg0)
    CGDataProviderRef arg0;



#if !TARGET_OS_IPHONE
CFArrayRef
CGDisplayAvailableModes(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
CFDictionaryRef
CGDisplayBestModeForParameters(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    unsigned int arg0;
    unsigned long long arg1;
    unsigned long long arg2;
    unsigned long long arg3;
    unsigned int *  arg4;

#else
CFDictionaryRef
CGDisplayBestModeForParameters(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    unsigned int arg0;
    unsigned long arg1;
    unsigned long arg2;
    unsigned long arg3;
    int *  arg4;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
CFDictionaryRef
CGDisplayBestModeForParametersAndRefreshRate(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    unsigned int arg0;
    unsigned long long arg1;
    unsigned long long arg2;
    unsigned long long arg3;
    double arg4;
    unsigned int *  arg5;

#else
CFDictionaryRef
CGDisplayBestModeForParametersAndRefreshRate(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    unsigned int arg0;
    unsigned long arg1;
    unsigned long arg2;
    unsigned long arg3;
    double arg4;
    int *  arg5;

#endif
#endif


#if !TARGET_OS_IPHONE
CGRect 
CGDisplayBounds(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
int
CGDisplayCapture(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
int
CGDisplayCaptureWithOptions(arg0 ,arg1)
    unsigned int arg0;
    unsigned int arg1;

#endif


#if !TARGET_OS_IPHONE
CFArrayRef
CGDisplayCopyAllDisplayModes(arg0 ,arg1)
    unsigned int arg0;
    CFDictionaryRef arg1;

#endif


#if !TARGET_OS_IPHONE
CGColorSpaceRef
CGDisplayCopyColorSpace(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
CGImageRef
CGDisplayCreateImage(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
CGImageRef
CGDisplayCreateImageForRect(arg0 ,arg1)
    unsigned int arg0;
    CGRect  arg1;

#endif


#if !TARGET_OS_IPHONE
CFDictionaryRef
CGDisplayCurrentMode(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
int
CGDisplayFade(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    unsigned int arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;
    float arg6;
    unsigned int arg7;

#else
int
CGDisplayFade(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    unsigned int arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;
    float arg6;
    int arg7;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayFadeOperationInProgress()

#else
int
CGDisplayFadeOperationInProgress()

#endif
#endif


#if !TARGET_OS_IPHONE
unsigned int
CGDisplayGammaTableCapacity(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
CGContextRef
CGDisplayGetDrawingContext(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
int
CGDisplayHideCursor(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
unsigned int
CGDisplayIDToOpenGLDisplayMask(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
unsigned int
CGDisplayIOServicePort(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsActive(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsActive(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsAlwaysInMirrorSet(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsAlwaysInMirrorSet(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsAsleep(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsAsleep(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsBuiltin(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsBuiltin(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsCaptured(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsCaptured(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsInHWMirrorSet(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsInHWMirrorSet(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsInMirrorSet(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsInMirrorSet(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsMain(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsMain(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsOnline(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsOnline(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayIsStereo(arg0)
    unsigned int arg0;

#else
int
CGDisplayIsStereo(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
unsigned int
CGDisplayMirrorsDisplay(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGDisplayModeGetTypeID()

#else
unsigned long
CGDisplayModeGetTypeID()

#endif
#endif


#if !TARGET_OS_IPHONE
unsigned int
CGDisplayModelNumber(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
int
CGDisplayMoveCursorToPoint(arg0 ,arg1)
    unsigned int arg0;
    CGPoint  arg1;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGDisplayPixelsHigh(arg0)
    unsigned int arg0;

#else
unsigned long
CGDisplayPixelsHigh(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGDisplayPixelsWide(arg0)
    unsigned int arg0;

#else
unsigned long
CGDisplayPixelsWide(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
unsigned int
CGDisplayPrimaryDisplay(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
int
CGDisplayRelease(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
void
CGDisplayRestoreColorSyncSettings()

#endif


#if !TARGET_OS_IPHONE
double
CGDisplayRotation(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
CGSize 
CGDisplayScreenSize(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
unsigned int
CGDisplaySerialNumber(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
int
CGDisplaySetStereoOperation(arg0 ,arg1 ,arg2 ,arg3)
    unsigned int arg0;
    unsigned int arg1;
    unsigned int arg2;
    unsigned int arg3;

#else
int
CGDisplaySetStereoOperation(arg0 ,arg1 ,arg2 ,arg3)
    unsigned int arg0;
    int arg1;
    int arg2;
    unsigned int arg3;

#endif
#endif


#if !TARGET_OS_IPHONE
int
CGDisplayShowCursor(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
CFRunLoopSourceRef
CGDisplayStreamGetRunLoopSource(arg0)
    CGDisplayStreamRef arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGDisplayStreamGetTypeID()

#else
unsigned long
CGDisplayStreamGetTypeID()

#endif
#endif


#if !TARGET_OS_IPHONE
int
CGDisplayStreamStart(arg0)
    CGDisplayStreamRef arg0;

#endif


#if !TARGET_OS_IPHONE
int
CGDisplayStreamStop(arg0)
    CGDisplayStreamRef arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGDisplayStreamUpdateGetTypeID()

#else
unsigned long
CGDisplayStreamUpdateGetTypeID()

#endif
#endif


#if !TARGET_OS_IPHONE
int
CGDisplaySwitchToMode(arg0 ,arg1)
    unsigned int arg0;
    CFDictionaryRef arg1;

#endif


#if !TARGET_OS_IPHONE
unsigned int
CGDisplayUnitNumber(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned int
CGDisplayUsesOpenGLAcceleration(arg0)
    unsigned int arg0;

#else
int
CGDisplayUsesOpenGLAcceleration(arg0)
    unsigned int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
unsigned int
CGDisplayVendorNumber(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
int
CGEnableEventStateCombining(arg0)
    unsigned int arg0;

#else
int
CGEnableEventStateCombining(arg0)
    int arg0;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGEventGetTypeID()

#else
unsigned long
CGEventGetTypeID()

#endif
#endif


#if !TARGET_OS_IPHONE
bool
CGEventSourceButtonState(arg0 ,arg1)
    unsigned int arg0;
    unsigned int arg1;

#endif


#if !TARGET_OS_IPHONE
unsigned int
CGEventSourceCounterForEventType(arg0 ,arg1)
    unsigned int arg0;
    unsigned int arg1;

#endif


#if !TARGET_OS_IPHONE
unsigned long long
CGEventSourceFlagsState(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGEventSourceGetTypeID()

#else
unsigned long
CGEventSourceGetTypeID()

#endif
#endif


#if !TARGET_OS_IPHONE
bool
CGEventSourceKeyState(arg0 ,arg1)
    unsigned int arg0;
    unsigned short arg1;

#endif


#if !TARGET_OS_IPHONE
double
CGEventSourceSecondsSinceLastEventType(arg0 ,arg1)
    unsigned int arg0;
    unsigned int arg1;

#endif


#if !TARGET_OS_IPHONE
void
CGEventTapEnable(arg0 ,arg1)
    CFMachPortRef arg0;
    bool arg1;

#endif


#if !TARGET_OS_IPHONE
bool
CGEventTapIsEnabled(arg0)
    CFMachPortRef arg0;

#endif


bool
CGFontCanCreatePostScriptSubset(arg0 ,arg1)
    CGFontRef arg0;
    int arg1;



CFStringRef
CGFontCopyFullName(arg0)
    CGFontRef arg0;



CFStringRef
CGFontCopyGlyphNameForGlyph(arg0 ,arg1)
    CGFontRef arg0;
    unsigned short arg1;



CFStringRef
CGFontCopyPostScriptName(arg0)
    CGFontRef arg0;



CFDataRef
CGFontCopyTableForTag(arg0 ,arg1)
    CGFontRef arg0;
    unsigned int arg1;



CFArrayRef
CGFontCopyTableTags(arg0)
    CGFontRef arg0;



CFArrayRef
CGFontCopyVariationAxes(arg0)
    CGFontRef arg0;



CFDictionaryRef
CGFontCopyVariations(arg0)
    CGFontRef arg0;



CGFontRef
CGFontCreateCopyWithVariations(arg0 ,arg1)
    CGFontRef arg0;
    CFDictionaryRef arg1;



CFDataRef
CGFontCreatePostScriptEncoding(arg0 ,arg1)
    CGFontRef arg0;
    unsigned short *  arg1;



#if defined(__x86_64__) || defined(__arm64__)
CFDataRef
CGFontCreatePostScriptSubset(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGFontRef arg0;
    CFStringRef arg1;
    int arg2;
    unsigned short *  arg3;
    unsigned long long arg4;
    unsigned short *  arg5;

#else
CFDataRef
CGFontCreatePostScriptSubset(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGFontRef arg0;
    CFStringRef arg1;
    int arg2;
    unsigned short *  arg3;
    unsigned long arg4;
    unsigned short *  arg5;

#endif


CGFontRef
CGFontCreateWithDataProvider(arg0)
    CGDataProviderRef arg0;



CGFontRef
CGFontCreateWithFontName(arg0)
    CFStringRef arg0;



#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
CGFontRef
CGFontCreateWithPlatformFont(arg0)
    unsigned int arg0;

#else
CGFontRef
CGFontCreateWithPlatformFont(arg0)
    unsigned long arg0;

#endif
#endif


int
CGFontGetAscent(arg0)
    CGFontRef arg0;



int
CGFontGetCapHeight(arg0)
    CGFontRef arg0;



int
CGFontGetDescent(arg0)
    CGFontRef arg0;



CGRect 
CGFontGetFontBBox(arg0)
    CGFontRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
bool
CGFontGetGlyphAdvances(arg0 ,arg1 ,arg2 ,arg3)
    CGFontRef arg0;
    unsigned short *  arg1;
    unsigned long long arg2;
    int *  arg3;

#else
bool
CGFontGetGlyphAdvances(arg0 ,arg1 ,arg2 ,arg3)
    CGFontRef arg0;
    unsigned short *  arg1;
    unsigned long arg2;
    int *  arg3;

#endif


#if defined(__x86_64__) || defined(__arm64__)
bool
CGFontGetGlyphBBoxes(arg0 ,arg1 ,arg2 ,arg3)
    CGFontRef arg0;
    unsigned short *  arg1;
    unsigned long long arg2;
    CGRect * arg3;

#else
bool
CGFontGetGlyphBBoxes(arg0 ,arg1 ,arg2 ,arg3)
    CGFontRef arg0;
    unsigned short *  arg1;
    unsigned long arg2;
    CGRect * arg3;

#endif


unsigned short
CGFontGetGlyphWithGlyphName(arg0 ,arg1)
    CGFontRef arg0;
    CFStringRef arg1;



#if defined(__x86_64__) || defined(__arm64__)
double
CGFontGetItalicAngle(arg0)
    CGFontRef arg0;

#else
float
CGFontGetItalicAngle(arg0)
    CGFontRef arg0;

#endif


int
CGFontGetLeading(arg0)
    CGFontRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGFontGetNumberOfGlyphs(arg0)
    CGFontRef arg0;

#else
unsigned long
CGFontGetNumberOfGlyphs(arg0)
    CGFontRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
double
CGFontGetStemV(arg0)
    CGFontRef arg0;

#else
float
CGFontGetStemV(arg0)
    CGFontRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGFontGetTypeID()

#else
unsigned long
CGFontGetTypeID()

#endif


int
CGFontGetUnitsPerEm(arg0)
    CGFontRef arg0;



int
CGFontGetXHeight(arg0)
    CGFontRef arg0;



void
CGFontRelease(arg0)
    CGFontRef arg0;



CGFontRef
CGFontRetain(arg0)
    CGFontRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGFunctionGetTypeID()

#else
unsigned long
CGFunctionGetTypeID()

#endif


void
CGFunctionRelease(arg0)
    CGFunctionRef arg0;



CGFunctionRef
CGFunctionRetain(arg0)
    CGFunctionRef arg0;



#if !TARGET_OS_IPHONE
int
CGGetActiveDisplayList(arg0 ,arg1 ,arg2)
    unsigned int arg0;
    unsigned int *  arg1;
    unsigned int *  arg2;

#endif


#if !TARGET_OS_IPHONE
int
CGGetDisplayTransferByFormula(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7 ,arg8 ,arg9)
    unsigned int arg0;
    float *  arg1;
    float *  arg2;
    float *  arg3;
    float *  arg4;
    float *  arg5;
    float *  arg6;
    float *  arg7;
    float *  arg8;
    float *  arg9;

#endif


#if !TARGET_OS_IPHONE
int
CGGetDisplayTransferByTable(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    unsigned int arg0;
    unsigned int arg1;
    float *  arg2;
    float *  arg3;
    float *  arg4;
    unsigned int *  arg5;

#endif


#if !TARGET_OS_IPHONE
int
CGGetDisplaysWithOpenGLDisplayMask(arg0 ,arg1 ,arg2 ,arg3)
    unsigned int arg0;
    unsigned int arg1;
    unsigned int *  arg2;
    unsigned int *  arg3;

#endif


#if !TARGET_OS_IPHONE
int
CGGetDisplaysWithPoint(arg0 ,arg1 ,arg2 ,arg3)
    CGPoint  arg0;
    unsigned int arg1;
    unsigned int *  arg2;
    unsigned int *  arg3;

#endif


#if !TARGET_OS_IPHONE
int
CGGetDisplaysWithRect(arg0 ,arg1 ,arg2 ,arg3)
    CGRect  arg0;
    unsigned int arg1;
    unsigned int *  arg2;
    unsigned int *  arg3;

#endif


#if !TARGET_OS_IPHONE
void
CGGetLastMouseDelta(arg0 ,arg1)
    int *  arg0;
    int *  arg1;

#endif


#if !TARGET_OS_IPHONE
int
CGGetOnlineDisplayList(arg0 ,arg1 ,arg2)
    unsigned int arg0;
    unsigned int *  arg1;
    unsigned int *  arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGGradientRef
CGGradientCreateWithColorComponents(arg0 ,arg1 ,arg2 ,arg3)
    CGColorSpaceRef arg0;
    double *  arg1;
    double *  arg2;
    unsigned long long arg3;

#else
CGGradientRef
CGGradientCreateWithColorComponents(arg0 ,arg1 ,arg2 ,arg3)
    CGColorSpaceRef arg0;
    float *  arg1;
    float *  arg2;
    unsigned long arg3;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGGradientRef
CGGradientCreateWithColors(arg0 ,arg1 ,arg2)
    CGColorSpaceRef arg0;
    CFArrayRef arg1;
    double *  arg2;

#else
CGGradientRef
CGGradientCreateWithColors(arg0 ,arg1 ,arg2)
    CGColorSpaceRef arg0;
    CFArrayRef arg1;
    float *  arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGGradientGetTypeID()

#else
unsigned long
CGGradientGetTypeID()

#endif


void
CGGradientRelease(arg0)
    CGGradientRef arg0;



CGGradientRef
CGGradientRetain(arg0)
    CGGradientRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
CGImageRef
CGImageCreate(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7 ,arg8 ,arg9 ,arg10)
    unsigned long long arg0;
    unsigned long long arg1;
    unsigned long long arg2;
    unsigned long long arg3;
    unsigned long long arg4;
    CGColorSpaceRef arg5;
    unsigned int arg6;
    CGDataProviderRef arg7;
    double *  arg8;
    bool arg9;
    int arg10;

#else
CGImageRef
CGImageCreate(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7 ,arg8 ,arg9 ,arg10)
    unsigned long arg0;
    unsigned long arg1;
    unsigned long arg2;
    unsigned long arg3;
    unsigned long arg4;
    CGColorSpaceRef arg5;
    unsigned int arg6;
    CGDataProviderRef arg7;
    float *  arg8;
    bool arg9;
    int arg10;

#endif


CGImageRef
CGImageCreateCopy(arg0)
    CGImageRef arg0;



CGImageRef
CGImageCreateCopyWithColorSpace(arg0 ,arg1)
    CGImageRef arg0;
    CGColorSpaceRef arg1;



CGImageRef
CGImageCreateWithImageInRect(arg0 ,arg1)
    CGImageRef arg0;
    CGRect  arg1;



#if defined(__x86_64__) || defined(__arm64__)
CGImageRef
CGImageCreateWithJPEGDataProvider(arg0 ,arg1 ,arg2 ,arg3)
    CGDataProviderRef arg0;
    double *  arg1;
    bool arg2;
    int arg3;

#else
CGImageRef
CGImageCreateWithJPEGDataProvider(arg0 ,arg1 ,arg2 ,arg3)
    CGDataProviderRef arg0;
    float *  arg1;
    bool arg2;
    int arg3;

#endif


CGImageRef
CGImageCreateWithMask(arg0 ,arg1)
    CGImageRef arg0;
    CGImageRef arg1;



#if defined(__x86_64__) || defined(__arm64__)
CGImageRef
CGImageCreateWithMaskingColors(arg0 ,arg1)
    CGImageRef arg0;
    double *  arg1;

#else
CGImageRef
CGImageCreateWithMaskingColors(arg0 ,arg1)
    CGImageRef arg0;
    float *  arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGImageRef
CGImageCreateWithPNGDataProvider(arg0 ,arg1 ,arg2 ,arg3)
    CGDataProviderRef arg0;
    double *  arg1;
    bool arg2;
    int arg3;

#else
CGImageRef
CGImageCreateWithPNGDataProvider(arg0 ,arg1 ,arg2 ,arg3)
    CGDataProviderRef arg0;
    float *  arg1;
    bool arg2;
    int arg3;

#endif


unsigned int
CGImageGetAlphaInfo(arg0)
    CGImageRef arg0;



unsigned int
CGImageGetBitmapInfo(arg0)
    CGImageRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGImageGetBitsPerComponent(arg0)
    CGImageRef arg0;

#else
unsigned long
CGImageGetBitsPerComponent(arg0)
    CGImageRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGImageGetBitsPerPixel(arg0)
    CGImageRef arg0;

#else
unsigned long
CGImageGetBitsPerPixel(arg0)
    CGImageRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGImageGetBytesPerRow(arg0)
    CGImageRef arg0;

#else
unsigned long
CGImageGetBytesPerRow(arg0)
    CGImageRef arg0;

#endif


CGColorSpaceRef
CGImageGetColorSpace(arg0)
    CGImageRef arg0;



CGDataProviderRef
CGImageGetDataProvider(arg0)
    CGImageRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
double * 
CGImageGetDecode(arg0)
    CGImageRef arg0;

#else
float * 
CGImageGetDecode(arg0)
    CGImageRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGImageGetHeight(arg0)
    CGImageRef arg0;

#else
unsigned long
CGImageGetHeight(arg0)
    CGImageRef arg0;

#endif


int
CGImageGetRenderingIntent(arg0)
    CGImageRef arg0;



bool
CGImageGetShouldInterpolate(arg0)
    CGImageRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGImageGetTypeID()

#else
unsigned long
CGImageGetTypeID()

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGImageGetWidth(arg0)
    CGImageRef arg0;

#else
unsigned long
CGImageGetWidth(arg0)
    CGImageRef arg0;

#endif


bool
CGImageIsMask(arg0)
    CGImageRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
CGImageRef
CGImageMaskCreate(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    unsigned long long arg0;
    unsigned long long arg1;
    unsigned long long arg2;
    unsigned long long arg3;
    unsigned long long arg4;
    CGDataProviderRef arg5;
    double *  arg6;
    bool arg7;

#else
CGImageRef
CGImageMaskCreate(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    unsigned long arg0;
    unsigned long arg1;
    unsigned long arg2;
    unsigned long arg3;
    unsigned long arg4;
    CGDataProviderRef arg5;
    float *  arg6;
    bool arg7;

#endif


void
CGImageRelease(arg0)
    CGImageRef arg0;



CGImageRef
CGImageRetain(arg0)
    CGImageRef arg0;



#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
int
CGInhibitLocalEvents(arg0)
    unsigned int arg0;

#else
int
CGInhibitLocalEvents(arg0)
    int arg0;

#endif
#endif


CGLayerRef
CGLayerCreateWithContext(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CGSize  arg1;
    CFDictionaryRef arg2;



CGContextRef
CGLayerGetContext(arg0)
    CGLayerRef arg0;



CGSize 
CGLayerGetSize(arg0)
    CGLayerRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGLayerGetTypeID()

#else
unsigned long
CGLayerGetTypeID()

#endif


void
CGLayerRelease(arg0)
    CGLayerRef arg0;



CGLayerRef
CGLayerRetain(arg0)
    CGLayerRef arg0;



#if !TARGET_OS_IPHONE
unsigned int
CGMainDisplayID()

#endif


#if !TARGET_OS_IPHONE
unsigned int
CGOpenGLDisplayMaskToDisplayID(arg0)
    unsigned int arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFArrayGetBoolean(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long long arg1;
    char* arg2;

#else
bool
CGPDFArrayGetBoolean(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long arg1;
    char* arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPDFArrayGetCount(arg0)
    CGPDFArrayRef arg0;

#else
unsigned long
CGPDFArrayGetCount(arg0)
    CGPDFArrayRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFArrayGetDictionary(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long long arg1;
    CGPDFDictionaryRef * arg2;

#else
bool
CGPDFArrayGetDictionary(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long arg1;
    CGPDFDictionaryRef * arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFArrayGetInteger(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long long arg1;
    long long *  arg2;

#else
bool
CGPDFArrayGetInteger(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long arg1;
    int *  arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFArrayGetName(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long long arg1;
    char* *  arg2;

#else
bool
CGPDFArrayGetName(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long arg1;
    char* *  arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFArrayGetNull(arg0 ,arg1)
    CGPDFArrayRef arg0;
    unsigned long long arg1;

#else
bool
CGPDFArrayGetNull(arg0 ,arg1)
    CGPDFArrayRef arg0;
    unsigned long arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFArrayGetNumber(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long long arg1;
    double *  arg2;

#else
bool
CGPDFArrayGetNumber(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long arg1;
    float *  arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFArrayGetStream(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long long arg1;
    CGPDFStreamRef * arg2;

#else
bool
CGPDFArrayGetStream(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long arg1;
    CGPDFStreamRef * arg2;

#endif


#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFArrayGetString(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long long arg1;
    CGPDFStringRef * arg2;

#else
bool
CGPDFArrayGetString(arg0 ,arg1 ,arg2)
    CGPDFArrayRef arg0;
    unsigned long arg1;
    CGPDFStringRef * arg2;

#endif


CGPDFContentStreamRef
CGPDFContentStreamCreateWithPage(arg0)
    CGPDFPageRef arg0;



CGPDFContentStreamRef
CGPDFContentStreamCreateWithStream(arg0 ,arg1 ,arg2)
    CGPDFStreamRef arg0;
    CGPDFDictionaryRef arg1;
    CGPDFContentStreamRef arg2;



CFArrayRef
CGPDFContentStreamGetStreams(arg0)
    CGPDFContentStreamRef arg0;



void
CGPDFContentStreamRelease(arg0)
    CGPDFContentStreamRef arg0;



CGPDFContentStreamRef
CGPDFContentStreamRetain(arg0)
    CGPDFContentStreamRef arg0;



void
CGPDFContextAddDestinationAtPoint(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CFStringRef arg1;
    CGPoint  arg2;



void
CGPDFContextAddDocumentMetadata(arg0 ,arg1)
    CGContextRef arg0;
    CFDataRef arg1;



void
CGPDFContextBeginPage(arg0 ,arg1)
    CGContextRef arg0;
    CFDictionaryRef arg1;



void
CGPDFContextClose(arg0)
    CGContextRef arg0;



CGContextRef
CGPDFContextCreate(arg0 ,arg1 ,arg2)
    CGDataConsumerRef arg0;
    CGRect * arg1;
    CFDictionaryRef arg2;



CGContextRef
CGPDFContextCreateWithURL(arg0 ,arg1 ,arg2)
    CFURLRef arg0;
    CGRect * arg1;
    CFDictionaryRef arg2;



void
CGPDFContextEndPage(arg0)
    CGContextRef arg0;



void
CGPDFContextSetDestinationForRect(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CFStringRef arg1;
    CGRect  arg2;



void
CGPDFContextSetURLForRect(arg0 ,arg1 ,arg2)
    CGContextRef arg0;
    CFURLRef arg1;
    CGRect  arg2;



bool
CGPDFDictionaryGetBoolean(arg0 ,arg1 ,arg2)
    CGPDFDictionaryRef arg0;
    char* arg1;
    char* arg2;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPDFDictionaryGetCount(arg0)
    CGPDFDictionaryRef arg0;

#else
unsigned long
CGPDFDictionaryGetCount(arg0)
    CGPDFDictionaryRef arg0;

#endif


bool
CGPDFDictionaryGetDictionary(arg0 ,arg1 ,arg2)
    CGPDFDictionaryRef arg0;
    char* arg1;
    CGPDFDictionaryRef * arg2;



#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFDictionaryGetInteger(arg0 ,arg1 ,arg2)
    CGPDFDictionaryRef arg0;
    char* arg1;
    long long *  arg2;

#else
bool
CGPDFDictionaryGetInteger(arg0 ,arg1 ,arg2)
    CGPDFDictionaryRef arg0;
    char* arg1;
    int *  arg2;

#endif


bool
CGPDFDictionaryGetName(arg0 ,arg1 ,arg2)
    CGPDFDictionaryRef arg0;
    char* arg1;
    char* *  arg2;



#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFDictionaryGetNumber(arg0 ,arg1 ,arg2)
    CGPDFDictionaryRef arg0;
    char* arg1;
    double *  arg2;

#else
bool
CGPDFDictionaryGetNumber(arg0 ,arg1 ,arg2)
    CGPDFDictionaryRef arg0;
    char* arg1;
    float *  arg2;

#endif


bool
CGPDFDictionaryGetStream(arg0 ,arg1 ,arg2)
    CGPDFDictionaryRef arg0;
    char* arg1;
    CGPDFStreamRef * arg2;



bool
CGPDFDictionaryGetString(arg0 ,arg1 ,arg2)
    CGPDFDictionaryRef arg0;
    char* arg1;
    CGPDFStringRef * arg2;



bool
CGPDFDocumentAllowsCopying(arg0)
    CGPDFDocumentRef arg0;



bool
CGPDFDocumentAllowsPrinting(arg0)
    CGPDFDocumentRef arg0;



CGPDFDocumentRef
CGPDFDocumentCreateWithProvider(arg0)
    CGDataProviderRef arg0;



CGPDFDocumentRef
CGPDFDocumentCreateWithURL(arg0)
    CFURLRef arg0;



#if !TARGET_OS_IPHONE
CGRect 
CGPDFDocumentGetArtBox(arg0 ,arg1)
    CGPDFDocumentRef arg0;
    int arg1;

#endif


#if !TARGET_OS_IPHONE
CGRect 
CGPDFDocumentGetBleedBox(arg0 ,arg1)
    CGPDFDocumentRef arg0;
    int arg1;

#endif


CGPDFDictionaryRef
CGPDFDocumentGetCatalog(arg0)
    CGPDFDocumentRef arg0;



#if !TARGET_OS_IPHONE
CGRect 
CGPDFDocumentGetCropBox(arg0 ,arg1)
    CGPDFDocumentRef arg0;
    int arg1;

#endif


CGPDFArrayRef
CGPDFDocumentGetID(arg0)
    CGPDFDocumentRef arg0;



CGPDFDictionaryRef
CGPDFDocumentGetInfo(arg0)
    CGPDFDocumentRef arg0;



#if !TARGET_OS_IPHONE
CGRect 
CGPDFDocumentGetMediaBox(arg0 ,arg1)
    CGPDFDocumentRef arg0;
    int arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPDFDocumentGetNumberOfPages(arg0)
    CGPDFDocumentRef arg0;

#else
unsigned long
CGPDFDocumentGetNumberOfPages(arg0)
    CGPDFDocumentRef arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGPDFPageRef
CGPDFDocumentGetPage(arg0 ,arg1)
    CGPDFDocumentRef arg0;
    unsigned long long arg1;

#else
CGPDFPageRef
CGPDFDocumentGetPage(arg0 ,arg1)
    CGPDFDocumentRef arg0;
    unsigned long arg1;

#endif


#if !TARGET_OS_IPHONE
int
CGPDFDocumentGetRotationAngle(arg0 ,arg1)
    CGPDFDocumentRef arg0;
    int arg1;

#endif


#if !TARGET_OS_IPHONE
CGRect 
CGPDFDocumentGetTrimBox(arg0 ,arg1)
    CGPDFDocumentRef arg0;
    int arg1;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPDFDocumentGetTypeID()

#else
unsigned long
CGPDFDocumentGetTypeID()

#endif


void
CGPDFDocumentGetVersion(arg0 ,arg1 ,arg2)
    CGPDFDocumentRef arg0;
    int *  arg1;
    int *  arg2;



bool
CGPDFDocumentIsEncrypted(arg0)
    CGPDFDocumentRef arg0;



bool
CGPDFDocumentIsUnlocked(arg0)
    CGPDFDocumentRef arg0;



void
CGPDFDocumentRelease(arg0)
    CGPDFDocumentRef arg0;



CGPDFDocumentRef
CGPDFDocumentRetain(arg0)
    CGPDFDocumentRef arg0;



bool
CGPDFDocumentUnlockWithPassword(arg0 ,arg1)
    CGPDFDocumentRef arg0;
    char* arg1;



CGPDFOperatorTableRef
CGPDFOperatorTableCreate()



void
CGPDFOperatorTableRelease(arg0)
    CGPDFOperatorTableRef arg0;



CGPDFOperatorTableRef
CGPDFOperatorTableRetain(arg0)
    CGPDFOperatorTableRef arg0;



CGRect 
CGPDFPageGetBoxRect(arg0 ,arg1)
    CGPDFPageRef arg0;
    int arg1;



CGPDFDictionaryRef
CGPDFPageGetDictionary(arg0)
    CGPDFPageRef arg0;



CGPDFDocumentRef
CGPDFPageGetDocument(arg0)
    CGPDFPageRef arg0;



CGAffineTransform 
CGPDFPageGetDrawingTransform(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGPDFPageRef arg0;
    int arg1;
    CGRect  arg2;
    int arg3;
    bool arg4;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPDFPageGetPageNumber(arg0)
    CGPDFPageRef arg0;

#else
unsigned long
CGPDFPageGetPageNumber(arg0)
    CGPDFPageRef arg0;

#endif


int
CGPDFPageGetRotationAngle(arg0)
    CGPDFPageRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPDFPageGetTypeID()

#else
unsigned long
CGPDFPageGetTypeID()

#endif


void
CGPDFPageRelease(arg0)
    CGPDFPageRef arg0;



CGPDFPageRef
CGPDFPageRetain(arg0)
    CGPDFPageRef arg0;



CGPDFScannerRef
CGPDFScannerCreate(arg0 ,arg1 ,arg2)
    CGPDFContentStreamRef arg0;
    CGPDFOperatorTableRef arg1;
    void *  arg2;



CGPDFContentStreamRef
CGPDFScannerGetContentStream(arg0)
    CGPDFScannerRef arg0;



bool
CGPDFScannerPopBoolean(arg0 ,arg1)
    CGPDFScannerRef arg0;
    char* arg1;



bool
CGPDFScannerPopDictionary(arg0 ,arg1)
    CGPDFScannerRef arg0;
    CGPDFDictionaryRef * arg1;



#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFScannerPopInteger(arg0 ,arg1)
    CGPDFScannerRef arg0;
    long long *  arg1;

#else
bool
CGPDFScannerPopInteger(arg0 ,arg1)
    CGPDFScannerRef arg0;
    int *  arg1;

#endif


bool
CGPDFScannerPopName(arg0 ,arg1)
    CGPDFScannerRef arg0;
    char* *  arg1;



#if defined(__x86_64__) || defined(__arm64__)
bool
CGPDFScannerPopNumber(arg0 ,arg1)
    CGPDFScannerRef arg0;
    double *  arg1;

#else
bool
CGPDFScannerPopNumber(arg0 ,arg1)
    CGPDFScannerRef arg0;
    float *  arg1;

#endif


bool
CGPDFScannerPopStream(arg0 ,arg1)
    CGPDFScannerRef arg0;
    CGPDFStreamRef * arg1;



bool
CGPDFScannerPopString(arg0 ,arg1)
    CGPDFScannerRef arg0;
    CGPDFStringRef * arg1;



void
CGPDFScannerRelease(arg0)
    CGPDFScannerRef arg0;



CGPDFScannerRef
CGPDFScannerRetain(arg0)
    CGPDFScannerRef arg0;



bool
CGPDFScannerScan(arg0)
    CGPDFScannerRef arg0;



CFDataRef
CGPDFStreamCopyData(arg0 ,arg1)
    CGPDFStreamRef arg0;
    int *  arg1;



CGPDFDictionaryRef
CGPDFStreamGetDictionary(arg0)
    CGPDFStreamRef arg0;



CFDateRef
CGPDFStringCopyDate(arg0)
    CGPDFStringRef arg0;



CFStringRef
CGPDFStringCopyTextString(arg0)
    CGPDFStringRef arg0;



char*
CGPDFStringGetBytePtr(arg0)
    CGPDFStringRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPDFStringGetLength(arg0)
    CGPDFStringRef arg0;

#else
unsigned long
CGPDFStringGetLength(arg0)
    CGPDFStringRef arg0;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPSConverterGetTypeID()

#else
unsigned long
CGPSConverterGetTypeID()

#endif
#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGPathAddArc(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;
    double arg6;
    bool arg7;

#else
void
CGPathAddArc(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;
    float arg6;
    bool arg7;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGPathAddArcToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;
    double arg6;

#else
void
CGPathAddArcToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;
    float arg6;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGPathAddCurveToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;
    double arg6;
    double arg7;

#else
void
CGPathAddCurveToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;
    float arg6;
    float arg7;

#endif


void
CGPathAddEllipseInRect(arg0 ,arg1 ,arg2)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGRect  arg2;



#if defined(__x86_64__) || defined(__arm64__)
void
CGPathAddLineToPoint(arg0 ,arg1 ,arg2 ,arg3)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    double arg2;
    double arg3;

#else
void
CGPathAddLineToPoint(arg0 ,arg1 ,arg2 ,arg3)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    float arg2;
    float arg3;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGPathAddLines(arg0 ,arg1 ,arg2 ,arg3)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGPoint * arg2;
    unsigned long long arg3;

#else
void
CGPathAddLines(arg0 ,arg1 ,arg2 ,arg3)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGPoint * arg2;
    unsigned long arg3;

#endif


void
CGPathAddPath(arg0 ,arg1 ,arg2)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGPathRef arg2;



#if defined(__x86_64__) || defined(__arm64__)
void
CGPathAddQuadCurveToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;

#else
void
CGPathAddQuadCurveToPoint(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;

#endif


void
CGPathAddRect(arg0 ,arg1 ,arg2)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGRect  arg2;



#if defined(__x86_64__) || defined(__arm64__)
void
CGPathAddRects(arg0 ,arg1 ,arg2 ,arg3)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGRect * arg2;
    unsigned long long arg3;

#else
void
CGPathAddRects(arg0 ,arg1 ,arg2 ,arg3)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGRect * arg2;
    unsigned long arg3;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGPathAddRelativeArc(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;
    double arg6;

#else
void
CGPathAddRelativeArc(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;
    float arg6;

#endif


#if defined(__x86_64__) || defined(__arm64__)
void
CGPathAddRoundedRect(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGRect  arg2;
    double arg3;
    double arg4;

#else
void
CGPathAddRoundedRect(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGRect  arg2;
    float arg3;
    float arg4;

#endif


void
CGPathCloseSubpath(arg0)
    CGPathRef arg0;



bool
CGPathContainsPoint(arg0 ,arg1 ,arg2 ,arg3)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    CGPoint  arg2;
    bool arg3;



CGPathRef
CGPathCreateCopy(arg0)
    CGPathRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
CGPathRef
CGPathCreateCopyByDashingPath(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    double arg2;
    double *  arg3;
    unsigned long long arg4;

#else
CGPathRef
CGPathCreateCopyByDashingPath(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    float arg2;
    float *  arg3;
    unsigned long arg4;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGPathRef
CGPathCreateCopyByStrokingPath(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    double arg2;
    int arg3;
    int arg4;
    double arg5;

#else
CGPathRef
CGPathCreateCopyByStrokingPath(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    float arg2;
    int arg3;
    int arg4;
    float arg5;

#endif


CGPathRef
CGPathCreateCopyByTransformingPath(arg0 ,arg1)
    CGPathRef arg0;
    CGAffineTransform * arg1;



CGPathRef
CGPathCreateMutable()



CGPathRef
CGPathCreateMutableCopy(arg0)
    CGPathRef arg0;



CGPathRef
CGPathCreateMutableCopyByTransformingPath(arg0 ,arg1)
    CGPathRef arg0;
    CGAffineTransform * arg1;



CGPathRef
CGPathCreateWithEllipseInRect(arg0 ,arg1)
    CGRect  arg0;
    CGAffineTransform * arg1;



CGPathRef
CGPathCreateWithRect(arg0 ,arg1)
    CGRect  arg0;
    CGAffineTransform * arg1;



#if defined(__x86_64__) || defined(__arm64__)
CGPathRef
CGPathCreateWithRoundedRect(arg0 ,arg1 ,arg2 ,arg3)
    CGRect  arg0;
    double arg1;
    double arg2;
    CGAffineTransform * arg3;

#else
CGPathRef
CGPathCreateWithRoundedRect(arg0 ,arg1 ,arg2 ,arg3)
    CGRect  arg0;
    float arg1;
    float arg2;
    CGAffineTransform * arg3;

#endif


bool
CGPathEqualToPath(arg0 ,arg1)
    CGPathRef arg0;
    CGPathRef arg1;



CGRect 
CGPathGetBoundingBox(arg0)
    CGPathRef arg0;



CGPoint 
CGPathGetCurrentPoint(arg0)
    CGPathRef arg0;



CGRect 
CGPathGetPathBoundingBox(arg0)
    CGPathRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPathGetTypeID()

#else
unsigned long
CGPathGetTypeID()

#endif


bool
CGPathIsEmpty(arg0)
    CGPathRef arg0;



bool
CGPathIsRect(arg0 ,arg1)
    CGPathRef arg0;
    CGRect * arg1;



#if defined(__x86_64__) || defined(__arm64__)
void
CGPathMoveToPoint(arg0 ,arg1 ,arg2 ,arg3)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    double arg2;
    double arg3;

#else
void
CGPathMoveToPoint(arg0 ,arg1 ,arg2 ,arg3)
    CGPathRef arg0;
    CGAffineTransform * arg1;
    float arg2;
    float arg3;

#endif


void
CGPathRelease(arg0)
    CGPathRef arg0;



CGPathRef
CGPathRetain(arg0)
    CGPathRef arg0;



#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGPatternGetTypeID()

#else
unsigned long
CGPatternGetTypeID()

#endif


void
CGPatternRelease(arg0)
    CGPatternRef arg0;



CGPatternRef
CGPatternRetain(arg0)
    CGPatternRef arg0;



CGPoint 
CGPointApplyAffineTransform(arg0 ,arg1)
    CGPoint  arg0;
    CGAffineTransform  arg1;



CFDictionaryRef
CGPointCreateDictionaryRepresentation(arg0)
    CGPoint  arg0;



bool
CGPointEqualToPoint(arg0 ,arg1)
    CGPoint  arg0;
    CGPoint  arg1;



#if defined(__x86_64__) || defined(__arm64__)
CGPoint 
CGPointMake(arg0 ,arg1)
    double arg0;
    double arg1;

#else
CGPoint 
CGPointMake(arg0 ,arg1)
    float arg0;
    float arg1;

#endif


bool
CGPointMakeWithDictionaryRepresentation(arg0 ,arg1)
    CFDictionaryRef arg0;
    CGPoint * arg1;



#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
int
CGPostKeyboardEvent(arg0 ,arg1 ,arg2)
    unsigned short arg0;
    unsigned short arg1;
    unsigned int arg2;

#else
int
CGPostKeyboardEvent(arg0 ,arg1 ,arg2)
    unsigned short arg0;
    unsigned short arg1;
    int arg2;

#endif
#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
int
CGPostMouseEvent(arg0 ,arg1 ,arg2 ,arg3)
    CGPoint  arg0;
    unsigned int arg1;
    unsigned int arg2;
    unsigned int arg3;

#else
int
CGPostMouseEvent(arg0 ,arg1 ,arg2 ,arg3)
    CGPoint  arg0;
    int arg1;
    unsigned int arg2;
    int arg3;

#endif
#endif


#if !TARGET_OS_IPHONE
int
CGPostScrollWheelEvent(arg0 ,arg1)
    unsigned int arg0;
    int arg1;

#endif


CGRect 
CGRectApplyAffineTransform(arg0 ,arg1)
    CGRect  arg0;
    CGAffineTransform  arg1;



bool
CGRectContainsPoint(arg0 ,arg1)
    CGRect  arg0;
    CGPoint  arg1;



bool
CGRectContainsRect(arg0 ,arg1)
    CGRect  arg0;
    CGRect  arg1;



CFDictionaryRef
CGRectCreateDictionaryRepresentation(arg0)
    CGRect  arg0;



#if defined(__x86_64__) || defined(__arm64__)
void
CGRectDivide(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGRect  arg0;
    CGRect * arg1;
    CGRect * arg2;
    double arg3;
    unsigned int arg4;

#else
void
CGRectDivide(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    CGRect  arg0;
    CGRect * arg1;
    CGRect * arg2;
    float arg3;
    unsigned int arg4;

#endif


bool
CGRectEqualToRect(arg0 ,arg1)
    CGRect  arg0;
    CGRect  arg1;



#if defined(__x86_64__) || defined(__arm64__)
double
CGRectGetHeight(arg0)
    CGRect  arg0;

#else
float
CGRectGetHeight(arg0)
    CGRect  arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
double
CGRectGetMaxX(arg0)
    CGRect  arg0;

#else
float
CGRectGetMaxX(arg0)
    CGRect  arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
double
CGRectGetMaxY(arg0)
    CGRect  arg0;

#else
float
CGRectGetMaxY(arg0)
    CGRect  arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
double
CGRectGetMidX(arg0)
    CGRect  arg0;

#else
float
CGRectGetMidX(arg0)
    CGRect  arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
double
CGRectGetMidY(arg0)
    CGRect  arg0;

#else
float
CGRectGetMidY(arg0)
    CGRect  arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
double
CGRectGetMinX(arg0)
    CGRect  arg0;

#else
float
CGRectGetMinX(arg0)
    CGRect  arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
double
CGRectGetMinY(arg0)
    CGRect  arg0;

#else
float
CGRectGetMinY(arg0)
    CGRect  arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
double
CGRectGetWidth(arg0)
    CGRect  arg0;

#else
float
CGRectGetWidth(arg0)
    CGRect  arg0;

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGRect 
CGRectInset(arg0 ,arg1 ,arg2)
    CGRect  arg0;
    double arg1;
    double arg2;

#else
CGRect 
CGRectInset(arg0 ,arg1 ,arg2)
    CGRect  arg0;
    float arg1;
    float arg2;

#endif


CGRect 
CGRectIntegral(arg0)
    CGRect  arg0;



CGRect 
CGRectIntersection(arg0 ,arg1)
    CGRect  arg0;
    CGRect  arg1;



bool
CGRectIntersectsRect(arg0 ,arg1)
    CGRect  arg0;
    CGRect  arg1;



bool
CGRectIsEmpty(arg0)
    CGRect  arg0;



bool
CGRectIsInfinite(arg0)
    CGRect  arg0;



bool
CGRectIsNull(arg0)
    CGRect  arg0;



#if defined(__x86_64__) || defined(__arm64__)
CGRect 
CGRectMake(arg0 ,arg1 ,arg2 ,arg3)
    double arg0;
    double arg1;
    double arg2;
    double arg3;

#else
CGRect 
CGRectMake(arg0 ,arg1 ,arg2 ,arg3)
    float arg0;
    float arg1;
    float arg2;
    float arg3;

#endif


bool
CGRectMakeWithDictionaryRepresentation(arg0 ,arg1)
    CFDictionaryRef arg0;
    CGRect * arg1;



#if defined(__x86_64__) || defined(__arm64__)
CGRect 
CGRectOffset(arg0 ,arg1 ,arg2)
    CGRect  arg0;
    double arg1;
    double arg2;

#else
CGRect 
CGRectOffset(arg0 ,arg1 ,arg2)
    CGRect  arg0;
    float arg1;
    float arg2;

#endif


CGRect 
CGRectStandardize(arg0)
    CGRect  arg0;



CGRect 
CGRectUnion(arg0 ,arg1)
    CGRect  arg0;
    CGRect  arg1;



#if !TARGET_OS_IPHONE
int
CGReleaseAllDisplays()

#endif


#if !TARGET_OS_IPHONE
int
CGReleaseDisplayFadeReservation(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
void
CGReleaseScreenRefreshRects(arg0)
    CGRect * arg0;

#endif


#if !TARGET_OS_IPHONE
void
CGRestorePermanentDisplayConfiguration()

#endif


#if !TARGET_OS_IPHONE
CFDictionaryRef
CGSessionCopyCurrentDictionary()

#endif


#if !TARGET_OS_IPHONE
int
CGSetDisplayTransferByByteTable(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    unsigned int arg0;
    unsigned int arg1;
    char* arg2;
    char* arg3;
    char* arg4;

#endif


#if !TARGET_OS_IPHONE
int
CGSetDisplayTransferByFormula(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7 ,arg8 ,arg9)
    unsigned int arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;
    float arg6;
    float arg7;
    float arg8;
    float arg9;

#endif


#if !TARGET_OS_IPHONE
int
CGSetDisplayTransferByTable(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    unsigned int arg0;
    unsigned int arg1;
    float *  arg2;
    float *  arg3;
    float *  arg4;

#endif


#if !TARGET_OS_IPHONE
int
CGSetLocalEventsFilterDuringSuppressionState(arg0 ,arg1)
    unsigned int arg0;
    unsigned int arg1;

#endif


#if !TARGET_OS_IPHONE
int
CGSetLocalEventsSuppressionInterval(arg0)
    double arg0;

#endif


CGShadingRef
CGShadingCreateAxial(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    CGColorSpaceRef arg0;
    CGPoint  arg1;
    CGPoint  arg2;
    CGFunctionRef arg3;
    bool arg4;
    bool arg5;



#if defined(__x86_64__) || defined(__arm64__)
CGShadingRef
CGShadingCreateRadial(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    CGColorSpaceRef arg0;
    CGPoint  arg1;
    double arg2;
    CGPoint  arg3;
    double arg4;
    CGFunctionRef arg5;
    bool arg6;
    bool arg7;

#else
CGShadingRef
CGShadingCreateRadial(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5 ,arg6 ,arg7)
    CGColorSpaceRef arg0;
    CGPoint  arg1;
    float arg2;
    CGPoint  arg3;
    float arg4;
    CGFunctionRef arg5;
    bool arg6;
    bool arg7;

#endif


#if defined(__x86_64__) || defined(__arm64__)
unsigned long long
CGShadingGetTypeID()

#else
unsigned long
CGShadingGetTypeID()

#endif


void
CGShadingRelease(arg0)
    CGShadingRef arg0;



CGShadingRef
CGShadingRetain(arg0)
    CGShadingRef arg0;



#if !TARGET_OS_IPHONE
unsigned int
CGShieldingWindowID(arg0)
    unsigned int arg0;

#endif


#if !TARGET_OS_IPHONE
int
CGShieldingWindowLevel()

#endif


CGSize 
CGSizeApplyAffineTransform(arg0 ,arg1)
    CGSize  arg0;
    CGAffineTransform  arg1;



CFDictionaryRef
CGSizeCreateDictionaryRepresentation(arg0)
    CGSize  arg0;



bool
CGSizeEqualToSize(arg0 ,arg1)
    CGSize  arg0;
    CGSize  arg1;



#if defined(__x86_64__) || defined(__arm64__)
CGSize 
CGSizeMake(arg0 ,arg1)
    double arg0;
    double arg1;

#else
CGSize 
CGSizeMake(arg0 ,arg1)
    float arg0;
    float arg1;

#endif


bool
CGSizeMakeWithDictionaryRepresentation(arg0 ,arg1)
    CFDictionaryRef arg0;
    CGSize * arg1;



#if defined(__x86_64__) || defined(__arm64__)
CGVector 
CGVectorMake(arg0 ,arg1)
    double arg0;
    double arg1;

#else
CGVector 
CGVectorMake(arg0 ,arg1)
    float arg0;
    float arg1;

#endif


#if !TARGET_OS_IPHONE
int
CGWaitForScreenRefreshRects(arg0 ,arg1)
    CGRect ** arg0;
    unsigned int *  arg1;

#endif


#if !TARGET_OS_IPHONE
#if defined(__x86_64__) || defined(__arm64__)
int
CGWaitForScreenUpdateRects(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    unsigned int arg0;
    unsigned int *  arg1;
    CGRect ** arg2;
    unsigned long long *  arg3;
    CGScreenUpdateMoveDelta * arg4;

#else
int
CGWaitForScreenUpdateRects(arg0 ,arg1 ,arg2 ,arg3 ,arg4)
    unsigned int arg0;
    unsigned int *  arg1;
    CGRect ** arg2;
    unsigned int *  arg3;
    CGScreenUpdateMoveDelta * arg4;

#endif
#endif


#if !TARGET_OS_IPHONE
int
CGWarpMouseCursorPosition(arg0)
    CGPoint  arg0;

#endif


#if !TARGET_OS_IPHONE
int
CGWindowLevelForKey(arg0)
    int arg0;

#endif


#if !TARGET_OS_IPHONE
CFArrayRef
CGWindowListCopyWindowInfo(arg0 ,arg1)
    unsigned int arg0;
    unsigned int arg1;

#endif


#if !TARGET_OS_IPHONE
CFArrayRef
CGWindowListCreate(arg0 ,arg1)
    unsigned int arg0;
    unsigned int arg1;

#endif


#if !TARGET_OS_IPHONE
CFArrayRef
CGWindowListCreateDescriptionFromArray(arg0)
    CFArrayRef arg0;

#endif


#if !TARGET_OS_IPHONE
CGImageRef
CGWindowListCreateImage(arg0 ,arg1 ,arg2 ,arg3)
    CGRect  arg0;
    unsigned int arg1;
    unsigned int arg2;
    unsigned int arg3;

#endif


#if !TARGET_OS_IPHONE
CGImageRef
CGWindowListCreateImageFromArray(arg0 ,arg1 ,arg2)
    CGRect  arg0;
    CFArrayRef arg1;
    unsigned int arg2;

#endif


#if !TARGET_OS_IPHONE
CFMachPortRef
CGWindowServerCFMachPort()

#endif


#if !TARGET_OS_IPHONE
CFMachPortRef
CGWindowServerCreateServerPort()

#endif


#if defined(__x86_64__) || defined(__arm64__)
CGAffineTransform 
__CGAffineTransformMake(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;

#else
CGAffineTransform 
__CGAffineTransformMake(arg0 ,arg1 ,arg2 ,arg3 ,arg4 ,arg5)
    float arg0;
    float arg1;
    float arg2;
    float arg3;
    float arg4;
    float arg5;

#endif


CGPoint 
__CGPointApplyAffineTransform(arg0 ,arg1)
    CGPoint  arg0;
    CGAffineTransform  arg1;



bool
__CGPointEqualToPoint(arg0 ,arg1)
    CGPoint  arg0;
    CGPoint  arg1;



CGSize 
__CGSizeApplyAffineTransform(arg0 ,arg1)
    CGSize  arg0;
    CGAffineTransform  arg1;



bool
__CGSizeEqualToSize(arg0 ,arg1)
    CGSize  arg0;
    CGSize  arg1;


