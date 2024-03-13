//
//  GoogleLoginController.m
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import "GoogleLoginController.h"
#import <GoogleSignIn/GoogleSignIn.h>
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
                //todo
                return;
            }
            
            NSLog(@"sign in google");
    }];
}

@end
