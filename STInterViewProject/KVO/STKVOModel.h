//
//  STKVOModel.h
//  STInterViewProject
//
//  Created by song on 2021/3/23.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STKVOModel : NSObject
{
    @public
    int _age;
}
- (void)setAge:(int)age;
@property (nonatomic,weak)id observer;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *address;

@end

NS_ASSUME_NONNULL_END
