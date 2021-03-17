//
//  STBlock.h
//  STInterViewProject
//
//  Created by song on 2021/1/8.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STBlock : NSObject

- (void)testBlock;
@property (nonatomic,strong) void(^block)(void);

@end

NS_ASSUME_NONNULL_END
