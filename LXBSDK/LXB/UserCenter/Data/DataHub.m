//
//  DataHub.m
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import "DataHub.h"

static DataHub* instance;
@implementation DataHub

+ (DataHub *)getInstance{
    if(instance == nil){
        instance = [[DataHub alloc] init];
    }
    return instance;
}

@end
