//
//  STMRCModel.m
//  Category
//
//  Created by song on 2021/3/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCModel.h"

@interface STMRCModel()

@property (nonatomic,assign)NSInteger age;
@property (nonatomic,strong)NSString *queueName;

@end

@implementation STMRCModel

- (void)dealloc {
    [super dealloc];
    NSLog(@"%s", __func__);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *str1 = @"123";
        NSLog(@"%lu - %p", (unsigned long)str1.retainCount, str1);
        NSString *str2 = [str1 copy];
        NSLog(@"%lu - %p", (unsigned long)str1.retainCount, str2);
        NSMutableString *str3 = [str1 mutableCopy];
        NSLog(@"%lu - %p", (unsigned long)str1.retainCount, str3);
    }
    return self;
}



@end
