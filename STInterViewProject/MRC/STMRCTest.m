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
    //    NSString *s = @"Testing567";
    //    NSLog(@"%@", [s substringToIndex:5]);
    //    NSLog(@"%@", [s substringWithRange:NSMakeRange(2, 5)]);
        
    NSMutableArray* ary = [[NSMutableArray array] retain];
    NSString *str = [[NSString alloc]initWithString:@"test"];//[NSString stringWithFormat:@"test"];
    NSLog(@"---%ld--%@",CFGetRetainCount((__bridge CFTypeRef)(str)), str);//1
    [str retain];
    [ary addObject:str];
    NSLog(@"---%ld--%@",CFGetRetainCount((__bridge CFTypeRef)(str)), str);//1
    [str retain];
    [str release];
    [str release];
    NSLog(@"---%ld--%@",CFGetRetainCount((__bridge CFTypeRef)(str)), str);//1
    [ary removeAllObjects];
    NSLog(@"---%ld--%@",CFGetRetainCount((__bridge CFTypeRef)(str)), str);//1
}

@end
