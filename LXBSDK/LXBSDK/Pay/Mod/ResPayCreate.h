//
//  PayCreateRes.h
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResPayCreate : NSObject
@property(nonatomic, strong)NSString *appid;
@property(nonatomic, strong)NSString *partnerId;
@property(nonatomic, strong)NSString *nonceStr;
@property(nonatomic, strong)NSString *prepayId;
@property(nonatomic, strong)NSString *package;
@property(nonatomic, strong)NSString *timestamp;
@property(nonatomic, strong)NSString *orderId;
@property(nonatomic, strong)NSString *url;
@property(nonatomic, strong)NSString *platform;
@property(nonatomic, strong)NSString *product_id;

@end

NS_ASSUME_NONNULL_END
