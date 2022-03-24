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
        NSLog(@"%@", [self class]);
        NSLog(@"%@", [super class]);
        
        
        
        for (int i = 0; i < 2; i++) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                self.name = [NSString stringWithFormat:@"1234567890"];
                self.name = @"1";
                NSLog(@"%p", self.name);
            });
        }
        NSString *s = @"123";
        NSMutableString *str = [s mutableCopy];
        [str appendString:@"234"];
        NSLog(@"%@", str);
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            for (int i = 0; i < 100; i++) {
//                self.name = @"345";
//            }
//        });
    }
    return self;
}

- (void)setName:(NSString *)name {
    @synchronized (self) {
        if (_name != name) {
            [_name release];
            _name = [name retain];
        }
    }
}

- (void)printName
{
    NSLog(@"%s-%@", __func__, self.name);
}

//- (void)setAddress:(NSString *)address isAtomic:(BOOL)isAtomic {
//    if (isAtomic) {
//        _address = address;
//    } else {
//
//    }
//}
//
//- (NSString *)getAddressIsAtomic:(BOOL)isAtomic {
//
//}

@end
