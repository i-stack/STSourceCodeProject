//
//  main.m
//  STObjcBuild
//
//  Created by qcraft on 2022/3/9.
//  Copyright © 2022 qcraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

struct NSObject_IMP {
    Class isa;
};

struct STAnimation_IMP {
    struct NSObject_IMP imp;
    NSString *_name;
};

@interface STAnimation : NSObject

@property (nonatomic,strong)NSString *name;

- (void)printName;

@end

@implementation STAnimation

- (void)printName {
    NSLog(@"%s", __func__);
}

@end

extern void _objc_autoreleasePoolPrint(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        for (int i = 0; i < 5; i++) {
             NSObject *objc = [[[NSObject alloc] init]autorelease];
        }
        _objc_autoreleasePoolPrint();

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            @autoreleasepool {
                for (int i = 0; i < 10; i++) {
                     NSObject *objc = [[[NSObject alloc] init]autorelease];
                }
                _objc_autoreleasePoolPrint();
            }
        });
        
//        _objc_autoreleasePoolPrint();
    }
    _objc_autoreleasePoolPrint();
    return 0;
}
