//
//  STAnimation+STDog.m
//  STInterViewProject
//
//  Created by song on 2020/8/20.
//  Copyright © 2020 Knowin. All rights reserved.
//

#import "STAnimation+STDog.h"

@implementation STAnimation (STDog)

+ (void)load
{
    NSLog(@"STAnimation+STDog.load");
}

+ (void)initialize
{
    NSLog(@"STAnimation+STDog.initialize");
}

- (void)printName
{
    NSLog(@"STAnimation+STDog.printName");
}

- (void)setName:(NSString *)name {
    
}

- (NSString *)name {
    return self.name;
}

@end
