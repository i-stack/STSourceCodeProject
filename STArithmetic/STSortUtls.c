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

/// 二分查找
/// @param nums 已排序数组
/// @param numsSize 已排序数组长度
/// @param target 查询target在已排序中是否存在
/// @return 返回target所在下标
int binarySearch(int *nums, int numsSize, int target) {
    int left = 0, mid = 0;
    int right = numsSize - 1;
    while (left < right) {
        mid = left + ((right - left) >> 1);
        if (nums[mid] > target) {
            right = mid;
        } else if (nums[mid] < target) {
            left = mid + 1;
        } else {
            return mid;
        }
    }
    return -1;
}

/// 二分查找
/// @param nums 已排序数组
/// @param numsSize 已排序数组长度
/// @param target 查询target在已排序中开始和出现的位置
/// @return 返回target所在下标集合
int* binarySearchRange(int *nums, int numsSize, int target) {
    int *res = (int *)malloc(sizeof(int) * 2);
    int firstPosition = findBinarySearchFirstPosition(nums, numsSize, target);
    if (firstPosition == -1) {
        res[0] = -1;
        res[1] = -1;
        return res;
    }
    res[0] = firstPosition;
    int lastPosition = findBinarySearchLastPosition(nums, numsSize, target);
    res[1] = lastPosition;
    return res;
}

/// 二分查找
/// @param nums 已排序数组
/// @param numsSize 已排序数组长度
/// @param target 查询target在已排序中第一次出现的位置
/// @return 返回target所在下标
int findBinarySearchFirstPosition(int* nums, int numsSize, int target) {
    if (numsSize < 1) return -1;
    int left = 0, mid = 0;
    int right = numsSize - 1;
    while (left < right) {
        mid = left + ((right - left) >> 1);
        if (nums[mid] < target) {
            // 说明mid左边的元素都比target小
            // 下一轮的搜索范围为 [mid + 1, right]
            left = mid + 1;
        } else if (nums[mid] == target) {
            // 说明mid右边的元素不可能是第一次出现的元素
            // 下一轮的搜索范围为 [left, mid]
            right = mid;
        } else {
            // 说明mid右边的元素都比target大
            // 下一轮的搜索范围为 [left, mid - 1]
            right = mid - 1;
        }
    }
    if (left < numsSize && nums[left] == target) return left;
    return -1;
}

/// 二分查找
/// @param nums 已排序数组
/// @param numsSize 已排序数组长度
/// @param target 查询target在已排序中最后出现的位置
/// @return 返回target所在下标
int findBinarySearchLastPosition(int* nums, int numsSize, int target) {
    if (numsSize < 1) return -1;
    int left = 0, mid = 0;
    int right = numsSize - 1;
    while (left < right) {
        mid = left + ((right - left) >> 1) + 1;
        if (nums[mid] < target) {
            // 说明mid左边的元素都比target小
            // 下一轮的搜索范围为 [mid + 1, right]
            left = mid + 1;
        } else if (nums[mid] == target) {
            // 说明mid左边的元素不可能是最后一次出现的元素
            // 下一轮的搜索范围为 [mid, right]
            left = mid;
        } else {
            // 说明mid右边的元素都比target大
            // 下一轮的搜索范围为 [left, mid - 1]
            right = mid - 1;
        }
    }
    if (right >= 0 && nums[right] == target) return right;
    return -1;
}
