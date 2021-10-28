//
//  STAnimation+STPerson.h
//  STInterViewProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface STAnimation (STPerson)

@property (nonatomic, strong)NSString *name;

- (void)printName;
+ (void)printAge;

@end

NS_ASSUME_NONNULL_END
