//
//  main.m
//  STObjcBuild
//
//  Created by qcraft on 2022/3/9.
//  Copyright © 2022 qcraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

//struct NSObject_IMP {
//    Class isa;
//};
//
//struct STAnimation_IMP {
//    struct NSObject_IMP imp;
//    NSString *_name;
//};

#define _ISA_MASK 0x0000000ffffffff8

@interface STAnimation : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *address;

- (void)printName;
- (void)printAddress;

@end

@implementation STAnimation

- (void)printName {
    NSLog(@"%s", __func__);
}

- (void)printAddress {
    
}

@end

@interface STPerson : STAnimation

@property (nonatomic,strong)NSString *age;

- (void)printAge;

@end

@implementation STPerson

- (void)printAge {
    NSLog(@"%s", __func__);
}

@end

extern void _objc_autoreleasePoolPrint(void);

struct st_objc_class {
    Class isa;
    Class superClass;
};

int main(int argc, const char * argv[]) {
    NSMutableArray *array = [NSMutableArray new];
    @autoreleasepool {
//        for (int i = 0; i < 1000; i++) {
//            STPerson *person = [[[STPerson alloc]init]autorelease];
////            [array addObject:person];
////            _objc_autoreleasePoolPrint();
//        }
//        _objc_autoreleasePoolPrint();
//
//        @autoreleasepool {
//            for (int i = 0; i < 15; i++) {
//                STPerson *person = [[[STPerson alloc]init]autorelease];
//                _objc_autoreleasePoolPrint();
//            }
//            _objc_autoreleasePoolPrint();
//
//            @autoreleasepool {
//                for (int i = 0; i < 20; i++) {
//                    STPerson *person = [[[STPerson alloc]init]autorelease];
//                    _objc_autoreleasePoolPrint();
//                }
//                _objc_autoreleasePoolPrint();
//            }
//            _objc_autoreleasePoolPrint();
//        }
//        _objc_autoreleasePoolPrint();
    }
    _objc_autoreleasePoolPrint();
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    for (int i = 0; i < 1000; i++) {
        STPerson *person = [[[STPerson alloc]init]autorelease];
    }
    _objc_autoreleasePoolPrint();
    [pool drain];
    _objc_autoreleasePoolPrint();
    return 0;
}
