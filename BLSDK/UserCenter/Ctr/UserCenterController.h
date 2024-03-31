//
//  UserCenterController.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>
#import "NetworkController.h"
#import "UserCenterConfig.h"
#import "ReqVisitor.h"
#import "ReqAutoLogin.h"
#import "ReqOverseaBind.h"
#import "ReqThirdPartyLogin.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *const ReqKeydevice_id = @"device_id";
static NSString *const ReqKeyuuid = @"uuid";
static NSString *const ReqKeychannel_id = @"channel_id";
static NSString *const ReqKeydevice_extend = @"device_extend";

static NSString *const UserCenterModuleName = @"usercenter";
static NSString *const visitorUrl = @"visitor";

static NSString *const autoLoginUrl = @"auto/login";
static NSString *const overseaBind =@"oversea/bind";
static NSString *const thirdPartyLogin = @"login";
@interface UserCenterController : NSObject
+ (void)visitorReq:(ReqVisitor *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure;

+ (void)autoLoginReq:(ReqAutoLogin *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure;

+ (void)overseaBind:(ReqOverseaBind *)model sucess:(MSHttpSuccess)success failure:(MSHttpFail)failure;

+ (void)thirdPartyLogin:(ReqThirdPartyLogin *)model sucess:(MSHttpSuccess)success failure:(MSHttpFail)failure;
@end

NS_ASSUME_NONNULL_END
