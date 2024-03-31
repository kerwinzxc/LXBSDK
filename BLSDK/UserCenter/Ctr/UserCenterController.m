//
//  UserCenterController.m
//  LXBSDK
//
//  Created by pub on 2024/1/30.
//

#import "UserCenterController.h"
#import "ResVisitor.h"



@implementation UserCenterController

/*
游客登陆
 */
+ (void)visitorReq:(ReqVisitor *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [NetworkController POST:UserCenterModuleName classMeta:[ResVisitor class] url:visitorUrl parameters:[model mj_keyValues] success:success failure:failure];
}

+ (void)autoLoginReq:(ReqAutoLogin *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [NetworkController POST:UserCenterModuleName classMeta:[ResVisitor class] url:autoLoginUrl parameters:[model mj_keyValues] success:success failure:failure];
}

+ (void)overseaBind:(ReqOverseaBind *)model sucess:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [NetworkController POST:UserCenterModuleName classMeta:[ResVisitor class] url:overseaBind parameters:[model mj_keyValues] success:success failure:failure];
}

+ (void)thirdPartyLogin:(ReqThirdPartyLogin *)model sucess:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [NetworkController POST:UserCenterModuleName classMeta:[ResVisitor class] url:thirdPartyLogin parameters:[model mj_keyValues] success:success failure:failure];
}

@end
