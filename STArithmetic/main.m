//
//  main.m
//  STArithmetic
//
//  Created by song on 2021/6/22.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STUtls.h"
#import "STSortUtls.h"

void printSortResult(STRandomArrayInfo *randomInfo) {
    printf("排序后:\n");
    for (int i = 0; i < randomInfo -> randomCount; i++) {
        printf("%d\n", randomInfo -> randomArray[i]);
    }
    printf("\n");
}

void testSelectSort(STRandomArrayInfo *randomInfo) {
    selectSort(randomInfo -> randomArray, randomInfo -> randomCount);
//    printSortResult(randomInfo);
}

void testBubbleSort(STRandomArrayInfo *randomInfo) {
    bubbleSort(randomInfo -> randomArray, randomInfo -> randomCount);
//    printSortResult(randomInfo);
}

void testQuickSort(STRandomArrayInfo *randomInfo) {
    quickSort(randomInfo -> randomArray, 0, randomInfo -> randomCount - 1);
//    printSortResult(randomInfo);
}

void testSort(void) {
    int loopCount = 100;
    int totalSuccessCount = 0;
    for (int i = 0; i < loopCount; i++) {
        STRandomArrayInfo *randomInfo = generateRandomNoRepeatArray(0, 10000);
        testQuickSort(randomInfo);
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < randomInfo -> randomCount; i++) {
            array[i] = @(randomInfo -> randomArray[i]);
        }
        NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSNumber *tNumber1 = (NSNumber *)obj1;
            NSNumber *tNumber2 = (NSNumber *)obj2;
            if ([tNumber1 integerValue] < [tNumber2 integerValue]) {
                return NSOrderedAscending;
            }
            return NSOrderedDescending;
        }];
//        testQuickSort(randomInfo);
//        testSelectSort(randomInfo);
        testBubbleSort(randomInfo);
        int compareSuccessCount = 0;
        for (int i = 0; i < randomInfo -> randomCount; i++) {
            if ([newArray[i] intValue] != randomInfo -> randomArray[i]) {
                NSLog(@"sort error: index = %d -- newArray value = %d -- randomInfo value = %d\n", i, [newArray[i] intValue], randomInfo -> randomArray[i]);
                break;
            }
            compareSuccessCount++;
        }
        if (compareSuccessCount == randomInfo -> randomCount) {
            totalSuccessCount++;
        }
    }
    NSLog(@"排序完成结果:\n");
    if (totalSuccessCount == loopCount) {
        NSLog(@"success: totalSuccessCount is same loopCount\n");
    } else {
        NSLog(@"error: totalSuccessCount = %d\n", totalSuccessCount);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testSort();
    }
    return 0;
}
