//
//  main.m
//  STArithmetic
//
//  Created by song on 2021/6/22.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

int min(int a, int b) {
    if (a < b) return a;
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

int** threeSum(int* nums, int numsSize, int* returnSize, int** returnColumnSizes){
    *returnSize = 0;
    if (numsSize < 3) return (int **)malloc(sizeof(int *));
    *returnColumnSizes = (int *)malloc(sizeof(int) * numsSize);
    int **p = (int **)malloc(sizeof(int *) * numsSize);
    quickSort(nums, 0, numsSize - 1);
    if (0 == nums[numsSize - 1]) {
        p[*returnSize] = (int *)malloc(sizeof(int) * 3);
        p[*returnSize][0] = 0;
        p[*returnSize][1] = 0;
        p[*returnSize][2] = 0;
        (*returnColumnSizes)[*returnSize] = 3;
        (*returnSize)++;
        return p;
    }
    int j = 0, k = 0;
    for (int i = 0; i < numsSize && nums[i] <= 0; i++) {
        if (i > 0 && nums[i] == nums[i - 1]) continue;
        j = i + 1;
        k = numsSize - 1;
        while (j < k) {
            if (nums[i] + nums[j] + nums[k] > 0) {
                k--;
            } else if (nums[i] + nums[j] + nums[k] < 0) {
                j++;
            } else {
                p[*returnSize] = (int *)malloc(sizeof(int) * 3);
                p[*returnSize][0] = nums[i];
                p[*returnSize][1] = nums[j];
                p[*returnSize][2] = nums[k];
                (*returnColumnSizes)[*returnSize] = 3;
                (*returnSize)++;
                while (j < k && nums[k] == nums[k - 1]) k--;
                while (j < k && nums[j] == nums[j + 1]) j++;
                k--;
                j++;
            }
        }
    }
    return p;
}

int converMinute(char *time) {
    unsigned long length = strlen(time);
    int hour = 0, minute = 0, value = 10;
    for (int i = 0; i < length; i++) {
        if (i < 2) {
            hour += (time[i] - '0') * value;
            value = 1;
        } else if (i == 2) {
            value = 10;
            continue;
        } else {
            minute += (time[i] - '0') * value;
            value = 1;
        }
    }
    return hour * 60 + minute;
}

int findMinDifference(char ** timePoints, int timePointsSize){
    if (timePointsSize < 2) return 0;
    if (timePointsSize > 24 * 60) return 0;
    int *minutePoints = (int *)malloc(sizeof(int) * timePointsSize);
    for (int i = 0; i < timePointsSize; i++) {
        int minute = converMinute(timePoints[i]);
        minutePoints[i] = minute;
    }
    quickSort(minutePoints, 0, timePointsSize - 1);
    int minValue = 0;
    for (int i = 0; i < timePointsSize - 1; i++) {
        minValue = min(minValue, minutePoints[i + 1] - minutePoints[i]);
    }
    minValue = min(minValue, 1440 - minutePoints[timePointsSize - 1] + minutePoints[0]);
    return minValue;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        char *a = "23:59";
        char *b = "00:00";
        char **num = (char **)malloc(sizeof(char *) * 2);
        num[0] = a;
        num[1] = b;
        findMinDifference(num, 2);
    }
    return 0;
}
