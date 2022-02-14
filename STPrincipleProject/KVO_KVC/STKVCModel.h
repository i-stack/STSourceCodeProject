//
//  STKVCModel.h
//  STPrincipleProject
//
//  Created by song on 2021/3/19.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STKVCModel : NSObject
{
    int _weigth;
    int age;
    int isAge;
    int _age;
    int _isAge;
}

//@property (nonatomic,assign)int age;

@property (nonatomic,strong)NSString *name;

@end

NS_ASSUME_NONNULL_END
