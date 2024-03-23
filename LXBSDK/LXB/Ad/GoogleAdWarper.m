//
//  GoogleAdWarper.m
//  RewardedVideoExample
//
//  Created by pub on 2024/3/12.
//  Copyright © 2024 Google. All rights reserved.
//

#import "GoogleAdWarper.h"
#import "LXBADInfo.h"
typedef NS_ENUM(NSInteger, GoogleAdLoadState){
    GoogleAdNone,
    GoogleLoading,
    GoogleLoaded,
};


@interface GoogleAdWarper()<GADFullScreenContentDelegate>
@property(nonatomic, strong)GADRewardedAd *rewardedAd;
@property(nonatomic, assign)GoogleAdLoadState googleAdLoadState;
@property(nonatomic, strong)UIViewController *viewController;
@property(nonatomic, strong)NSString *googleAdId;
@property(nonatomic, assign)BOOL awarded;
@property(nonatomic, strong)LXBADInfo *adInfo;
@end



@implementation GoogleAdWarper

+ (instancetype)sharedInstance{
    static GoogleAdWarper *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[GoogleAdWarper alloc] init];
        shared.googleAdLoadState = GoogleAdNone;
    });
    
    return shared;
}

- (void)googleAdInitAfterControllerDidInit:(UIViewController *)vController adID:(NSString *)adId{
    if(vController == nil){
        NSLog(@"vController == nil");
        return;
    }
    
    if(adId == nil || [adId isEqual:@""]){
        NSLog(@"ad id id null");
        return;
    }
    
    self.googleAdId = adId;
    self.viewController = vController;
    
    __weak __typeof__(self) weakSelf = self;
    [GoogleMobileAdsConsentManager.sharedInstance
        gatherConsentFromConsentPresentationViewController:self.viewController
                                  consentGatheringComplete:^(NSError *_Nullable consentError) {
                                    __strong __typeof__(self) strongSelf = weakSelf;
                                    if (!strongSelf) {
                                        return;
                                    }
                                    if (consentError) {
                                        // Consent gathering failed.
                                        NSLog(@"Error: %@", consentError.localizedDescription);
                                    }

                                    if (GoogleMobileAdsConsentManager.sharedInstance.canRequestAds) {
                                        [strongSelf startGoogleMobileAdsSDK];
                                    }
                                  }];
    
    // This sample attempts to load ads using consent obtained in the previous session.
    if (GoogleMobileAdsConsentManager.sharedInstance.canRequestAds) {
        [self startGoogleMobileAdsSDK];
    }
}

- (void)startGoogleMobileAdsSDK {
    NSLog(@"google ad init");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Initialize the Google Mobile Ads SDK.
        [GADMobileAds.sharedInstance startWithCompletionHandler:nil];
        // Request an ad.
        [self loadRewardedAd];
    });
}

- (void)loadRewardedAd {
    if (GoogleMobileAdsConsentManager.sharedInstance.canRequestAds == NO) {
        //todo
        return;
    }
    
    if(self.googleAdLoadState == GoogleAdNone){
        GADRequest *request = [GADRequest request];
        NSString *gid = self.googleAdId;
        
        __weak __typeof(self)weakSelf = self;
        self.googleAdLoadState = GoogleLoading;
        [GADRewardedAd loadWithAdUnitID:gid
                                request:request
                      completionHandler:^(GADRewardedAd *ad, NSError *error) {
                                            if (error) {
                                                NSLog(@"Rewarded ad failed to load with error: %@", [error localizedDescription]);
                                                    //todo
                                                weakSelf.googleAdLoadState = GoogleAdNone;
                                                return;
                                            }
                                            weakSelf.googleAdLoadState = GoogleLoaded;
                                            weakSelf.rewardedAd = ad;
                                            NSLog(@"Rewarded ad loaded.");
                                            weakSelf.rewardedAd.fullScreenContentDelegate = weakSelf;
                                            weakSelf.rewardedAd.paidEventHandler = ^(GADAdValue * _Nonnull value) {
                                                weakSelf.adInfo.amount = value.value;
                                            };
          }];
    }
}

- (void)showRewardedAd{
    if(self.googleAdLoadState == GoogleAdNone){
        [self loadRewardedAd];
        DDLog(@"no ad need load");
        return;
    }

    
    if(self.googleAdLoadState == GoogleLoading){
        DDLog(@"ad is loading");
        return;
    }
    
    if(self.rewardedAd == nil){
        self.adInfo.errerInfo = @"rewardedAd is nil";
        [self postShowAdNotification];
        return;
    }
    
    if([self.rewardedAd canPresentFromRootViewController:self.viewController error:nil] == false){
        self.adInfo.errerInfo = @"controller no support";
        [self postShowAdNotification];
        return;
    }
    
    self.awarded = NO;
    self.adInfo = [LXBADInfo new];
    self.adInfo.adID = self.googleAdId;
        [self.rewardedAd presentFromRootViewController:self.viewController userDidEarnRewardHandler:^{
                            GADAdReward *reward = self.rewardedAd.adReward;
                            GADAdNetworkResponseInfo *info =  self.rewardedAd.responseInfo.loadedAdNetworkResponseInfo;
                            NSLog(@"name %@",info.adNetworkClassName);
                            self.adInfo.reward = YES;
                            self.adInfo.adType = info.adNetworkClassName;
        }];
    
    self.googleAdLoadState = GoogleAdNone;
    
    
}
    
#pragma rewardedAd delegate
/// Tells the delegate that an impression has been recorded for the ad.
- (void)adDidRecordImpression:(nonnull id<GADFullScreenPresentingAd>)ad{

}
    
/// Tells the delegate that a click has been recorded for the ad.
- (void)adDidRecordClick:(nonnull id<GADFullScreenPresentingAd>)ad{
    
}
    
/// Tells the delegate that the ad failed to present full screen content.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
    didFailToPresentFullScreenContentWithError:(nonnull NSError *)error{
    [self loadRewardedAd];
    self.adInfo.reward = false;
    self.adInfo.errerInfo = [error localizedDescription];
    [self postShowAdNotification];
}

/// Tells the delegate that the ad will present full screen content.
- (void)adWillPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad{

}

/// Tells the delegate that the ad will dismiss full screen content.
- (void)adWillDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad{

}
    
/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad{
    [self loadRewardedAd];
    [self postShowAdNotification];
}

- (void)postShowAdNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:AdRewardedNotiName object:self.adInfo];
}

- (void)postLoadAdNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:AdLoadErrorNotiName object:self.adInfo];
}

- (void)postInitAdNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:AdPluginInitErrorNotiName object:self.adInfo];
}

@end
