//
//  DeleteAccountView.m
//  LXBSDK
//
//  Created by pub on 2024/2/19.
//

#import "DeleteAccountView.h"
#import "DeleteWarperView.h"
#import "SDKController.h"
@implementation DeleteAccountView

- (void)initViews{
    [super initViews];
    
    [self initContentSubView];
}

- (void)initContentSubView{
    [self initDesView];
    [self initBtnView];
}

- (void)initDesView{
    MyLinearLayout *desView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    desView.myHeight = UI(150);
    desView.myWidth = MyLayoutSize.fill;
    //desView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:desView];
   
    UILabel *label = [[UILabel alloc] init];
    label.myWidth = MyLayoutSize.fill;
    label.myHeight = MyLayoutSize.wrap;
    label.textColor = [UIColor grayColor];
    label.text = getLocalString(@"u8_account_cutacc_delete_des");
    label.font = [UIFont systemFontOfSize:UI(16)];
    label.textAlignment = NSTextAlignmentLeft;
    
    [desView addSubview:label];
}

- (void)initBtnView{
    MyLinearLayout *btnView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    btnView.myHeight = UI(50);
    btnView.myWidth = MyLayoutSize.fill;
    btnView.layer.cornerRadius = UI(6);
    btnView.gravity = MyGravity_Center;
    btnView.backgroundImage = [LXBHelper imageWithName:@"public_btn01_yhzx"];
    //btnView.backgroundColor = [LXBHelper mainColor];
    //btnView.subviewHSpace = UI(10);
    [self.contentView addSubview:btnView];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.text = getLocalString(@"u8_account_UI_contactService");
    label.font = [UIFont boldSystemFontOfSize:(16)];
    [label sizeToFit];
    [btnView addSubview:label];
    
    LXBUITap *tap = [[LXBUITap alloc] init];
    [tap addTarget:self action:@selector(btnClick:)];
    [btnView addGestureRecognizer:tap];
}

- (void)btnClick:(LXBUITap *)send{
//    DeleteWarperView *view = [[DeleteWarperView alloc] initTitle:getLocalString(@"u8_account_cutacc_delete_btntxt") isRightCloseBtn:RightClose];
    [[SDKController getInstance] openKeFuView];
    
}

@end
