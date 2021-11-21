//
//  STSortUtls.h
//  STArithmetic
//
//  Created by song on 2021/10/28.
//  Copyright © 2021 Knowin. All rights reserved.
//

#ifndef STSortUtls_h
#define STSortUtls_h

#include <stdio.h>

void insertSort(int *nums, int numsSize);
void bubbleSort(int *nums, int numsSize);
void selectSort(int *nums, int numsSize);
void countingSort(int *nums, int numsSize);
void quickSort(int *nums, int begin, int end);
int binarySearch(int *nums, int numsSize, int target);
int* binarySearchRange(int *nums, int numsSize, int target);
int findBinarySearchFirstPosition(int* nums, int numsSize, int target);
int findBinarySearchLastPosition(int* nums, int numsSize, int target);

#endif /* STSortUtls_h */
