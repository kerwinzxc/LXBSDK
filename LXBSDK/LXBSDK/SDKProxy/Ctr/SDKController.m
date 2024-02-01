//
//  SDKController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "SDKController.h"
#import "NetworkController.h"
#import "UserCenterController.h"
#import "PayController.h"
#import "PostArgUtils.h"
#import "AFNet.h"
@implementation SDKController

+ (void)sdkInit{
    [NetworkController networkServiceInit];
    
}

+ (void)login{
    
    ReqVisitor *req = [[ReqVisitor alloc] init];
    req.device_id = @"123456";
    req.uuid = @"123465";
    NSInteger cId = [U8_CHANNEL intValue];//;
    req.channel_id = cId;
    [UserCenterController visitorReq:req success:^(id  _Nonnull responseObject) {
        [DataHub getInstance].useModel = responseObject;
        
        
    } failure:^(NSError * _Nonnull error) {
        
    }];

}

+ (void)createOrder{
    ReqPayCreate *req = [[ReqPayCreate alloc] init];
    req.account_id = [DataHub getInstance].useModel.account_id;
    req.amount = 100;
    req.currency = @"CNY";
    req.cash_fee = 100;
    req.cash_currency = @"CNY";
    req.body = @"body";
    req.detail = @"detaildetaildetaildetail";
    req.platform = @"apple";
    req.trade_type = @"APP";
    req.game_id = [U8_GAME_ID longLongValue];
    req.server_id = 123;
    req.notify_url = @"";
    req.extension = @"ext";
    req.device_id = @"";
    req.product_id = @"xxxx";
    
    
    NSLog(@"%@",req.mj_keyValues);
    [PayController ceratePayOrder:req success:^(id  _Nonnull responseObject) {
            NSLog(@"");
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"");
        }];
}


+ (void)test{
    ReqVisitor *req = [[ReqVisitor alloc] init];
    req.device_id = @"123456";
    req.uuid = @"123465";
    NSInteger cId = [U8_CHANNEL intValue];
    NSDictionary *dic = req.mj_keyValues;
    
    
}

@end
