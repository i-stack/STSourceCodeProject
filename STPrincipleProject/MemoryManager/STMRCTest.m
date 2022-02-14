//
//  STMRCTest.m
//  STPrincipleProject
//
//  Created by song on 2021/3/26.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STMRCTest.h"
#import "STMRCModel.h"
#import "STMRCArray.h"

@interface STMRCTest ()

@end

@implementation STMRCTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)testCustomCopy {
    STMRCModel *model1 = [[STMRCModel alloc]initWithName:@"张三" address:@"北京"];
    NSLog(@"%p -- %p -- %p", model1, model1.copy, model1.mutableCopy);
    [self testKeyedArchiver];
}

- (void)testCopyItem {
    NSString *name = @"张三";
    NSMutableString *address = [NSMutableString stringWithString:@"北京"];
    NSLog(@"变量地址：%p -- %p", name, address);
    
//    NSArray *array = @[name, address];
//    NSArray *copyArray = [array copy];
//    NSMutableArray *mutableCopy = [array mutableCopy];
//    NSMutableArray *copyItemArray = [[NSMutableArray alloc]initWithArray:array copyItems:YES];
//    NSLog(@"%p -- %p -- %p -- %p", array, copyArray, mutableCopy, copyItemArray);
//    NSLog(@"%p -- %p", array[0], array[1]);
//    NSLog(@"%p -- %p", copyArray[0], copyArray[1]);
//    NSLog(@"%p -- %p", mutableCopy[0], mutableCopy[1]);
//    NSLog(@"%p -- %p", copyItemArray[0], copyItemArray[1]);
    
    // name: 0x108d3fd60 -- address: 0x6040000029d0
    NSArray *array = @[@[name, address]];
    NSMutableArray *copyItemArray = [[NSMutableArray alloc]initWithArray:array copyItems:YES];
    // array: 0x602000001430 -- copyItemArray: 0x604000002490
    NSLog(@"%p -- %p", array, copyItemArray);
    // name: 0x108d3fd60 -- address: 0x6040000029d0
    NSLog(@"%p -- %p", array[0][0], array[0][1]);
    // name: 0x108d3fd60 -- address: 0x6040000029d0
    NSLog(@"%p -- %p", copyItemArray[0][0], copyItemArray[0][1]);
}

- (void)testKeyedArchiver {
    NSString *name = @"张三";
    NSMutableString *address = [NSMutableString stringWithString:@"北京"];
    NSLog(@"变量地址：%p -- %p", name, address);
    NSArray *array = [NSArray arrayWithObject:[NSArray arrayWithObjects:name, address, nil]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    NSArray *archiverArray = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class] fromData:data error:nil];
    NSLog(@"%p -- %p", array[0][0], array[0][1]);
    // name: 0x108d3fd60 -- address: 0x6040000029d0
    NSLog(@"%p -- %p", archiverArray[0][0], archiverArray[0][1]);
}


+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
