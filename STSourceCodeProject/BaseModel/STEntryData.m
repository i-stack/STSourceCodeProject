//
//  STEntryData.m
//  STSourceCodeProject
//
//  Copyright © 2022 qcraft. All rights reserved.
//

#import "STEntryData.h"

@implementation STEntryCell

@end

@implementation STEntrySection

@end

@implementation STEntryData

+ (instancetype)constructDefaultEntryData {
    STEntryData *entry = [[STEntryData alloc]init];
    NSMutableArray<STEntrySection *> *sectionArray = [NSMutableArray array];
    entry.sections = sectionArray;
        
    STEntrySection *section = [[STEntrySection alloc] init];
    section.title = @"OC对象本质";
    NSMutableArray<STEntryCell *> *cellArray = [NSMutableArray array];
    section.cells = cellArray;
    [sectionArray addObject:section];
    
    STEntryCell *cell = [[STEntryCell alloc] init];
    cell.title = @"STObjectEssenceViewController";
    cell.controllerClassName = @"STObjectEssenceViewController";
    [cellArray addObject:cell];
    
    return entry;
}

@end
