//
//  PayController.m
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import "PayController.h"

static PayController* instance;

@implementation PayController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self innerInit];
    }
    return self;
}

- (void)innerInit{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerLogin:) name:LoginSuccNotiName object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerPayFail:) name:PayFailNotiName object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerPaySucc:) name:PaySuccNotiName object:nil];
}

- (void)handlerLogin:(NSNotification *)noti{
    ResVisitor *user =(ResVisitor *)noti.object;
    DDLog(@"[[[[[%@",user.device_id);
    [self finishLostOrder];
}

- (void)handlerPayFail:(NSNotification *)noti{
    [LXBHelper hideLoading];
}

- (void)handlerPaySucc:(NSNotification *)noti{
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (PayController *)getInstance{
    if(instance == nil){
        instance = [[PayController alloc] init];
    }
    
    return instance;
}



#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    // 处理从 App Store 获取的商品信息
    NSArray *products = response.products;
    if (products.count > 0) {
        
    }
}

#pragma mark - Purchase Methods

- (void)appleBuyWithProId:(NSString *)proId{
    SKMutablePayment *payment = [[SKMutablePayment alloc] init];
    payment.applicationUsername = @"xxxxx";
    payment.productIdentifier = proId;
    payment.quantity = 1;
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
    self.payStatus = LXBUpApplePay;
}


#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        [self dealTransactionWithStatus:transaction];
    }
}

-(void)dealTransactionWithStatus:(SKPaymentTransaction *)transaction{
    switch (transaction.transactionState) {
        case SKPaymentTransactionStatePurchasing:
            DDLog(@"正在创建");
            self.payStatus = LXBAppleCreateOrder;
            break;
        case SKPaymentTransactionStatePurchased:
            // 购买成功，处理交易并向用户提供购买的内容
            [self completeTransaction:transaction];
            break;
        case SKPaymentTransactionStateFailed:
            // 购买失败，处理错误信息
            [self failedTransaction:transaction];
            self.payStatus = LXBPayNone;
            break;
        case SKPaymentTransactionStateRestored:
            // 恢复购买，处理交易并向用户提供购买的内容
            [self restoreTransaction:transaction];
            break;
        default:
            break;
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    // 在这里处理购买成功的逻辑，例如向用户提供购买的商品或服务
    // 完成交易后，务必调用finishTransaction方法
    NSString *lxbOrderId = [KeychainController loadOrderIdByProid:transaction.payment.productIdentifier];
    DDLog(@"服务器的orderid %@",lxbOrderId);
    DDLog(@"proid %@",transaction.payment.productIdentifier);
    
    DDLog(@"---%lu" ,[SKPaymentQueue defaultQueue].transactions.count);
    DDLog(@"----completeTransaction");
    DDLog(@"---%@",transaction.payment.applicationUsername);
    DDLog(@"pro---%@",transaction.payment.productIdentifier);
    ReqPayValidate *req = [[ReqPayValidate alloc] init];
    req.receipt = [self getReceipt];
    req.order_id = lxbOrderId;
    
    //用户还没有完成登陆
    if ([DataHub getInstance].userModel == nil){
        DDLog(@"用户还没有登陆不去查询 且关闭订单");
        //[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        self.payStatus = LXBPayNone;
    }
    else{
        req.account_id = [DataHub getInstance].userModel.account_id;
        req.transaction_id = transaction.transactionIdentifier;
        [PayController validateOrder:req success:^(id  _Nonnull responseObject) {
            ResPayValidate *res = (ResPayValidate *)responseObject;
            DDLog(@"product_id%@",res.product_id);
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:PaySuccNotiName object:[transaction mj_JSONString]];
            
            self.payStatus = LXBPayNone;
            } failure:^(NSError * _Nonnull error) {
                [[NSNotificationCenter defaultCenter] postNotificationName:PayFailNotiName object:[error description]];
            }];
    }
}

- (NSString *)getReceipt{
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    NSString *receiptString = [receiptData base64EncodedStringWithOptions:0];
    DDLog(@"Purchase Receipt: %@", receiptString);
    return receiptString;
   
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    NSString *errorInfo = nil;
    if (transaction.error.code != SKErrorPaymentCancelled) {
        //拉起支付错误
        errorInfo = [NSString stringWithFormat:@"拉起支付错误 %@ 苹果产品id = %@",transaction.error,transaction.payment.productIdentifier];
    }
    else{
        errorInfo = @"用户取消支付";
    }
    
    
    // 完成交易后，务必调用finishTransaction方法
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    [[NSNotificationCenter defaultCenter] postNotificationName:PayFailNotiName object:errorInfo];
    DDLog(@"----failedTransaction");
}


- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 在这里处理恢复购买成功的逻辑，例如向用户提供购买的商品或服务
    // 完成交易后，务必调用finishTransaction方法
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)handleCreateOrder:(ResPayCreate *)res{
    [KeychainController saveOrderId:res.orderId proId:res.product_id];
    [self appleBuyWithProId:res.product_id];
}

#pragma mark - 订单处理
- (BOOL)finishLostOrder{
    NSInteger transCount = [SKPaymentQueue defaultQueue].transactions.count;
    DDLog(@"有未完成的订单 %lu", transCount);
    if(transCount > 0){
        SKPaymentTransaction *skp = [SKPaymentQueue defaultQueue].transactions[0];
    
        [self dealTransactionWithStatus:skp];
        return YES;
    }
    else{
        DDLog(@"没有未完成的订单");
        return NO;
    }
}

- (BOOL)checkPayArg:(NSDictionary *)arg{
    BOOL re = YES;
    if(arg[@"product_id"] == nil){
        NSLog(@"product_id error");
        re = NO;
    }
    if(arg[@"amount"] == nil){
        NSLog(@"amount error");
        re = NO;
    }
    if(arg[@"body"] == nil){
        NSLog(@"body error");
        re = NO;
    }
    if(arg[@"detail"] == nil){
        NSLog(@"detail error");
        re = NO;
    }
    if(arg[@"server_id"] == nil){
        NSLog(@"server_id error");
        re = NO;
    }
    if(arg[@"notify_url"] == nil){
        NSLog(@"notify_url error");
        re = NO;
    }
    if(arg[@"extension"] == nil){
        NSLog(@"extension error");
        re = NO;
    }
    
    return re;
}

- (void)lxbPay:(NSDictionary *)dic{
    ReqPayCreate *req = [[ReqPayCreate alloc] init];
    if([self checkPayArg:dic] == NO){
        return;
    }
    
    
    req.product_id = dic[@"product_id"];
    NSString *amount = dic[@"amount"];
    req.amount = [amount intValue];
    req.body = dic[@"body"];
    req.detail = dic[@"detail"];
    //游戏服id
    NSString *serverId = dic[@"server_id"];
    req.server_id = [serverId intValue];
    //必须穿
    req.notify_url = dic[@"notify_url"];
    //必须穿
    req.extension = dic[@"extension"];
    
    
    req.device_id = [DataHub getInstance].userModel.device_id;
    req.cash_fee = req.amount;
    req.account_id = [DataHub getInstance].userModel.account_id;
    req.currency = @"USD";
    req.cash_currency = @"USD";
    req.platform = @"apple";
    req.trade_type = @"APP";
    req.game_id = [[SDKModel getInstance].sdkArg.U8_GAME_ID longLongValue];
    
    
    [PayController ceratePayOrder:req];
}



#pragma mark - 网络处理
+ (void)ceratePayOrder:(ReqPayCreate *)model{
    NSInteger transCount = [SKPaymentQueue defaultQueue].transactions.count;
    //
    if(transCount > 0){
        [LXBHelper showToast:getLocalString(@"pay_more_order_need_finish")];
        [[PayController getInstance] finishLostOrder];
    }
    else{
        
        //拉起遮挡
        [LXBHelper showLoading:getLocalString(@"pay_paying")];
        
        [PayController getInstance].payStatus = LXBCreateOriderFormU8Server;
        [NetworkController POST:PayModuleName classMeta:[ResPayCreate class] url:payCreate parameters:[model mj_keyValues]
                        success:^(id responseObject){
                            [[PayController getInstance] handleCreateOrder:responseObject];
                        }
                        failure:^(NSError *error){
                            [PayController getInstance].payStatus = LXBPayNone;
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:PayFailNotiName object:[error description]];
                            
                        }
        ];
    }
}

+ (void)validateOrder:(ReqPayValidate *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [NetworkController POST:PayModuleName classMeta:[ResPayValidate class] url:payValidateUrl parameters:[model mj_keyValues]  success:success failure:failure];
}

@end
