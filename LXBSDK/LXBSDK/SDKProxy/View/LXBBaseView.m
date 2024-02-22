//
//  LXBBaseView.m
//  LXBSDK
//
//  Created by pub on 2024/2/21.
//

#import "LXBBaseView.h"

@implementation LXBBaseView

- (instancetype)init{
    self = [super init];
    [self innerInit];
    return self;
}

- (void)destroy{
    [self removeFromSuperview];
}

- (void)innerInit{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlerCloseAll:) name:CloseAllViewNotiName object:nil];
}

- (void)onDestroy{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc{
    [self onDestroy];
}

- (void)handlerCloseAll:(NSNotification *)noti{
    [self destroy];
}

@end
