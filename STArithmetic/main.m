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

void testCountingSort(STRandomArrayInfo *randomInfo) {
    countingSort(randomInfo -> randomArray, randomInfo -> randomCount);
//    printSortResult(randomInfo);
}

void testSort(void) {
    NSLog(@"开始排序:\n");
    int loopCount = 900;
    int totalSuccessCount = 0;
    for (int i = 0; i < loopCount; i++) {
        STRandomArrayInfo *randomInfo = generateRandomArray(1500, 2000);//generateRandomNoRepeatArray(0, 10000);
        NSMutableArray *array = [NSMutableArray array];
        for (int k = 0; k < randomInfo -> randomCount; k++) {
            array[k] = @(randomInfo -> randomArray[k]);
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
//        testBubbleSort(randomInfo);
        testCountingSort(randomInfo);
        int compareSuccessCount = 0;
        for (int k = 0; k < randomInfo -> randomCount; k++) {
            if ([newArray[k] intValue] != randomInfo -> randomArray[k]) {
                NSLog(@"sort error: index = %d -- newArray value = %d -- randomInfo value = %d\n", k, [newArray[k] intValue], randomInfo -> randomArray[k]);
                break;
            }
            compareSuccessCount++;
        }
        if (compareSuccessCount == randomInfo -> randomCount) {
            totalSuccessCount++;
        }
    }
    NSLog(@"排序完成:\n");
    if (totalSuccessCount == loopCount) {
        NSLog(@"success: totalSuccessCount is same loopCount = %d次", loopCount);
    } else {
        NSLog(@"error: totalSuccessCount = %d次", totalSuccessCount);
    }
}

void merge(int* A, int ALen, int m, int* B, int BLen, int n) {
    if (ALen != m + n) return;
    if (BLen < 1 || ALen < 1) return;
    int i = m - 1;
    int j = n - 1;
    int k = m + n - 1;
    while (i >= 0 && j >= 0) {
        if (A[i] >= B[j]) {
            A[k--] = A[i--];
        } else {
            A[k--] = B[j--];
        }
    }
    while (i >= 0) {
        A[k--] = A[i--];
    }
    while (j >= 0) {
        A[k--] = B[j--];
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testSort();
        int num1[6] = {1, 2, 3, 0, 0, 0};
        int num2[3] = {2, 5, 7};
        int *p1 = num1;
        int *p2 = num2;
        merge(p1, 6, 3, p2, 3, 3);
    }
    return 0;
}
