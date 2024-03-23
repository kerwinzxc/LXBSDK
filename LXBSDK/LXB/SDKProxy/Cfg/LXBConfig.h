//
//  LXBConfig.h
//  LXBSDK
//
//  Created by pub on 2024/2/19.
//

#import <Foundation/Foundation.h>


static NSString * _Nullable const SDKInitSuccNotiName = @"SDKInitSuccNotiName";
static NSString * _Nullable const SDKInitFailNotiName = @"SDKInitFailNotiName";

static NSString * _Nullable const AppleLoginNotiName = @"AppleLoginNotiName";
static NSString * _Nullable const GoogleLoginNotiName = @"GoogleLoginNotiName";
static NSString * _Nullable const FacebookLoginNotiName = @"FacebookLoginNotiName";
static NSString * _Nullable const LoginSuccNotiName = @"LoginSuccNotiName";
static NSString * _Nullable const LoginFailNotiName = @"LoginFailNotiName";
static NSString * _Nullable const LogoutNotiName = @"LogoutNotiName";

static NSString * _Nullable const PayFailNotiName = @"PayFailNotiName";
static NSString * _Nullable const PaySuccNotiName = @"PaySuccNotiName";

static NSString * _Nullable const BindAccountNotiName = @"BindAccountNotiName";

static NSString * _Nullable const CloseAllViewNotiName = @"CloseAllViewNotiName";

static NSString * _Nullable const AdRewardedNotiName = @"AdRewardedNotiName";
static NSString * _Nullable const AdPluginInitErrorNotiName = @"AdPluginInitErrorNotiName";
static NSString * _Nullable const AdLoadErrorNotiName = @"AdLoadErrorNotiName";



static NSString * _Nullable const AgreementUrl = @"http://www.lxbgames.com/user";
static NSString * _Nullable const PolicyUrl = @"https://sites.google.com/view/caifutec-policy-terms";





NS_ASSUME_NONNULL_BEGIN

@interface LXBConfig : NSObject

@property(nonatomic, strong)NSArray *bindViewCfg;
@property(nonatomic, strong)NSArray *menuViewCfg;
@property(nonatomic, strong)NSArray *changeAccViewCfg;

@property(nonatomic, strong)NSArray *changeAccWarperCfg;
+ (LXBConfig *)getInstance;
@end

NS_ASSUME_NONNULL_END
