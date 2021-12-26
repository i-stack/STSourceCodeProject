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

@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *address;

- (instancetype)initWithName:(NSString *)name address:(NSString *)address;

@end

NS_ASSUME_NONNULL_END
