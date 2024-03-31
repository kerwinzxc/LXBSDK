//
//  BaseView.m
//  LXBSDK
//
//  Created by xiaolong on 2024/2/12.
//

#import "LXBLogicView.h"

@interface LXBLogicView ()
@property(nonatomic, strong)NSString *titleString;
@property(nonatomic, assign)int closeType;
@end


@implementation LXBLogicView



- (instancetype)init{
    self = [super init];
    [self initViews];
    
    [self initDatum];
    
    [self initListeners];
    return self;
}


- (instancetype)initTitle:(NSString *)title isRightCloseBtn:(int)closeType{
    self = [super init];
    
    self.titleString = title;
    self.closeType = closeType;
    
    [self initViews];
    
    [self initDatum];
    
    [self initListeners];
    return self;
}


- (void)initDatum{
    
}

- (void)initListeners{
    
}

- (void)initViews{
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
    [_rootContainer addSubview:self.bgView];
    [_rootContainer addSubview:self.contentView];
    [self.contentView addSubview:self.titleView];
    _contentView.padding = UIEdgeInsetsMake(0, UI(8), 0, UI(8));
}

- (MyFrameLayout *)titleView{
    if (_titleView == nil) {
        
        _titleView = [[MyFrameLayout alloc] init];
        _titleView.myWidth = MyLayoutSize.fill;
        _titleView.myHeight = UI(40);
        _titleView.topPos.equalTo(self.contentView.topPos).offset(UI(10));
        UILabel *titleLable = [UILabel new];
        //titleLable.text = getLocalString(@"user_account_ui_usercenter");
        titleLable.text = self.titleString;
        titleLable.myWidth = MyLayoutSize.wrap;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.myHeight = MyLayoutSize.wrap;
        titleLable.font = [UIFont boldSystemFontOfSize:UI(20)];
        titleLable.textColor = [UIColor blackColor];
        titleLable.myCenterY = 0;
        titleLable.myCenterX = 0;
        [_titleView addSubview:titleLable];
        
        UIImageView *closeBtn = [[UIImageView alloc] init];
        [closeBtn setUserInteractionEnabled:YES];
        closeBtn.myHeight = UI(28);
        closeBtn.myWidth = UI(28);
        closeBtn.myCenterY = 0;
        
        LXBUITap *tap = [[LXBUITap alloc]init];
        [tap addTarget:self action:@selector(closeBtnClick)];
        [closeBtn addGestureRecognizer:tap];
        if(self.closeType == RightClose){
            //UIView *closeBtn = [[UIView alloc] init];
            closeBtn.image = [LXBHelper imageWithName:@"public_btn_close"];
            closeBtn.rightPos.equalTo(_titleView.rightPos);
            [_titleView addSubview:closeBtn];
        }
        else if(self.closeType == LeftClose){
            closeBtn.image = [LXBHelper imageWithName:@"public_btn_close"];
            closeBtn.leftPos.equalTo(_titleView.leftPos);
            [_titleView addSubview:closeBtn];
        }
        else if (self.closeType == NOClose){
            
        }
        //_titleView.backgroundColor = [UIColor redColor];
    }

    return _titleView;
}


- (UIImageView *)bgView{
    if(_bgView == nil){
        _bgView = [[UIImageView alloc] init];
        //_bgView.image = [LXBHelper imageWithName:@"UcBgView"];
        _bgView.backgroundColor = [LXBHelper bgViewColor];
        _bgView.layer.cornerRadius = UI(20);
        _bgView.myWidth = UI(390);
        _bgView.myHeight = UI(390);
        _bgView.myCenterX = 0;
        _bgView.myCenterY = 0;
    }
    return _bgView;
}


- (MyBaseLayout *)contentView{
    if(_contentView == nil){
        _contentView = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Vert];
        //_contentView.topPos.equalTo(self.bgView.topPos);
        //_contentView.bottomPos.equalTo(self.bgView.bottomPos);
        _contentView.myWidth = UI(360);
        _contentView.myHeight = UI(390);
        _contentView.gravity = MyGravity_Horz_Center;
        _contentView.subviewSpace = UI(10);
    }
    return _contentView;
}

- (void)closeBtnClick{
    [self destroy];
}


@end
