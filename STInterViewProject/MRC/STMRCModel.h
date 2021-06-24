//
//  STMRCModel.h
//  Category
//
//  Created by song on 2021/3/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface STMRCModel : STMRCBaseModel

@property (nonatomic,assign)NSInteger age;
@property (nonatomic,strong)NSString *queueName;

- (void)printQueueName;
- (void)instanceMethod;
+ (void)classMethod;
- (void)test;

@end

NS_ASSUME_NONNULL_END
