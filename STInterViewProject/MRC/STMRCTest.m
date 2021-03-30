//
//  STMRCTest.m
//  STInterViewProject
//
//  Created by song on 2021/3/26.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCTest.h"
#import "STMRCModel.h"

@implementation STMRCTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"111");
//        @autoreleasepool {
//            STMRCModel *model = [[[STMRCModel alloc]init]autorelease];
//        }
        STMRCModel *model = [[[STMRCModel alloc]init]autorelease];
        NSLog(@"222");
    }
    return self;
}

@end
