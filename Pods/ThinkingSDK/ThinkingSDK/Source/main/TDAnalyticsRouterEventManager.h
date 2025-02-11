//
//  TDAnalyticsRouterEventManager.h
//  ThinkingSDK.default-TDCore-iOS
//
//  Created by 杨雄 on 2023/7/3.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface TDAnalyticsRouterEventManager : NSObject

+ (NSDictionary *)sdkInitEvent;

+ (NSDictionary *)sdkLoginEvent;

+ (NSDictionary *)sdkSetDistinctIdEvent;

+ (NSDictionary *)deviceActivationEvent;

@end

NS_ASSUME_NONNULL_END
