//
//  STFileManager.m
//  STInterViewProject
//
//  Created by song on 2021/11/13.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STFileManager.h"

@implementation STFileManager

+ (instancetype)sharedInstance {
    static STFileManager *ins = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ins = [[super allocWithZone:nil] init];
    });
    return ins;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[self class] sharedInstance];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [[self class] sharedInstance];
}

- (instancetype)retain {
    return [[self class] sharedInstance];
}

//- (oneway void)release {
//    return;
//}

+ (NSString *)homePath {
    return NSHomeDirectory();
}

+ (NSArray *)libraryPath {
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, true);
}

+ (NSArray *)documentPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
}

+ (void)testUserDefault {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@"case" forKey:@"111"];
}

@end
