//
//  PayController.h
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import <Foundation/Foundation.h>
#import "ReqPayCreate.h"
#import "ResPayCreate.h"
#import <StoreKit/StoreKit.h>
#import "PayConfig.h"
#import "ReqPayValidate.h"
#import "ResPayValidate.h"
NS_ASSUME_NONNULL_BEGIN
@interface PayController : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver>

+ (PayController *)getInstance;
@property(nonatomic, assign)LXBPayStatus payStatus;

- (void)QueryInfo:(NSString *)proId;
- (BOOL)finishLostOrder;
- (void)appleBuyWithProId:(NSString *)proId;
- (void)handleCreateOrder:(ResPayCreate *)res;



+ (void)ceratePayOrder:(ReqPayCreate *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure;

+ (void)validateOrder:(ReqPayValidate *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure;

@end

NS_ASSUME_NONNULL_END
