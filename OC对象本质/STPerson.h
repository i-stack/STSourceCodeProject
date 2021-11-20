//
//  STPerson.h
//  OC对象本质
//
//  Created by song on 2021/11/20.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct NSObject_IMPL {
    Class isa;
};

struct STPerson_IMPL {
    struct NSObject_IMPL NSObject_IVARS;
    NSString *__strong _name;
};

@interface STPerson : NSObject {
    NSString *_name;
}

- (void)printPerson;

@end

NS_ASSUME_NONNULL_END
