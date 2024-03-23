//
//  LXBConfig.m
//  LXBSDK
//
//  Created by pub on 2024/2/19.
//

#import "LXBConfig.h"

static LXBConfig *instance;

@implementation LXBConfig



+ (LXBConfig *)getInstance{
    if(instance == nil){
        instance = [[LXBConfig alloc]init];
    }
    return instance;
}


- (NSArray *)bindViewCfg{
    return @[
        @{
            @"imgName":@"public_icon_facebook",
            @"showText":getLocalString(@"user_account_ui_bind_facebook"),
        },
        @{
            @"imgName":@"public_icon_google",
            @"showText":getLocalString(@"user_account_ui_bind_google"),
        },
        @{
            @"imgName":@"public_icon_apple",
            @"showText":getLocalString(@"user_account_ui_bind_apple"),
        },
    ];
}

- (NSArray *)menuViewCfg{
    
    return @[
        @{
            @"imgName":@"zhanghao_icon_yhzx",
            @"showText":getLocalString(@"user_account_ui_bind_title"),
        },
        @{
            @"imgName":@"kefu_icon_yhzx",
            @"showText":getLocalString(@"u8_account_UI_contactService"),
        },
        @{
            @"imgName":@"xieyi_icon_yhzx",
            @"showText":getLocalString(@"user_account_ui_main_menu_service")
        },
        @{
            @"imgName":@"qiehuan_icon_yhzx",
            @"showText":getLocalString(@"user_account_ui_main_menu_change_acc"),
        },
    ];
}

- (NSArray *)changeAccViewCfg{
    return @[
        @{
            @"imgName":@"public_icon_facebook",
            @"showText":getLocalString(@"u8_account_info_cutacc_signinfacebook"),
        },
        @{
            @"imgName":@"public_icon_google",
            @"showText":getLocalString(@"u8_account_info_cutacc_signingoogel")
        },
        @{
            @"imgName":@"public_icon_apple",
            @"showText":getLocalString(@"u8_account_info_cutacc_signinapple"),
        },
        
        @{
            @"imgName":@"zhanghao_icon_yhzx",
            @"showText":getLocalString(@"u8_account_info_cutacc_signindevicesid"),
        },
    ];
}

- (NSArray *)changeAccWarperCfg{
    return @[
        @{
            @"showText":getLocalString(@"u8_account_info_cutoverAccount"),
            @"bgColor": [LXBHelper mainColor],
        },
        
        @{
            @"showText":getLocalString(@"u8_account_cutacc_warper_otherfun"),
            @"bgColor": [UIColor whiteColor],
        },
    ];
}

@end
