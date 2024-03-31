//
//  SDKMoel.m
//  LXBSDK
//
//  Created by pub on 2024/3/13.
//

#import "SDKModel.h"

static SDKModel * instance;

@implementation SDKModel

- (instancetype)init{
    self = [super init];
    instance = self;
    return self;
}


+(SDKModel *)getInstance{
    if(instance == nil){
        instance = [[SDKModel alloc] init];
    }
    return instance;
}
@end
