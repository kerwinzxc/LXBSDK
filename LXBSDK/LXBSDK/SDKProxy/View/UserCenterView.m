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
@implementation UserCenterView

- (instancetype)init{
    self = [super init];
    return self;
}

- (void)initViews{
    [super initViews];
    
    [self.contentView addSubview:self.uidView];
    [self.contentView addSubview:self.bindAccountBtn];
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



- (MyLinearLayout *)bindAccountBtn{
    if (_bindAccountBtn == nil) {
        _bindAccountBtn = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Horz];
        _bindAccountBtn.backgroundColor = [UIColor whiteColor];
        _bindAccountBtn.myWidth = UI(370);
        _bindAccountBtn.myHeight = UI(50);
        _bindAccountBtn.gravity =  MyGravity_Vert_Center;
        
        UIImage *img = [LXBHelper imageWithName:@"UserBind"];
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.image = img;
        iconView.myHeight = UI(44);
        iconView.myWidth = UI(44);
        iconView.leftPos.equalTo(_bindAccountBtn.leftPos).offset(UI(10));
        [_bindAccountBtn addSubview:iconView];
        _bindAccountBtn.layer.cornerRadius = UI(4);
        
        UILabel *txtLable = [UILabel new];
        txtLable.text = @"绑定账户";
        txtLable.font = [UIFont systemFontOfSize:UI(18)];
        txtLable.textColor = [UIColor blackColor];
        [txtLable sizeToFit];
        txtLable.leftPos.equalTo(iconView.rightPos).offset(10);
        
        [_bindAccountBtn addSubview:txtLable];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(bindBtnClick)];
        [_bindAccountBtn addGestureRecognizer:tap];
        
        
        MyLinearLayout *JianTouParent = [[MyLinearLayout alloc] init];
        JianTouParent.myHeight = MyLayoutSize.fill;
        JianTouParent.weight = 1;
        JianTouParent.backgroundColor = [UIColor clearColor];
        JianTouParent.gravity = MyGravity_Vert_Center;
        
        [_bindAccountBtn addSubview:JianTouParent];
        
        UIImageView *jiantou = [[UIImageView alloc] init];
        jiantou.image = [LXBHelper imageWithName:@"PicArrow"];
        jiantou.myWidth = UI(20);
        jiantou.myHeight = UI(20);
        jiantou.rightPos.equalTo(_bindAccountBtn.rightPos).offset(16);
        [JianTouParent addSubview:jiantou];
        
    }
    return _bindAccountBtn;
}

- (void)bindBtnClick{
    BindAccView *bindView = [[BindAccView alloc] initTitle:@"bindg" isRightCloseBtn:NO];

    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:bindView];
}



@end
