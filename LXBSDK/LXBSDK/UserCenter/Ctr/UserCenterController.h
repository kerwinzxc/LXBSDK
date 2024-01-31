//
//  UserCenterController.h
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import <Foundation/Foundation.h>
#import "NetworkController.h"
#import "UserCenterConfig.h"
#import "VisitorReqModel.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *const ReqKeydevice_id = @"device_id";
static NSString *const ReqKeyuuid = @"uuid";
static NSString *const ReqKeychannel_id = @"channel_id";
static NSString *const ReqKeydevice_extend = @"device_extend";

@interface UserCenterController : NSObject
//+ (void)POST:(NSString *)URL parameters:(NSDictionary *)parameters success:(MSHttpSuccess)success failure:(MSHttpFail)failure;

+ (void)visitorReq:(VisitorReqModel *)model success:(MSHttpSuccess)success
           failure:(MSHttpFail)failure;
@end

NS_ASSUME_NONNULL_END
