//
//  NSObject+STRuntime.h
//  STInterViewProject
//
//  Created by song on 2021/11/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (STRuntime)

- (void)printIvarList:(Class)cls;

+ (instancetype)st_jsonToModel:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
