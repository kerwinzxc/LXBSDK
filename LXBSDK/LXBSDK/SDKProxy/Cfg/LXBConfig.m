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
            @"imgName":@"FacebookIcon",
            @"showText":getLocalString(@"user_account_ui_bind_facebook"),
        },
        @{
            @"imgName":@"GoogleIcon",
            @"showText":getLocalString(@"user_account_ui_bind_google"),
        },
        @{
            @"imgName":@"PingIcon",
            @"showText":getLocalString(@"user_account_ui_bind_apple"),
        },
    ];
}

- (NSArray *)menuViewCfg{
    
    return @[
        @{
            @"imgName":@"UserBind",
            @"showText":getLocalString(@"user_account_ui_bind_title"),
        },
        @{
            @"imgName":@"Callkefu",
            @"showText":getLocalString(@"u8_account_UI_contactService"),
        },
        @{
            @"imgName":@"ServiceBook",
            @"showText":getLocalString(@"user_account_ui_main_menu_service")
        },
        @{
            @"imgName":@"CutCan",
            @"showText":getLocalString(@"user_account_ui_main_menu_change_acc"),
        },
    ];
}

- (NSArray *)changeAccViewCfg{
    return @[
        @{
            @"imgName":@"HitpointPerception",
            @"showText":getLocalString(@"u8_account_info_cutacc_signinfacebook"),
        },
        @{
            @"imgName":@"SolitairePatience",
            @"showText":getLocalString(@"u8_account_info_cutacc_signingoogel")
        },
        @{
            @"imgName":@"PingIcon",
            @"showText":getLocalString(@"u8_account_info_cutacc_signinapple"),
        },
        
        @{
            @"imgName":@"",
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
