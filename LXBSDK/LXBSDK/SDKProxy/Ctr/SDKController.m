//
//  SDKController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "SDKController.h"
#import "NetworkController.h"
#import "UserCenterController.h"
#import "PostArgUtils.h"
#import "AFNet.h"
@implementation SDKController

+ (void)sdkInit{
    [NetworkController networkServiceInit];
}

+ (void)login{
    
    VisitorReqModel *req = [[VisitorReqModel alloc] init];
    req.device_id = @"123456";
    req.uuid = @"123465";
    NSInteger cId = 1111111235;//[U8_CHANNEL intValue];
    req.channel_id = cId;
    [UserCenterController visitorReq:req success:^(id  _Nonnull responseObject) {
        NSLog(@"xxxxx");
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"xxxxx");
    }];

    //[AFNet Test];
    //NSLog(@"%@",[PostArgUtils hmacSHA256WithDict:dic]) ;
}

@end
