//
//  UserCenterView.m
//  LXBSDK
//
//  Created by pub on 2024/2/6.
//

#import "UserCenterView.h"
#import "NSString+Handle.h"
#import "U8Language.h"
@implementation UserCenterView

- (instancetype)init{
    self = [super init];
    [self innerInit];
    return self;
}

- (void)innerInit{
    UIScreen *screen = [UIScreen mainScreen];
    self.frame = CGRectMake(0, 0, screen.bounds.size.width, screen.bounds.size.height);
    UIColor *color = [UIColor blackColor];
    self.backgroundColor = [color colorWithAlphaComponent:0.04];
    _rootContainer = [[MyFrameLayout alloc] init];
    _rootContainer.gravity = MyGravity_Center;
    _rootContainer.myCenterX = 0;
    _rootContainer.myCenterY = 0;
    _rootContainer.myHeight = MyLayoutSize.fill;
    _rootContainer.myWidth = MyLayoutSize.fill;
    _rootContainer.backgroundColor = [UIColor clearColor];
    [self addSubview:_rootContainer];
    
    
    
    
    
   
    //_bgView.topPos.equalTo()
    [_rootContainer addSubview:self.bgView];
    [_rootContainer addSubview:self.contentView];
    
    
    [self initTitleView];
    [self initSecView];
}

- (UIImageView *)bgView{
    if(_bgView == nil){
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [LXBHelper imageWithName:@"UcBgView"];
        _bgView.myWidth = UI(390);
        _bgView.myHeight = UI(300);
        _bgView.myCenterX = 0;
        _bgView.myCenterY = 0;
    }
    return _bgView;
}


- (void)initTitleView{
    MyFrameLayout *titleView = [[MyFrameLayout alloc] init];
    titleView.myWidth = MyLayoutSize.fill;
    titleView.myHeight = UI(50);
    UILabel *titleLable = [UILabel new];
    titleLable.text = getLocalString(@"user_account_ui_usercenter");
    titleLable.myWidth = MyLayoutSize.wrap;
    titleLable.myHeight = MyLayoutSize.wrap;
    titleLable.font = [UIFont boldSystemFontOfSize:UI(18)];
    titleLable.textColor = [UIColor blackColor];
    titleLable.myCenterY = 0;
    titleLable.myCenterX = 0;
    [titleView addSubview:titleLable];
    [_contentView addSubview:titleView];
    //[NSString localizedForKey:@"u8_error_data_error"];
}

- (void)initSecView{
    MyLinearLayout *frame = [[MyLinearLayout alloc]initWithOrientation:MyOrientation_Horz];
    frame.myWidth = UI(370);
    frame.myHeight = UI(70);
    frame.backgroundColor = [UIColor blueColor];
    frame.layer.cornerRadius = UI(6);
    frame.gravity = MyGravity_Vert_Center;
    
    UIImageView *iconView = [UIImageView new];
    iconView.myWidth = UI(58);
    iconView.myHeight = UI(58);
    iconView.leftPos.equalTo(frame.leftPos).offset(10);
    iconView.image = [LXBHelper imageWithName:@"HeadPic"];
    [frame addSubview:iconView];
    UILabel *uinLabel = [UILabel new];
    uinLabel.text = @"UID:234567890998777";
   
    uinLabel.font = [UIFont boldSystemFontOfSize:UI(18)];
    uinLabel.textColor = [UIColor blackColor];
    [uinLabel sizeToFit];
    uinLabel.leftPos.equalTo(iconView.rightPos).offset(10);
    
    [frame addSubview:uinLabel];
    
    [_contentView addSubview:frame];
}

- (void)initIconView{
    UIView *view = [[UIView alloc]init];
    view.myWidth = MyLayoutSize.fill;
    view.myHeight = UI(40);
    view.backgroundColor = [UIColor redColor];
    [_bgView addSubview:view];
}


- (MyBaseLayout *)contentView{
    if(_contentView == nil){
        _contentView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Vert];
        _contentView.myWidth = UI(360);
        _contentView.myHeight = UI(300);
        _contentView.gravity = MyGravity_Horz_Center;
    }
    return _contentView;
}
@end
