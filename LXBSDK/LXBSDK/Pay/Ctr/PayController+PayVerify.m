//
//  PayController+PayVerify.m
//  LXBSDK
//
//  Created by pub on 2024/2/2.
//

#import "PayController+PayVerify.h"

@implementation PayController (PayVerify)

- (void)localReceiptVerifyingWithUrl:(NSString *)requestUrl AndReceipt:(NSString *)receiptStr AndTransaction:(SKPaymentTransaction *)transaction {
    NSString *reqUrl = @"https://sandbox.itunes.apple.com/verifyReceipt";
    NSDictionary *requestContents = @{  @"receipt-data": receiptStr,  };
    NSError *error;  // 转换为 JSON 格式
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents  options:0  error:&error];  NSString *verifyUrlString = requestUrl;  NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:verifyUrlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];    //在后台对列中提交验证请求，并获得官方的验证JSON结果
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:storeRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        if (error) {
        NSLog(@"链接失败");
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];}
        else {
            NSError *error;  NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!jsonResponse) {
                NSLog(@"验证失败");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }  NSLog(@"验证成功");  //TODO:取这个json的数据去判断，道具是否下发
    }}];
    [task resume];
}

@end
