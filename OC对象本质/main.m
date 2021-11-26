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

extern _objc_autoreleasePoolPrint(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        _objc_autoreleasePoolPrint();
        @autoreleasepool {
            for (int i = 0; i < 10; i++) {
                STPerson *model = [[[STPerson alloc]init]autorelease];
            }
            _objc_autoreleasePoolPrint();
        }
        _objc_autoreleasePoolPrint();
        
        @autoreleasepool {
            for (int i = 0; i < 2; i++) {
                STStudent *model = [[[STStudent alloc]init]autorelease];
            }
            _objc_autoreleasePoolPrint();
        }
        _objc_autoreleasePoolPrint();
        
        @autoreleasepool {
            for (int i = 0; i < 4; i++) {
                STPerson *model = [[[STPerson alloc]init]autorelease];
            }
            _objc_autoreleasePoolPrint();
        }
    }
    _objc_autoreleasePoolPrint();
    return 0;
}
