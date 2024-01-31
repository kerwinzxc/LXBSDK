//
//  UserCenterController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "UserCenterController.h"




@implementation UserCenterController
+ (void)POST:(NSString *)URL
  parameters:(NSDictionary *)parameters
     success:(MSHttpSuccess)success
     failure:(MSHttpFail)failure{

    [NetworkController POST:UserCenterModuleName url:URL parameters:parameters success:success failure:failure];
}

/*
游客登陆
 */
+ (void)visitorReq:(VisitorReqModel *)model success:(MSHttpSuccess)success
           failure:(MSHttpFail)failure{
    
    
    NSDictionary *dic = @{
        ReqKeydevice_id:model.device_id,
        ReqKeyuuid:model.uuid,
        ReqKeychannel_id:@(model.channel_id),
    
    };
    [self POST:visitor parameters:dic success:success failure:failure];
}
@end
