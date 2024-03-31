//
//  DeleteWarperView.m
//  LXBSDK
//
//  Created by pub on 2024/2/20.
//

#import "DeleteWarperView.h"
#import "DeleteAccConfirmView.h"
@implementation DeleteWarperView

- (void)initViews{
    [super initViews];
    
    [self initDes];
    
    [self initDeleteBtn];
}

- (void)initDes{
    MyLinearLayout *textWarper = [[MyLinearLayout alloc] init];
    textWarper.myHeight = UI(150);
    textWarper.myWidth = MyLayoutSize.fill;
    //textWarper.backgroundColor = [UIColor greenColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = getLocalString(@"u8_account_cutacc_delete_warper_des");
    label.font = [UIFont systemFontOfSize:UI(16)];
    label.numberOfLines = 0;
    label.textColor = [UIColor grayColor];
    label.myWidth = MyLayoutSize.fill;
    //label.myHeight = MyLayoutSize.fill;
    label.myHeight = MyLayoutSize.wrap;
    [label sizeToFit];
    
    [textWarper addSubview:label];
    [self.contentView addSubview:textWarper];
}

- (void)initDeleteBtn{
    MyLinearLayout *btnView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
    btnView.myHeight = UI(50);
    btnView.backgroundColor = [LXBHelper mainColor];
    btnView.layer.cornerRadius = UI(6);
    btnView.subviewHSpace = UI(10);
    btnView.myWidth = MyLayoutSize.fill;
    btnView.gravity = MyGravity_Center;
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [LXBHelper imageWithName:@"HelpPic"];
    imgView.myHeight = UI(24);
    imgView.myWidth = UI(24);
    [btnView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = getLocalString(@"u8_account_cutacc_delete_warper_title");
    label.font = [UIFont boldSystemFontOfSize:UI(16)];
    [label sizeToFit];
    
    [btnView addSubview:label];
    [self.contentView addSubview:btnView];
    
    LXBUITap *tap = [[LXBUITap alloc] init];
    [tap addTarget:self action:@selector(btnClick:)];
    [btnView addGestureRecognizer:tap];
}

- (void)btnClick:(LXBUITap *)send{
    DeleteAccConfirmView *view = [[DeleteAccConfirmView alloc] init];

    [[self getRootWindow] addSubview:view];
}

@end
