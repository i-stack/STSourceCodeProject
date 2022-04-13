//
//  STAnimation.m
//  STSourceCodeProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STAnimation.h"
#import "STAnimation+STPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface STAnimation() {
    NSString *_address;
}

@end

@implementation STAnimation

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)testClassMethod {
    NSLog(@"%s", __func__);
}


@end
