//
//  PayCreateReq.h
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReqPayCreate : NSObject
@property(nonatomic, assign)long account_id;
@property(nonatomic, assign)int amount;
@property(nonatomic, strong)NSString *currency;
@property(nonatomic, assign)int cash_fee;
@property(nonatomic, strong)NSString *cash_currency;
@property(nonatomic, strong)NSString *body;
@property(nonatomic, strong)NSString *detail;
@property(nonatomic, strong)NSString *platform;
@property(nonatomic, strong)NSString *trade_type;
@property(nonatomic, assign)long game_id;
@property(nonatomic, assign)long server_id;
@property(nonatomic, strong)NSString *notify_url;
@property(nonatomic, strong)NSString *extension;
@property(nonatomic, strong)NSString *device_id;
@property(nonatomic, strong)NSString *product_id;
@end

NS_ASSUME_NONNULL_END
