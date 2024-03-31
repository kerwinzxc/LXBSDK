//
//  LXBUITap.m
//  LXBSDK
//
//  Created by pub on 2024/2/21.
//

#import "LXBUITap.h"

@interface LXBUITap ()<UIGestureRecognizerDelegate>

@end

@implementation LXBUITap



- (instancetype)init{
    self = [super init];
    [self inerInit];
    return self;
}

- (void)inerInit{
    self.delegate = self;
    self.lastTapTime = [[NSDate date] timeIntervalSince1970] *1000;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    NSTimeInterval millisec = [[NSDate date] timeIntervalSince1970] *1000;
    BOOL re = NO;
    if(millisec - self.lastTapTime > 300){
        re = YES;
    }
    self.lastTapTime = millisec;
    return re;
}


@end
