//
//  STMRCModel.m
//  Category
//
//  Created by song on 2021/3/16.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCModel.h"
#import <objc/runtime.h>

@interface STMRCModel()

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
        
    }
    return self;
}

@end
