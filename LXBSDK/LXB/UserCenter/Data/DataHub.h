//
//  DataHub.h
//  LXBSDK
//
//  Created by pub on 2024/2/1.
//

#import <Foundation/Foundation.h>
#import "ResVisitor.h"
NS_ASSUME_NONNULL_BEGIN

@interface DataHub : NSObject
+ (DataHub*)getInstance;
@property(nonatomic, strong) ResVisitor* userModel;

@end

NS_ASSUME_NONNULL_END
