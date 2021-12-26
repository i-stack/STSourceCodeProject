//
//  STFileManager.h
//  STAlgorithmProject
//
//  Created by song on 2021/11/13.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STFileManager : NSObject

+ (NSString *)homePath;
+ (void)testUserDefault;
+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
