//
//  ServiceAndPolicyView.m
//  LXBSDK
//
//  Created by pub on 2024/2/20.
//

#import "ServiceAndPolicyView.h"

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
    lable.font = [UIFont systemFontOfSize:UI(16)];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.myHeight = UI(80);
    lable.myWidth = MyLayoutSize.fill;
    lable.numberOfLines = 4;
    [firstTitleView addSubview:lable];
}

- (void)initLinkedBtn{
    MyLinearLayout *firstTitleView = [[MyLinearLayout alloc] init];
    firstTitleView.myWidth = MyLayoutSize.fill;
    firstTitleView.myHeight = UI(150);
    [self.contentView addSubview:firstTitleView];
    
    _serviceLabel = [[UILabel alloc] init];
    _serviceLabel.tag = 1;
    // 创建 NSMutableAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:getLocalString(@"user_account_ui_service_btn1")];
    // 添加下划线
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attributedString.length)];
    // 添加链接属性
    [attributedString addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"https://yourlink.com"] range:NSMakeRange(0, attributedString.length)];
    // 将 NSAttributedString 设置为 UILabel 的 attributedText
    _serviceLabel.attributedText = attributedString;
    _serviceLabel.font = [UIFont systemFontOfSize:UI(16)];
    [_serviceLabel sizeToFit];
    // 设置 UILabel 可以与用户交互
    _serviceLabel.userInteractionEnabled = YES;
    // 添加手势识别器，处理链接点击
    LXBUITap *tapGesture = [[LXBUITap alloc] initWithTarget:self action:@selector(handleLinkTap:)];
    [_serviceLabel addGestureRecognizer:tapGesture];
    [firstTitleView addSubview:_serviceLabel];
    
    
    
    _policyLabel = [[UILabel alloc] init];
    _policyLabel.tag = 2;
}

- (void)initBackView{
    MyLinearLayout *firstTitleView = [[MyLinearLayout alloc] init];
    firstTitleView.myWidth = MyLayoutSize.fill;
    firstTitleView.myHeight = UI(50);
    firstTitleView.layer.cornerRadius = UI(6);
    firstTitleView.backgroundColor = [LXBHelper mainColor];
    [self.contentView addSubview:firstTitleView];
    
    UILabel *lable = [UILabel new];
    
    lable.text = getLocalString(@"user_account_ui_service_backbtn");
    lable.font = [UIFont boldSystemFontOfSize:UI(16)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.myHeight = UI(50);
    lable.myWidth = MyLayoutSize.fill;
    lable.numberOfLines = 4;
    [firstTitleView addSubview:lable];
    
    LXBUITap *tap = [LXBUITap new];
    [tap addTarget:self action:@selector(btnClicked:)];
    [firstTitleView addGestureRecognizer:tap];
}

- (void)btnClicked:(LXBUITap *)tap{
    [self destroy];
}

- (void)handleLinkTap:(LXBUITap *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if(gesture.view.tag == 1){
            NSURL *url = [self.serviceLabel.attributedText attribute:NSLinkAttributeName atIndex:0 effectiveRange:NULL];
            if (url) {
                // 在这里处理链接点击，可以打开链接或执行其他操作
                NSLog(@"Link tapped: %@", url);
            }
        }
        
        else if(gesture.view.tag == 2){
            NSURL *url = [self.serviceLabel.attributedText attribute:NSLinkAttributeName atIndex:0 effectiveRange:NULL];
            if (url) {
                // 在这里处理链接点击，可以打开链接或执行其他操作
                NSLog(@"Link tapped: %@", url);
            }
        }
        
    }
}

@end
