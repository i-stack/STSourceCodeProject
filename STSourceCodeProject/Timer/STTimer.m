//
//  STTimer.m
//  STSourceCodeProject
//
//  Created by song on 2021/3/19.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STTimer.h"

@implementation STTimer

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//
//    }
//    return self;
//}
//
//- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer * _Nonnull))block
//{
//    if (self = [super initWithFireDate:date interval:interval repeats:repeats block:block]) {
//
//    }
//    return self;
//}

//+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
//    return [super scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
//}

- (void)dealloc
{
    NSLog(@"%@-%s", NSStringFromClass(self.class), __func__);
}

@end
