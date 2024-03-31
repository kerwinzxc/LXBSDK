//
//  GoogleAdWarper.h
//  RewardedVideoExample
//
//  Created by pub on 2024/3/12.
//  Copyright © 2024 Google. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoogleMobileAdsConsentManager.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
NS_ASSUME_NONNULL_BEGIN



@interface GoogleAdWarper : NSObject

@property(class, atomic, readonly, strong, nonnull) GoogleAdWarper *sharedInstance;

- (void)googleAdInitAfterControllerDidInit:(UIViewController *)vController adID:(NSString *)adId;
- (void)showRewardedAd;
@end

NS_ASSUME_NONNULL_END
