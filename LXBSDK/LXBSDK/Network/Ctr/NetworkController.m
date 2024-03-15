//
//  NetworkController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//
#import "PostArgUtils.h"
#import "NetworkController.h"
#import "PostArgUtils.h"
#import "BaseResponse.h"
#import <MJExtension/MJExtension.h>
@implementation NetworkController

+ (void)networkServiceInit{
    if (OPENNETWORKLOG) {
        [MSNetwork openLog];
    }
    else{
        [MSNetwork closeLog];
    }
    
    [MSNetwork setBaseURL:kApiPrefix];
    [MSNetwork setRequestTimeoutInterval:NETWORKTIMEOUT];
    
    [MSNetwork setValue:U8_GAME_ID forHTTPHeaderField:HeadXGameId];
    [MSNetwork setValue:U8_CHANNEL forHTTPHeaderField:HeadXChannelId];
    [MSNetwork setValue:U8_PACKAGE_ID forHTTPHeaderField:HeadXPackageId];
    [MSNetwork setValue:@"1" forHTTPHeaderField:HeadXDeviceType];
    [MSNetwork setValue:@"zh-CN" forHTTPHeaderField:HeadXLanguage];
    [MSNetwork setValue:@"2.0" forHTTPHeaderField:HeadXVersion];
    [MSNetwork setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:HeadContentType];
    [self test];
}

+ (void)test{
    NSNumber *ll = [PostArgUtils getMillisec];
    DDLog(@"%@",ll);
}

+ (void)GET:(NSString *)moduleName classMeta:(Class)clazz url:(NSString *)URL parameters:(NSDictionary *)parameters success:(MSHttpSuccess)success  failure:(MSHttpFail)failure{
    [self lxbRequestWithMethod:MSRequestMethodGET classMeta:clazz moduleName:moduleName url:URL params:parameters success:success failure:failure];
}

+ (void)POST:(NSString *)moduleName classMeta:(Class)clazz url:(NSString *)URL parameters:(NSDictionary *)parameters success:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [self lxbRequestWithMethod:MSRequestMethodPOST classMeta:clazz moduleName:moduleName url:URL params:parameters success:success failure:failure];
}

+ (void)lxbRequestWithMethod:(MSRequestMethod)method
                   classMeta:(Class)clazz
                  moduleName:(NSString *)mName
                         url:(NSString *)URL
                      params:(NSDictionary *)params
                     success:(MSHttpSuccess)success
                     failure:(MSHttpFail)failure{
    NSString *blUrl = [NSString stringWithFormat:@"%@/%@/%@",mName,kServerVersion,URL];
    NSDictionary *lastParams = [PostArgUtils hmacSHA256WithDict:params];
    
    [self networkServiceInit];
    
    [MSNetwork HTTPWithMethod:method url:blUrl parameters:lastParams headers:nil cachePolicy:MSCachePolicyOnlyNetNoCache success:^(id  _Nonnull data) {
        BaseResponse *baseResponse=[[BaseResponse class] mj_objectWithKeyValues:data];
        if([self isSuccessWithResponse:baseResponse]){
            id dataDict=data[@"data"];
            
            id meta=[[clazz class] mj_objectWithKeyValues:dataDict];
            
            success(meta);
        }
        else{
            NSError *lxbError = [[NSError alloc] initWithDomain:[baseResponse mj_JSONString] code:-1 userInfo:nil];
            failure(lxbError);
        }
        //[MBProgressHUD mb_hide];
        
    } failure:^(NSError * _Nonnull error) {
        //[MBProgressHUD mb_hide];
        failure(error);
    }];
}


+ (BOOL)isSuccessWithResponse:(BaseResponse *)data{
    return data.code == 200;
}

#pragma mark - 请求的公共方法
// demo
+ (void)requestWithMethod:(MSRequestMethod)method url:(NSString *)URL  parameters:(NSDictionary *)parameters cachePolicy:(MSCachePolicy)cachePolicy success:(MSHttpSuccess)success  failure:(MSHttpFail)failure{
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    [MSNetwork closeLog];
    //设置基础的Url
    //最终完整Url为[NSString stringWithFormat:@“%@%@”,_baseURL,URL]
    [MSNetwork setBaseURL:kApiPrefix];

    //设置缓存过滤 设置后会移除该参数进行缓存
    //
    //[MSNetwork setFiltrationCacheKey:@[@"time",@"ts"]];
    //设置超时时间
    //[MSNetwork setRequestTimeoutInterval:15.0f];
    
    // 设置请求头
    //可一次设置多个也可单独设置
    //[MSNetwork setHeadr:@{@"api-version":@"v1.0.0"}];
    //[MSNetwork setValue:@"9" forHTTPHeaderField:@"fromType"];

    //设置公用请求参数
//    NSDictionary *dic = @{@"accountToken":@{@"tokenId":@"",@"userId":@"",@"initDate":@"",@"clientType":@"mobilType",@"tokenKey":@""}};
//    [MSNetwork setBaseParameters:dic];
    
    //可以设置全局等待的指示器
//    [MBProgressHUD mb_loading:^{
//        
//    }];

    
//    [MSNetwork setAFHTTPSessionManagerProperty:^(AFHTTPSessionManager * sessionManager) {
//
//    }];
    
    // 发起请求
    [MSNetwork HTTPWithMethod:method url:URL parameters:parameters headers:nil cachePolicy:cachePolicy success:^(id  _Nonnull responseObject) {
        //[MBProgressHUD mb_hide];
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        //[MBProgressHUD mb_hide];
        failure(error);
    }];
}


@end
