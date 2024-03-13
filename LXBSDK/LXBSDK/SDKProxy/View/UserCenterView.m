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
#import "KeFuView.h"
#import "SDKController.h"
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
        _uidView.myWidth = MyLayoutSize.fill;
        _uidView.myHeight = UI(50);
        _uidView.backgroundColor = [UIColor whiteColor];
        _uidView.layer.cornerRadius = UI(26);
        _uidView.gravity = MyGravity_Center;
        
        UILabel *uinLabel = [UILabel new];
        uinLabel.text = @"UID:234567890998777";
        uinLabel.font = [UIFont boldSystemFontOfSize:UI(18)];
        uinLabel.textColor = [LXBHelper normalTextColor];
        [uinLabel sizeToFit];
       
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
        menuBtn.myWidth = MyLayoutSize.fill;
        menuBtn.myHeight = UI(54);
        menuBtn.gravity =  MyGravity_Vert_Center;
        UIImage *img = [LXBHelper imageWithName:dic[@"imgName"]];
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = img;
        iconView.myHeight = UI(40);
        iconView.myWidth = UI(40);
        iconView.leftPos.equalTo(menuBtn.leftPos).offset(UI(8));
        [menuBtn addSubview:iconView];
        menuBtn.layer.cornerRadius = UI(26);
        
        UILabel *txtLable = [UILabel new];
        txtLable.text = getLocalString(dic[@"showText"]);
        txtLable.font = [UIFont boldSystemFontOfSize:UI(16)];
        txtLable.textColor = [LXBHelper normalTextColor];
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
        jiantou.image = [LXBHelper imageWithName:@"jiantou_icon_yhzx"];
        jiantou.myWidth = UI(20);
        jiantou.myHeight = UI(16);
        jiantou.rightPos.equalTo(menuBtn.rightPos).offset(16);
        [JianTouParent addSubview:jiantou];
        
        [self.contentView addSubview:menuBtn];
    }
}

- (void)bindBtnClick:(LXBUITap *)send{
    if(send.view.tag == 0){
        //绑定
        BindAccView *bindView = [[BindAccView alloc] initTitle:getLocalString(@"user_account_ui_bind_title") isRightCloseBtn:RightClose];

        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [window addSubview:bindView];
    }
    else if (send.view.tag == 1){
        //客服
        [self showKefuView];
    }
    else if(send.view.tag == 2){
        //协议
        [self showServiceAndPolicyView];
    }
    else if(send.view.tag == 3){
        //切换账号
        [self showChangeAccWarperView];
    }
}

- (void)showChangeAccWarperView{
    ChangeAccWarperView *warperView = [[ChangeAccWarperView alloc] initTitle:getLocalString(@"u8_account_cutacc_warper_title") isRightCloseBtn:RightClose];
    
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:warperView];
}


- (void)showServiceAndPolicyView{
    ServiceAndPolicyView *view = [[ServiceAndPolicyView alloc] initTitle:getLocalString(@"user_account_ui_main_menu_service") isRightCloseBtn:RightClose];
    
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:view];
}

- (void)showKefuView{
    [ViewHub openKeFuView];
}

@end
