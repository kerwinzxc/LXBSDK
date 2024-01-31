//
//  AFNet.m
//  LXBSDK
//
//  Created by pub on 2024/1/31.
//

#import "AFNet.h"
#import <AFNetworking/AFNetworking.h>
@implementation AFNet

+(void) Test{
    // 定义请求的 URL
    NSString *urlString = @"https://gmshwtest.boomgames.top/usercenter/v2/visitor";
    // 创建 AFHTTPSessionManager 对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // 设置请求头（如果有需要）
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-GameId"];
    [manager.requestSerializer setValue:@"1111111235" forHTTPHeaderField:@"X-ChannelId"];
    [manager.requestSerializer setValue:@"7047" forHTTPHeaderField:@"X-PackageId"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"X-DeviceType"];
    [manager.requestSerializer setValue:@"zh-CN" forHTTPHeaderField:@"X-Language"];
    [manager.requestSerializer setValue:@"2.0" forHTTPHeaderField:@"X-Version"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置请求参数
    NSDictionary *parameters = @{@"device_id":@"123456",
                                 @"sign":@"06fb3780266c1a2187a02ac22816c48e30df82586c8810fb9082428fc77f9eaf",
                                 @"uuid":@"123465",
                                 @"channel_id":@(1111111235),
                                 @"nonce":@"123465",
                                 @"timestamp":@(1654508225166)
    };

    // 发送 POST 请求
    [manager POST:urlString
        parameters:parameters
           headers:nil  // You can add custom headers here if needed
          progress:nil
           success:^(NSURLSessionDataTask *task, id responseObject) {
               // 请求成功的处理
               NSLog(@"Response: %@", responseObject);
           }
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               // 请求失败的处理
               NSLog(@"Error: %@", error);
           }];
}

@end
