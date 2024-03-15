//
//  ServiceAndPolicyView.m
//  LXBSDK
//
//  Created by pub on 2024/2/20.
//

#import "ServiceAndPolicyView.h"
#import "SDKController.h"
@implementation ServiceAndPolicyView

- (void)initViews{
    [super initViews];
    
    [self initDesView];
    
    [self initLinkedBtn];
    
    [self initBackView];
}

- (void)initDesView{
    MyLinearLayout *firstTitleView = [[MyLinearLayout alloc] init];
    firstTitleView.myWidth = MyLayoutSize.fill;
    firstTitleView.myHeight = UI(80);
    [self.contentView addSubview:firstTitleView];
    UILabel *lable = [UILabel new];
    
    lable.text = getLocalString(@"user_account_ui_service_des1"); //user_account_ui_main_menu_service
    lable.font = [UIFont boldSystemFontOfSize:UI(16)];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.myHeight = UI(80);
    lable.myWidth = MyLayoutSize.fill;
    lable.textColor = [LXBHelper normalTextColor];
    lable.numberOfLines = 4;
    [firstTitleView addSubview:lable];
}

- (void)initLinkedBtn{
    MyLinearLayout *parentView = [[MyLinearLayout alloc]
                                  initWithOrientation:MyOrientation_Horz];
    //parentView.backgroundColor = [UIColor redColor];
    parentView.myWidth = MyLayoutSize.fill;
    parentView.myHeight = UI(100);
    parentView.gravity = MyGravity_Vert_Center;
    [self.contentView addSubview:parentView];
    
    for (int i = 0; i < 2; i++) {
        MyLinearLayout *btnView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        btnView.myHeight = MyLayoutSize.fill;
        btnView.myWidth = MyLayoutSize.wrap;
        btnView.gravity = MyGravity_Center;
        [parentView addSubview:btnView];
        UILabel *label = [[UILabel alloc] init];
        btnView.tag = i;
        if(i == 0){
            label.text = getLocalString(@"user_account_ui_service_btn1");
        }
        else{
            label.text = getLocalString(@"user_account_ui_service_btn2");
        }
        label.font = [UIFont boldSystemFontOfSize:UI(16)];
        [label sizeToFit];
        label.textColor = [UIColor blueColor];
        [btnView addSubview:label];
        
        LXBUITap *tapGesture = [[LXBUITap alloc] initWithTarget:self action:@selector(handleLinkTap:)];
        [btnView addGestureRecognizer:tapGesture];
    }
    
}

- (void)initBackView{
    MyLinearLayout *firstTitleView = [[MyLinearLayout alloc] init];
    firstTitleView.myWidth = MyLayoutSize.fill;
    firstTitleView.myHeight = UI(50);
    firstTitleView.layer.cornerRadius = UI(6);
    firstTitleView.backgroundImage = [LXBHelper imageWithName:@"public_btn01_yhzx"];
    [self.contentView addSubview:firstTitleView];
    
    UILabel *lable = [UILabel new];
    
    lable.text = getLocalString(@"user_account_ui_service_backbtn");
    lable.font = [UIFont boldSystemFontOfSize:UI(16)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.myHeight = UI(50);
    lable.myWidth = MyLayoutSize.fill;
    lable.numberOfLines = 4;
    lable.textColor = [UIColor whiteColor];
    [firstTitleView addSubview:lable];
    
    LXBUITap *tap = [LXBUITap new];
    [tap addTarget:self action:@selector(btnClicked:)];
    [firstTitleView addGestureRecognizer:tap];
}

- (void)btnClicked:(LXBUITap *)tap{
    [self destroy];
}

- (void)handleLinkTap:(LXBUITap *)gesture {
    if(gesture.view.tag == 0){
        [ViewHub openWebView:AgreementUrl title:getLocalString(@"user_account_ui_service_btn1")];
        
    }
    
    else if(gesture.view.tag == 1){
        [ViewHub openWebView:PolicyUrl title:getLocalString(@"user_account_ui_service_btn2")];
        
    }
}

@end
