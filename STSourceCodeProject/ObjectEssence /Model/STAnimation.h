//
//  STAnimation.h
//  STSourceCodeProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STBaseAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface STAnimation : STBaseAnimation

@property (nonatomic,strong)NSString *name;

+ (void)testClassMethod;

- (void)printName;

- (void)setAddress:(NSString *)address isAtomic:(BOOL)isAtomic;
- (NSString *)getAddressIsAtomic:(BOOL)isAtomic;

@end

NS_ASSUME_NONNULL_END
