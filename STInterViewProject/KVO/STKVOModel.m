//
//  STKVOModel.m
//  STInterViewProject
//
//  Created by song on 2021/3/23.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STKVOModel.h"

@implementation STKVOModel

//+ (BOOL)automaticallyNotifiesObserversOfName {
//    return NO;
//}
//
- (void)setName:(NSString *)name {
//    [self willChangeValueForKey:@"name"];
    _name = name;
//    [self didChangeValueForKey:@"name"];
    NSLog(@"setName");
}

- (void)willChangeValueForKey:(NSString *)key
{
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey");
}

- (void)didChangeValueForKey:(NSString *)key
{
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey");
}
@end
