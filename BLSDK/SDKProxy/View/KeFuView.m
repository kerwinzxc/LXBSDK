//
//  KeFuView.m
//  LXBSDK
//
//  Created by pub on 2024/2/22.
//

#import "KeFuView.h"

@implementation KeFuView

- (void)initViews{
    [super initViews];
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    [self initDesView];
}

- (void)initDesView{
   
}


- (void)setDes:(NSString *)des{
    MyLinearLayout *lin = [[MyLinearLayout alloc] initWithOrientation:MyOrientation_Vert];
    //lin.backgroundColor = [UIColor redColor];
    lin.myHeight = MyLayoutSize.fill;
    lin.myWidth = MyLayoutSize.fill;
    [self.contentView addSubview:lin];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = des;
    label.font = [UIFont boldSystemFontOfSize:UI(16)];
    label.textColor = [LXBHelper normalTextColor];
    label.myWidth = MyLayoutSize.fill;
    label.myHeight = MyLayoutSize.wrap;
    label.textAlignment = NSTextAlignmentLeft;
    //[label sizeToFit];
    
    label.numberOfLines = 15;;
    [lin addSubview:label];
}

@end
