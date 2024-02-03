//
//  PayController.m
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import "PayController.h"
#import "PayConfig.h"

static PayController* instance;

@implementation PayController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self myInit];
    }
    return self;
}

- (void)myInit{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

+ (PayController *)getInstance{
    if(instance == nil){
        instance = [[PayController alloc] init];
    }
    
    return instance;
}

- (void)QueryInfo:(NSString *)proId{
    // 请求商品信息
    NSSet *productIdentifiers = [NSSet setWithObject:proId];
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    // 处理从 App Store 获取的商品信息
    NSArray *products = response.products;
    if (products.count > 0) {
        SKProduct *product = products[0];
        [self buyProduct:product];
    }
    NSLog(@"----productsRequest");
}

#pragma mark - Purchase Methods

- (void)buyProduct:(SKProduct *)product {
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}


#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    NSLog(@"----uuuuuuuuuuuu");
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                // 购买成功，处理交易并向用户提供购买的内容
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                // 购买失败，处理错误信息
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                // 恢复购买，处理交易并向用户提供购买的内容
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    // 在这里处理购买成功的逻辑，例如向用户提供购买的商品或服务
    // 完成交易后，务必调用finishTransaction方法
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    NSLog(@"----completeTransaction");
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    NSString *receiptString = [receiptData base64EncodedStringWithOptions:0];
    NSLog(@"Purchase Receipt: %@", receiptString);
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if (transaction.error.code != SKErrorPaymentCancelled) {
        // 非用户取消的错误，处理失败的逻辑
    }
    // 完成交易后，务必调用finishTransaction方法
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    NSLog(@"----failedTransaction");
}


- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 在这里处理恢复购买成功的逻辑，例如向用户提供购买的商品或服务
    // 完成交易后，务必调用finishTransaction方法
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    NSLog(@"----restoreTransaction");
}



+ (void)ceratePayOrder:(ReqPayCreate *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [NetworkController POST:PayModuleName classMeta:[ResPayCreate class] url:payCreate parameters:[model mj_keyValues] success:success failure:failure];
}

#pragma mark - 订单处理
- (void)queryLostOrder{
    NSLog(@"transation count %lu",[SKPaymentQueue defaultQueue].transactions.count);
}
@end
