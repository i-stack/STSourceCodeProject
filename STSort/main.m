//
//  main.m
//  STSort
//
//  Created by song on 2021/6/25.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

void merge_sort(int arr[], const int len);
void merge_sort_recursive(int arr[], int reg[], int start, int end);

/**
 *  归并排序：分治思想
 *  把一个复杂问题分成许多相同或者相似的子问题，在把子问题分成更小的子问题，直到子问题可以简单的解决，原问题的解即子问题的解的合并。
 *
 *  思路分析：归并排序将原始数组对半分割，直到不能再分后，开始从最小的数组向上归并排序
 *
 *  时间复杂度：
 *      无论原始数组是否有序，都要递归分隔并向上归并排序，所以时间复杂度始终是O（nlog2n）
 *  空间复杂度：
 *      每次两个数组进行归并排序的时候，都会利用一个长度为n的数组作为辅助数组用于保存合并序列，所以空间复杂度为O（n）
 */
void merge_sort_recursive(int arr[], int reg[], int start, int end) {
    if (start >= end) return;
    int len = end - start, mid = (len >> 1) + start;
    int left_low = start;
    int right_low = mid + 1;
    merge_sort_recursive(arr, reg, left_low, mid);
    merge_sort_recursive(arr, reg, right_low, end);
    int k = start;
    while (left_low <= mid && right_low <= end)
        reg[k++] = arr[left_low] < arr[right_low] ? arr[left_low++] : arr[right_low++];
    while (left_low <= mid)
        reg[k++] = arr[left_low++];
    while (right_low <= end)
        reg[k++] = arr[right_low++];
    for (k = start; k <= end; k++)
        arr[k] = reg[k];
}

void merge_sort(int arr[], const int len) {
    int reg[len];
    merge_sort_recursive(arr, reg, 0, len - 1);
}

void quickSoct(int *arr, int begin, int end);

void quickSoct(int *arr, int begin, int end) {
    if (begin < end) {
        int i = begin;
        int j = end;
        int k = arr[begin];
        while (i < j) {
            while (i < j && arr[j] >= k) j--;
            if (i < j) arr[i++] = arr[j];
            while (i < j && arr[i] < k) i++;
            if (i < j) arr[j--] = arr[i];
        }
        arr[i] = k;
        quickSoct(arr, begin, i - 1);
        quickSoct(arr, i + 1, end);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int nums[] = {5, 1, 8, 4, 7, 2, 3, 9, 0, 6};
        int length = sizeof(nums) / sizeof(int);
//        merge_sort(nums, length);
        quickSoct(nums, 0, length - 1);
        printf ("\n 排序后 \n");
        for(int i = 0; i < length; i++) {
            printf("%d\t", nums[i]);
            printf("\n");
        }
    }
    return 0;
}
