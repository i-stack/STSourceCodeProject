//
//  NSObject+STRuntime.m
//  STAlgorithmProject
//
//  Created by song on 2021/11/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "NSObject+STRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (STRuntime)

+ (instancetype)st_jsonToModel:(NSDictionary *)json {
    id obj = [[self alloc]init];
    if (json.count < 1) {
        return obj;
    }
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([obj class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        if ([json valueForKey:propertyName]) {
            [obj setValue:json[propertyName] forKey:propertyName];
        }
    }
    return obj;
}

- (void)printIvarList:(Class)cls {
    unsigned int count;
    Ivar *valList = class_copyIvarList(cls, &count);
    for (int i = 0; i < count; i++) {
        Ivar var = valList[i];
        NSLog(@"%s - %s", ivar_getName(var), ivar_getTypeEncoding(var));
    }
}

@end
