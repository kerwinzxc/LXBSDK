//
//  ViewHub.m
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import "ViewHub.h"
#import "KeFuView.h"
#import "ChangeAccountView.h"
#import "LXBWebView.h"
#import "UserCenterView.h"
@implementation ViewHub

+ (void)openKeFuView{
    KeFuView *view = [[KeFuView alloc] initTitle:getLocalString(@"u8_account_UI_contactService") isRightCloseBtn:RightClose];
    [view setDes:getLocalString(@"use_kefu_des")];
    [[view getRootWindow] addSubview:view];
}

+ (void)openLoginView{
    ChangeAccountView *bindView = [[ChangeAccountView alloc] initTitle:getLocalString(@"u8_account_info_cutoverAccount") isRightCloseBtn:NOClose];
 
    [[bindView getRootWindow] addSubview:bindView];
}


+ (void)openWebView:(NSString *)urlString{
    LXBWebView *view = [[LXBWebView alloc] init];

    [[view getRootWindow] addSubview:view];
    [view showWeb:urlString];
}

+ (void)openCenterView{
    NSString *title = getLocalString(@"user_account_ui_usercenter");
    UserCenterView *view = [[UserCenterView alloc] initTitle:title isRightCloseBtn:RightClose];
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:view];
}

@end
