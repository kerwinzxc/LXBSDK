//
//  PayController.m
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import "PayController.h"
#import "PayConfig.h"

@implementation PayController


+ (void)ceratePayOrder:(ReqPayCreate *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [NetworkController POST:PayModuleName classMeta:[ResPayCreate class] url:payCreate parameters:[model mj_keyValues] success:success failure:failure];
}

@end
