//
//  STCommonC.c
//  STArithmetic
//
//  Created by song on 2021/9/14.
//  Copyright © 2021 Knowin. All rights reserved.
//

#include "STCommonC.h"

static const int MAX_VALUE = 2147483647;
static const int MIV_VALUE = -2147483648;

int minValue(int a, int b) {
    if (a < b) return a;
    return b;
}

int maxValue(int a, int b) {
    if (a > b) return a;
    return b;
}

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

