//
//  STStudent.h
//  OC对象本质
//
//  Created by song on 2021/11/20.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STPerson.h"

NS_ASSUME_NONNULL_BEGIN

struct STStudent_IMPL {
    struct STPerson_IMPL STPerson_IVARS;
    NSString *__strong _age;
};

@interface STStudent : STPerson {
    NSString *_age;
}

- (void)printStudent;

@end

NS_ASSUME_NONNULL_END
