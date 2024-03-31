//
//  ReamNameController.m
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import "RealNameController.h"

@implementation RealNameController
+ (void)realName:(ReqRealName *)model success:(MSHttpSuccess)success failure:(MSHttpFail)failure{
    [NetworkController POST:realNameModuleName classMeta:[ResRealName class] url:realNameUrl parameters:[model mj_keyValues] success:success failure:failure];
}
@end
