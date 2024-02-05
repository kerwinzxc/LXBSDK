//
//  ReqPayValidate.h
//  LXBSDK
//
//  Created by pub on 2024/2/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReqPayValidate : NSObject
@property(nonatomic, strong)NSString *receipt;
@property(nonatomic, strong)NSString *order_id;
@property(nonatomic, assign)long account_id;
@property(nonatomic, strong)NSString *transaction_id;
@end

NS_ASSUME_NONNULL_END
