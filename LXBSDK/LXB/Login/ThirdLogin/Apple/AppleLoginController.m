//
//  AppleLoginController.m
//  LXBSDK
//
//  Created by pub on 2024/2/5.
//

#import "AppleLoginController.h"
#import "LoginController.h"

static AppleLoginController *instance;
@implementation AppleLoginController

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

+ (AppleLoginController *)getInstance{
    if(instance == nil){
        instance = [[AppleLoginController alloc] init];
    }
    return instance;
}

- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller{
    return [[UIApplication sharedApplication].windows objectAtIndex:0];
}

- (void)launchLogin{
    ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
    ASAuthorizationAppleIDRequest *request = [appleIDProvider createRequest];
    request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        
    ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
    controller.delegate = self;
    controller.presentationContextProvider = self;
    [controller performRequests];
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization{
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *apple = (ASAuthorizationAppleIDCredential *)authorization.credential;
            
        ///将返回得到的user 存储起来
        NSString *userIdentifier = apple.user;
        NSPersonNameComponents *fullName = apple.fullName;
        NSString *email = apple.email;
        //用于后台像苹果服务器验证身份信息
        NSData *identityToken = apple.identityToken;
        
        NSString *appToken = [[NSString alloc] initWithData:identityToken encoding:NSUTF8StringEncoding];
        
        BindExtend *bind = [[BindExtend alloc] init];
        bind.platform_id = ApplePlaformName;
        bind.verify_type = 11;
        bind.access_token = appToken;
        bind.code = @"";
        bind.nickname = @"";
        bind.avatar = @"";
        
        [[NSNotificationCenter defaultCenter] postNotificationName:AppleLoginNotiName object:bind];
       }
    
    else{
        [[LoginController getInstance] postLoginFail:@"xxx"];
    }
}
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  NS_SWIFT_NAME(authorizationController(controller:didCompleteWithError:)){
    [[LoginController getInstance] postLoginFail:[error description]];
}


@end
