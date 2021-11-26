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

extern void _objc_autoreleasePoolPrint(void);

@interface STMRCTest ()

@end

@implementation STMRCTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self testRefCount];
    }
    return self;
}

- (void)testRefCount {
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
//    STMRCModel *model = [[STMRCModel alloc]init];//[[[STMRCModel alloc]init]autorelease];
//    [pool addObject:model];
//    [pool drain];
    
//    _objc_autoreleasePoolPrint();
    @autoreleasepool {
        for (int i = 0; i < 10; i++) {
            STMRCModel *model = [[[STMRCModel alloc]init]autorelease];
        }
        _objc_autoreleasePoolPrint();
        @autoreleasepool {
            for (int i = 0; i < 2; i++) {
                STMRCModel *model = [[[STMRCModel alloc]init]autorelease];
            }
        }
//        _objc_autoreleasePoolPrint();
        @autoreleasepool {
            for (int i = 0; i < 4; i++) {
                STMRCModel *model = [[[STMRCModel alloc]init]autorelease];
            }
        }
//        _objc_autoreleasePoolPrint();
    }
//    _objc_autoreleasePoolPrint();
}

@end
