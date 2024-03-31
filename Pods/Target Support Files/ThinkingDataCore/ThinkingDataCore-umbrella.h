#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSData+TDGzip.h"
#import "TAAnnotation.h"
#import "TAContext.h"
#import "TAModuleManager.h"
#import "TAModuleProtocol.h"
#import "TARouter.h"
#import "TAServiceManager.h"
#import "TAServiceProtocol.h"
#import "TDCoreInfo.h"
#import "TDJSONUtil.h"
#import "NSObject+TDSwizzle.h"
#import "TDSwizzler.h"
#import "TDClassHelper.h"
#import "TDMethodHelper.h"
#import "TDNewSwizzle.h"
#import "ThinkingDataCore.h"

FOUNDATION_EXPORT double ThinkingDataCoreVersionNumber;
FOUNDATION_EXPORT const unsigned char ThinkingDataCoreVersionString[];

