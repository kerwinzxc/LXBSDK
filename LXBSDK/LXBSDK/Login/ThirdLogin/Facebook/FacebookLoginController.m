//
//  FacebookLoginController.m
//  LXBSDK
//
//  Created by pub on 2024/3/14.
//

#import "FacebookLoginController.h"
#import "BindExtend.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LoginController.h"
static FacebookLoginController *instance;
@implementation FacebookLoginController


+ (FacebookLoginController *)getInstance{
    if(instance == nil){
        instance = [[FacebookLoginController alloc] init];
    }
    return instance;
}


- (void)facebookLogin{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    __weak typeof(self) weakSelf = self;
    UIViewController *rootCtr = [SDKModel getInstance].rootController;
       [login logInWithPermissions:@[@"public_profile",@"email"]
                fromViewController:rootCtr
                           handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
           if (error) {
               [[LoginController getInstance] postLoginFail:[error description]];
               return;
           }
           
           FBSDKAccessToken* accessToken = [FBSDKAccessToken currentAccessToken];
           if (accessToken) {
               NSLog(@"--- login success, userId: %@, token: %@", accessToken.userID, accessToken.tokenString);
               [weakSelf getUserInfoWithResult:result];
           }
           else{
               [[LoginController getInstance] postLoginFail:@"facebook use canle login"];
           }
           
       }];
}



//获取用户信息 picture用户头像
- (void)getUserInfoWithResult:(FBSDKLoginManagerLoginResult *)result{
    //,age_range,first_name,last_name,link,gender,locale,timezone,updated_time,verified
    NSDictionary*params= @{@"fields":@"id,name,email,picture"};
    NSString *facebookID = result.token.userID;
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:facebookID
                                  parameters:params
                                  HTTPMethod:@"GET"];
    
    [request startWithCompletion:^(id<FBSDKGraphRequestConnecting>  _Nullable connection, id  _Nullable result, NSError * _Nullable error) {
        NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithCapacity:0];
        
        NSString *nickname = @"";
        NSString *imgUrl = @"";
        
        if (!error) {
            nickname = result[@"name"];
            NSDictionary *pictureDict = result[@"picture"][@"data"];
            if ([pictureDict isKindOfClass:[NSDictionary class]]) {
                imgUrl = pictureDict[@"url"];
            }
        }
        
        nickname = nickname ? nickname:@"";
        imgUrl = imgUrl ? imgUrl:@"";
        [resultDict setValue:nickname forKey:@"nickname"];
        [resultDict setValue:imgUrl forKey:@"avatar"];
        [resultDict setValue:[NSString stringWithFormat:@"%@",facebookID] forKey:@"user_id"];
        
        
        BindExtend *bind = [[BindExtend alloc] init];
        bind.platform_id = facebookID;
        bind.verify_type = 0;
        bind.avatar = imgUrl;
        bind.nickname = nickname;
        [[NSNotificationCenter defaultCenter] postNotificationName:FacebookLoginNotiName object:bind];
        
    }];

}

@end