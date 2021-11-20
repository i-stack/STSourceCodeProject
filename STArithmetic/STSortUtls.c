//
//  STSortUtls.c
//  STArithmetic
//
//  Created by song on 2021/10/28.
//  Copyright © 2021 Knowin. All rights reserved.
//

#include "STSortUtls.h"
#include "STUtls.h"

/// 归并排序 从小到大
/// @param nums 排序数组
/// @param begin 起始位置
/// @param end 结束位置
void mergeSort(int *nums, int begin, int end) {
    
}

/// 计数排序 从小到大
/// @param nums 排序数组
/// @param numsSize 排序数组长度
void countingSort(int *nums, int numsSize) {
    if (numsSize <= 1) return;
    int minValue = nums[0], maxValue = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minValue) minValue = nums[i];
        if (nums[i] > maxValue) maxValue = nums[i];
    }
    int bucketCount = maxValue - minValue + 1;
    int *bucket = (int *)malloc(sizeof(int) * bucketCount);
    for (int i = 0; i < bucketCount; i++) {
        bucket[i] = 0;
    }
    for (int i = 0; i < numsSize; i++) {
        bucket[nums[i] - minValue]++;
    }
    int j = 0;
    for (int i = 0; i < bucketCount; i++) {
        while (bucket[i] > 0 && j < numsSize) {
            nums[j++] = i + minValue;
            bucket[i]--;
        }
    }
    free(bucket);
}

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

/// 选择排序 从小到大
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

/// 冒泡排序 从小到大
/// @param nums 排序数组
/// @param numsSize 排序数组长度
void bubbleSort(int *nums, int numsSize) {
    bool hasExchange = true;
    for (int i = 0; i < numsSize - 1 && hasExchange; i++) {
        hasExchange = false;
        for (int j = 0; j < numsSize - 1 - i; j++) {
            if (nums[j] > nums[j + 1]) {
                hasExchange = true;
                swap(&nums[j], &nums[j + 1]);
            }
        }
    }
}

/// 插入排序 从小到大
/// @param nums 排序数组
/// @param numsSize 排序数组长度
void insertSort(int *nums, int numsSize) {
    /**
     * 0 ~ 0 是否有序，只有一个数，是有序，从1开始
     * 0 ~ 1 是否有序，比较0和1位置大小
     * 0 ~ 2 是否有序，从 i - 1 位置倒序与之前的数进行比较
     */
    for (int i = 1; i < numsSize; i++) {
        for (int j = i - 1; j >= 0; j--) {
            if (nums[j] > nums[j + 1]) {
                swap(&nums[j], &nums[j + 1]);
            } else {
                break;
            }
        }
    }
}
