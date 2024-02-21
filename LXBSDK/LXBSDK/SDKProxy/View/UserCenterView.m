//
//  UserCenterView.m
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import "UserCenterView.h"
#import "NSString+Handle.h"
#import "U8Language.h"
#import "BindAccView.h"
#import "ChangeAccountView.h"
#import "ChangeAccWarperView.h"
#import "ServiceAndPolicyView.h"
@implementation UserCenterView

- (instancetype)init{
    self = [super init];
    return self;
}

- (void)initViews{
    [super initViews];
    
    [self.contentView addSubview:self.uidView];
    //[self.contentView addSubview:self.bindAccountBtn];
    [self menuItemViewInit];
}


- (MyLinearLayout *)uidView{
    if (_uidView == nil) {
        _uidView = [[MyLinearLayout alloc]initWithOrientation:MyOrientation_Horz];
        _uidView.myWidth = UI(370);
        _uidView.myHeight = UI(60);
        _uidView.backgroundColor = [UIColor whiteColor];
        _uidView.layer.cornerRadius = UI(6);
        _uidView.gravity = MyGravity_Vert_Center;
        
        UIImageView *iconView = [UIImageView new];
        iconView.myWidth = UI(50);
        iconView.myHeight = UI(50);
        iconView.leftPos.equalTo(_uidView.leftPos).offset(10);
        iconView.image = [LXBHelper imageWithName:@"HeadPic"];
        [_uidView addSubview:iconView];
        UILabel *uinLabel = [UILabel new];
        uinLabel.text = @"UID:234567890998777";
        uinLabel.font = [UIFont boldSystemFontOfSize:UI(18)];
        uinLabel.textColor = [UIColor blackColor];
        [uinLabel sizeToFit];
        uinLabel.leftPos.equalTo(iconView.rightPos).offset(10);
        [_uidView addSubview:uinLabel];
    }
   
    return _uidView;
}

- (void)menuItemViewInit{
    NSArray *cfg = [LXBConfig getInstance].menuViewCfg;
    for (int i = 0; i < cfg.count; i++) {
        NSDictionary *dic = cfg[i];
        MyLinearLayout *menuBtn = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        menuBtn.tag = i;
        menuBtn.backgroundColor = [UIColor whiteColor];
        menuBtn.myWidth = UI(370);
        menuBtn.myHeight = UI(50);
        menuBtn.gravity =  MyGravity_Vert_Center;
        UIImage *img = [LXBHelper imageWithName:dic[@"imgName"]];
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = img;
        iconView.myHeight = UI(44);
        iconView.myWidth = UI(44);
        iconView.leftPos.equalTo(menuBtn.leftPos).offset(UI(10));
        [menuBtn addSubview:iconView];
        menuBtn.layer.cornerRadius = UI(4);
        
        UILabel *txtLable = [UILabel new];
        txtLable.text = getLocalString(dic[@"showText"]);
        txtLable.font = [UIFont systemFontOfSize:UI(18)];
        txtLable.textColor = [UIColor blackColor];
        [txtLable sizeToFit];
        txtLable.leftPos.equalTo(iconView.rightPos).offset(10);
        
        [menuBtn addSubview:txtLable];
        
        LXBUITap *tap = [[LXBUITap alloc] init];
        [tap addTarget:self action:@selector(bindBtnClick:)];
        [menuBtn addGestureRecognizer:tap];
        
        MyLinearLayout *JianTouParent = [[MyLinearLayout alloc] init];
        JianTouParent.myHeight = MyLayoutSize.fill;
        JianTouParent.weight = 1;
        JianTouParent.backgroundColor = [UIColor clearColor];
        JianTouParent.gravity = MyGravity_Vert_Center;
        
        [menuBtn addSubview:JianTouParent];
        
        UIImageView *jiantou = [[UIImageView alloc] init];
        jiantou.image = [LXBHelper imageWithName:@"PicArrow"];
        jiantou.myWidth = UI(20);
        jiantou.myHeight = UI(20);
        jiantou.rightPos.equalTo(menuBtn.rightPos).offset(16);
        [JianTouParent addSubview:jiantou];
        
        [self.contentView addSubview:menuBtn];
    }
}

- (void)bindBtnClick:(LXBUITap *)send{
    if(send.view.tag == 0){
        //绑定
        BindAccView *bindView = [[BindAccView alloc] initTitle:getLocalString(@"user_account_ui_bind_title") isRightCloseBtn:LeftClose];

        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [window addSubview:bindView];
    }
    else if (send.view.tag == 1){
        //客服
        [self showChangeAccWarperView];
    }
    else if(send.view.tag == 2){
        //协议
        [self showServiceAndPolicyView];
    }
    else if(send.view.tag == 3){
        //切换账号
        ChangeAccountView *bindView = [[ChangeAccountView alloc] initTitle:getLocalString(@"u8_account_info_cutoverAccount") isRightCloseBtn:NOClose];
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [window addSubview:bindView];
    }
}

- (void)showChangeAccWarperView{
    ChangeAccWarperView *warperView = [[ChangeAccWarperView alloc] initTitle:getLocalString(@"u8_account_cutacc_warper_title") isRightCloseBtn:LeftClose];
    
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:warperView];
}


- (void)showServiceAndPolicyView{
    ServiceAndPolicyView *view = [[ServiceAndPolicyView alloc] initTitle:getLocalString(@"user_account_ui_main_menu_service") isRightCloseBtn:LeftClose];
    
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:view];
}

@end
