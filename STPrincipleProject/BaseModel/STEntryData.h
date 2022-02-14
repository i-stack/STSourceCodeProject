//
//  STEntryData.h
//  STPrincipleProject
//
//  Copyright © 2022 qcraft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STEntryCell : NSObject

@property (nonatomic, assign) BOOL disabled;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *controllerClassName;

@end

@interface STEntrySection : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<STEntryCell *> *cells;

@end

@interface STEntryData : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<STEntrySection *> *sections;

+ (instancetype)constructDefaultEntryData;


@end

NS_ASSUME_NONNULL_END
