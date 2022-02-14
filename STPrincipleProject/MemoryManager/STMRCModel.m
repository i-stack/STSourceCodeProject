//
//  STMRCModel.m
//  Category
//
//  Created by song on 2021/3/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCModel.h"

@interface STMRCModel()<NSCopying, NSMutableCopying>

@end

@implementation STMRCModel

- (void)dealloc {
    [super dealloc];
    NSLog(@"%s", __func__);
}

- (instancetype)initWithName:(NSString *)name address:(NSString *)address
{
    self = [super init];
    if (self) {
        _name = name;
        _address = address;
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    STMRCModel *model = [[STMRCModel alloc]init];
    model.name = _name;
    model.address = _address;
    return model;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    STMRCModel *model = [[STMRCModel alloc]init];
    model.name = _name;
    model.address = _address;
    return model;
}

- (void)copyObj {
    NSString *str = @"123";
    // copy: 0x10230fd80 -- 0x10230fd80 指向同一内存空间
    NSLog(@"非集合不可变类型 copy: %p -- %p", str, str.copy);
    // mutableCopy: 0x10230fd80 -- 0x604000169950 指向两块不同的内存空间
    NSLog(@"非集合不可变类型 mutableCopy: %p -- %p", str, str.mutableCopy);

    NSMutableString *muStr = [NSMutableString stringWithString:@"abc"];
    // copy: 0x604000169ed0 -- 0xa0c528bc18daeaaa 指向两块不同的内存空间
    NSLog(@"非集合可变类型 copy: %p -- %p", muStr, muStr.copy);
    // mutableCopy: 0x604000169ed0 -- 0x60400016a450 指向两块不同的内存空间
    NSLog(@"非集合可变类型 mutableCopy: %p -- %p", muStr, muStr.mutableCopy);
}

@end

