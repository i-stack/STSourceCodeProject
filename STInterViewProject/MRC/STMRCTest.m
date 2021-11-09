//
//  STMRCTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/26.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCTest.h"
#import "STMRCModel.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import <objc/message.h>

@interface STMRCTest ()

@end

@implementation STMRCTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        STMRCModel *model = [[STMRCModel alloc]init];
    }
    return self;
}

- (void)testCopy {
    
}

@end
