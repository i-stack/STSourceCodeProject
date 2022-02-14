//
//  STPerson.h
//  STPrincipleProject
//
//  Created by song on 2021/11/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STPerson : NSObject

- (void)print;

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,assign)int count;


@end

NS_ASSUME_NONNULL_END
