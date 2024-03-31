//
//  GoogleLoginController.m
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import "GoogleLoginController.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "LoginController.h"
#import "BindExtend.h"
static GoogleLoginController *instance;
@implementation GoogleLoginController


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self innerInit];
    }
    return self;
}

- (void)innerInit{
    
}

+ (GoogleLoginController *)getInstance{
    if(instance == nil){
        instance = [[GoogleLoginController alloc] init];
    }
    return instance;
}

- (void)googleLogin{
    UIViewController *controller = [SDKModel getInstance].rootController;
    [GIDSignIn.sharedInstance signInWithPresentingViewController:controller completion:^(GIDSignInResult * _Nullable signInResult, NSError * _Nullable error) {
            if(error){
                [[LoginController getInstance] postLoginFail:[error description]];
                return;
            }
            
            NSLog(@"sign in google");
        
            GIDGoogleUser *user = signInResult.user;
        
            NSString *userId = user.userID;
            NSString *idToken = user.idToken.tokenString;
            //NSString *idToken = user.authentication.idToken;
            NSString *nickname = user.profile.name;
            NSString *imgUrl = nil;
            if (user.profile.hasImage) {
                imgUrl = [[user.profile imageURLWithDimension:320] absoluteString];
            }
            imgUrl = imgUrl ? imgUrl:@"";
        
            NSMutableDictionary *resultDict = [NSMutableDictionary dictionaryWithCapacity:4];
            [resultDict setValue:userId forKey:@"user_id"];
            [resultDict setValue:idToken forKey:@"id_token"];
            [resultDict setValue:nickname forKey:@"nickname"];
            [resultDict setValue:imgUrl forKey:@"avatar"];
        
            NSLog(@"xxxxx %p", resultDict);
        
            BindExtend *bind = [[BindExtend alloc] init];
            bind.platform_id = userId;
            bind.verify_type = 10;
            bind.access_token = idToken;
            bind.code = @"";
            bind.nickname = nickname;
            bind.avatar = imgUrl;
        
            [[NSNotificationCenter defaultCenter] postNotificationName:GoogleLoginNotiName object:bind];
    }];
}

@end
