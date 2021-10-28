//
//  STSortUtls.c
//  STArithmetic
//
//  Created by song on 2021/10/28.
//  Copyright © 2021 Knowin. All rights reserved.
//

#include "STSortUtls.h"
#include "STUtls.h"

/// 快速排序 从小到大
/// @param nums 排序数组
/// @param begin 起始位置
/// @param end 结束位置
void quickSort(int *nums, int begin, int end) {
    if (begin < end) {
        int i = begin;
        int j = end;
        int k = nums[begin];
        while (i < j) {
            while (i < j && nums[j] > k) j--;
            if (i < j) nums[i++] = nums[j];
            while (i < j && nums[i] < k) i++;
            if (i < j) nums[j--] = nums[i];
        }
        nums[i] = k;
        quickSort(nums, begin, i - 1);
        quickSort(nums, i + 1, end);
    }
}

/// 选择排序
/// @param nums 排序数组
/// @param numsSize 排序数组长度
void selectSort(int *nums, int numsSize) {
    for (int i = 0; i < numsSize - 1 ; i++) {
        int minPos = i;
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] < nums[minPos]) minPos = j;
        }
        if (minPos != i) {
            swap(&nums[i], &nums[minPos]);
        }
    }
}
