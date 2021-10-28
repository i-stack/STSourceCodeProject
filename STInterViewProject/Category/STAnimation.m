//
//  STAnimation.m
//  STInterViewProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STAnimation.h"
#import "STAnimation+STPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation STAnimation

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (void)load
{
    NSLog(@"%s", __func__);
}

//+ (void)initialize
//{
//    NSLog(@"%s", __func__);
//}

- (void)printName
{
    NSLog(@"%s", __func__);
}

typedef struct cache_t {
    
}cache_t;

typedef struct class_data_bits_t {
    
}class_data_bits_t;

struct objc_class {
    Class ISA;
    Class superclass;
    cache_t cache;             // formerly cache pointer and vtable
    class_data_bits_t bits;    // class_rw_t * plus custom rr/alloc flags
};



@end
