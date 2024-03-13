//
//  SDKController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "SDKController.h"
#import "NetworkController.h"
#import "PayController.h"
#import "GoogleAdWarper.h"
static SDKController* instance;


@interface SDKController ()


@end

@implementation SDKController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self innerInit];
    }
    return self;
}

+ (SDKController *)getInstance{
    if(instance == nil){
        instance = [[SDKController alloc] init];
    }
    return instance;
}

- (void)innerInit{
   
}

- (void)sdkInit{
    [NetworkController networkServiceInit];
    [PayController getInstance];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)openCenterView{
    [ViewHub openCenterView];
}

- (void)openWebView:(NSString *)urlString{
    [ViewHub openWebView:urlString];
}

- (void)AdInitAfterControllerDidInit:(UIViewController *)vController adID:(NSString *)adId{
    [GoogleAdWarper.sharedInstance googleAdInitAfterControllerDidInit:vController adID:adId];
    [SDKModel getInstance].rootController = vController;
}

- (void)showRewardedAd{
    [GoogleAdWarper.sharedInstance showRewardedAd];
}

- (void)openTestView{
    LXBTestView *view = [[LXBTestView alloc] init];
    [[view getRootWindow] addSubview:view];
}

@end
