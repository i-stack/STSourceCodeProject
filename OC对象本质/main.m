//
//  main.m
//  OC对象本质
//
//  Created by song on 2021/7/1.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>
#import "STPerson.h"
#import "STStudent.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        struct NSObject_IMPL {
            Class isa;
        };

        struct Person_IMPL {
            struct NSObject_IMPL NSObject_IVARS;
        };
        
        struct Student_IMPL {
            struct Person_IMPL Person_IVARS;
        };
        
        STStudent *object = [[STStudent alloc]init];
        NSLog(@"%zu", class_getInstanceSize(object.class));
        NSLog(@"%zu", malloc_size((__bridge const void *)(object)));

        struct NSObject_IMPL *impl = (__bridge struct NSObject_IMPL *)object;
        NSLog(@"%@", impl);
    }
    return 0;
}
