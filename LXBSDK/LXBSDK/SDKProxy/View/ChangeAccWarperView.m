//
//  ChangeAccWarperView.m
//  LXBSDK
//
//  Created by pub on 2024/2/19.
//

#import "ChangeAccWarperView.h"
#import "DeleteAccountView.h"
@implementation ChangeAccWarperView

- (void)initViews{
    [super initViews];
    
    [self initContentSubView];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self initMenuView];
}

- (void)initContentSubView{
    MyLinearLayout *desView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    desView.myWidth = MyLayoutSize.fill;
    desView.myHeight = UI(120);
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = getLocalString(@"u8_account_cutacc_warper_des");
    lable.font = [UIFont systemFontOfSize:UI(16)];
    lable.textColor = [UIColor grayColor];
    lable.myWidth = MyLayoutSize.fill;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.myHeight = UI(100);
    [desView addSubview:lable];
    
    [self.contentView addSubview:desView];
}

- (void)initMenuView{
    NSArray *menuCfg = [LXBConfig getInstance].changeAccWarperCfg;
    for (int i = 0; i < menuCfg.count; i++) {
        NSDictionary *dic = menuCfg[i];
        
        MyLinearLayout *bgView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        bgView.myHeight = UI(50);
        
        bgView.myWidth = MyLayoutSize.fill;
        
       
        //bgView.layer.cornerRadius = UI(6);
        bgView.myTop = UI(15);
        bgView.tag = i;
        UILabel *label = [[UILabel alloc] init];
        label.text = dic[@"showText"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:UI(16)];
        label.myHeight = MyLayoutSize.fill;
        label.myWidth = MyLayoutSize.fill;
        [bgView addSubview:label];
        [self.contentView addSubview:bgView];
        
        LXBUITap *tap = [[LXBUITap alloc] init];
        [tap addTarget:self action:@selector(menuClick:)];
        [bgView addGestureRecognizer:tap];
        
        if(i == 0){
            bgView.backgroundImage = [LXBHelper imageWithName:@"public_btn01_yhzx"];
            label.textColor = [UIColor whiteColor];
        }
        else{
            bgView.backgroundColor = [LXBHelper titleBgView];//;
            label.textColor = [LXBHelper normalTextColor];
            bgView.layer.cornerRadius = UI(24);
        }
    }
    
}

- (void)menuClick:(LXBUITap *)tap{
    DDLog(@"xxx");
    if(tap.view.tag == 0){
        [self changeAccTips];
    }
    else{
        [self showDeleteAccView];
    }
}

- (void)changeAccTips{
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:getLocalString(@"u8_account_cutacc_warper_tips_cancle") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        DDLog(@"cancel");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:getLocalString(@"u8_account_cutacc_warper_tips_confirm") style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        DDLog(@"yes");
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:getLocalString(@"u8_account_cutacc_warper_tips_title") message:getLocalString(@"u8_account_cutacc_warper_tips_content") preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showDeleteAccView{
    DeleteAccountView *view = [[DeleteAccountView alloc] initTitle:getLocalString(@"u8_account_cutacc_warper_otherfun") isRightCloseBtn:RightClose];
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:view];
}

@end
