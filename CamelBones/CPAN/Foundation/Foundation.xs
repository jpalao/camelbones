#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import <CamelBones/PerlImports.h>
#import <CamelBones/Conversions_real.h>
#import <CamelBones/Structs_real.h>

MODULE = CamelBones::Foundation		PACKAGE = CamelBones::Foundation

PROTOTYPES: ENABLE

void
NSLog(logString)
    id logString;
    CODE:
        NSLog(@"%@", logString);

Class
NSClassFromString(aString)
	id aString;


# HFS Utils
#ifndef GNUSTEP
id
NSFileTypeForHFSTypeCode (typeCode)
    OSType typeCode;

OSType
NSHFSTypeCodeFromFileType (fileType)
    id fileType;

id
NSHFSTypeOfFile (filePath)
    id filePath;

#endif

# Path Utils
id
NSFullUserName ()

id
NSHomeDirectory ()

id
NSHomeDirectoryForUser (userName)
    id userName;
    
id
NSOpenStepRootDirectory ()

id
NSSearchPathForDirectoriesInDomains (directory, domainMask, expandTilde)
    NSUInteger directory;
    NSUInteger domainMask;
    BOOL expandTilde;

id
NSTemporaryDirectory ()

id
NSUserName ()

# Point utils
BOOL
NSEqualPoints (point1, point2)
    NSPoint point1;
    NSPoint point2;

NSPoint
NSMakePoint (x,y)
    CGFloat x;
    CGFloat y;

NSPoint
NSPointFromString (aString)
    id aString;

id
NSStringFromPoint (aPoint)
    NSPoint aPoint;

# Range utils
BOOL
NSEqualRanges (range1, range2)
    NSRange range1;
    NSRange range2;

NSRange
NSIntersectionRange (range1, range2)
    NSRange range1;
    NSRange range2;

BOOL
NSLocationInRange (index, aRange)
    NSUInteger index;
    NSRange aRange;

NSRange
NSMakeRange (location, length)
    NSUInteger location;
    NSUInteger length;

NSUInteger
NSMaxRange (aRange)
    NSRange aRange;

NSRange
NSRangeFromString (aString)
    id aString;

id
NSStringFromRange (aRange)
    NSRange aRange;

NSRange
NSUnionRange (range1,range2)
    NSRange range1;
    NSRange range2;

# Rect utils
BOOL
NSContainsRect (rect1, rect2)
    NSRect rect1;
    NSRect rect2;
    
BOOL
NSEqualRects (rect1, rect2)
    NSRect rect1;
    NSRect rect2;

BOOL
NSIsEmptyRect (aRect)
    NSRect aRect;

CGFloat NSHeight (aRect)
    NSRect aRect;
    
NSRect
NSInsetRect (aRect, dX, dY)
    NSRect aRect;
    CGFloat dX;
    CGFloat dY;

NSRect
NSIntegralRect (aRect)
    NSRect aRect;

NSRect
NSIntersectionRect (rect1, rect2)
    NSRect rect1;
    NSRect rect2;

BOOL
NSIntersectsRect (rect1, rect2)
    NSRect rect1;
    NSRect rect2;

NSRect
NSMakeRect (x,y,width,height)
    CGFloat x;
    CGFloat y;
    CGFloat width;
    CGFloat height;

CGFloat
NSMaxX (aRect)
    NSRect aRect;

CGFloat
NSMaxY (aRect)
    NSRect aRect;

CGFloat
NSMidX (aRect)
    NSRect aRect;
    
CGFloat
NSMidY (aRect)
    NSRect aRect;

CGFloat
NSMinX (aRect)
    NSRect aRect;

CGFloat
NSMinY (aRect)
    NSRect aRect;

BOOL
NSMouseInRect (aPoint, aRect, isFlipped)
    NSPoint aPoint;
    NSRect aRect;
    BOOL isFlipped;

NSRect
NSOffsetRect (aRect, dx, dy)
    NSRect aRect;
    CGFloat dx;
    CGFloat dy;

BOOL
NSPointInRect (aPoint, aRect)
    NSPoint aPoint;
    NSRect aRect;

NSRect
NSRectFromString (aString)
    id aString;
    
id
NSStringFromRect (aRect)
    NSRect aRect;

NSRect
NSUnionRect (rect1, rect2)
    NSRect rect1;
    NSRect rect2;

CGFloat
NSWidth (aRect)
    NSRect aRect;

# NSSize functions
BOOL
NSEqualSizes (size1, size2)
    NSSize size1;
    NSSize size2;

NSSize
NSMakeSize (width, height)
    CGFloat width;
    CGFloat height;
    
NSSize
NSSizeFromString (aString)
    id aString;

id
NSStringFromSize (aSize)
    NSSize aSize;

# Zone functions, but only some of them
NSUInteger
NSLogPageSize ()

NSUInteger
NSPageSize ()

NSUInteger
NSRealMemoryAvailable ()

NSUInteger
NSRoundDownToMultipleOfPageSize (pSize)
    NSInteger pSize;

NSUInteger
NSRoundUpToMultipleOfPageSize (pSize)
    NSInteger pSize;
