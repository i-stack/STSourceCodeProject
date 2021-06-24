//
//  main.m
//  STPoint
//
//  Created by song on 2021/5/20.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct LinkNode {
    char val;
    struct LinkNode *next;
} LinkNode;

bool isValid(char * s);
void merge(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n);
int* twoSum(int* nums, int numsSize, int target, int* returnSize);
int** threeSum(int* nums, int numsSize, int* returnSize, int** returnColumnSizes);
int strStr(char * haystack, char * needle);

int strStr(char * haystack, char * needle){
    if (needle == NULL) return 0;
    int needleLength = 0;
    while (needle[needleLength] != '\0') {
        needleLength++;
    }
    if (needleLength == 0) return 0;
    int haystackLength = 0;
    while (haystack[haystackLength] != '\0') {
        haystackLength++;
    }
    if (needleLength > haystackLength) return -1;
    for (int i = 0; i < haystackLength; i++) {
        int count = 0;
        for (int j = 0; j < needleLength && i + j < haystackLength; j++) {
            if (haystack[i + j] == needle[j]) {
                count++;
            } else {
                break;
            }
        }
        if (count == needleLength) return i;
    }
    return -1;
}
int** threeSum(int* nums, int numsSize, int* returnSize, int** returnColumnSizes){
    if (numsSize < 3) {
        return (int **)malloc(sizeof(int *));
    }
    int **p = (int **)malloc(sizeof(int *));
    for (int i = 0; i < numsSize - 1; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[i] > nums[j]) {
                nums[i] ^= nums[j];
                nums[j] ^= nums[i];
                nums[i] ^= nums[j];
            }
        }
    }
    
    for (int i = 0; i < numsSize; i++) {
        printf("%d", nums[i]);
        printf("\n");
    }
    int secod = 0, third = 0, index = 0;
    for (int i = 0; i < numsSize; i++) {
        secod = i + 1;
        third = numsSize - 1;
        while (secod < third) {
            if (nums[i] + nums[secod] + nums[third] > 0) {
                third--;
            } else if (nums[i] + nums[secod] + nums[third] < 0) {
                secod++;
            } else {
                int *res = (int *)malloc(sizeof(int) * 3);
                res[0] = nums[i];
                res[1] = nums[secod];
                res[2] = nums[third];
                p[index] = res;
                index++;
                break;
            }
        }
    }
//    *returnSize = 3;
//    **returnColumnSizes = index;
    
    for (int i = 0; i < index; i++) {
        int *res = p[i];
        for (int j = 0; j < 3; j++) {
            printf("%d", res[j]); // [-1 -1 2], [-1,0,1]
            printf("\n");
        }
    }
    return p;
}

int* twoSum(int* nums, int numsSize, int target, int* returnSize){
    int *p = (int *)malloc(2 * sizeof(int));
    printf("%d-%d",returnSize[0], returnSize[1]);
    bool hasFind = false;
    for (int i = 0; i < numsSize; i++) {
        int anotherNum = target - nums[i];
        for (int j = i + 1; j < numsSize; j++) {
            if (anotherNum == nums[j]) {
                p[0] = i;
                p[1] = j;
                hasFind = true;
                break;
            }
        }
        if (hasFind) break;
    }
    *returnSize = 2;
    return p;
}

bool isValid(char * s) {
    int length = 0;
    while (s[length] != '\0') {
        length++;
    }
    if (length < 2) return false;
    if ((length & 1) != 0) return false;
    LinkNode *head = NULL;
    bool res = false;
    for (int i = 0; i < length; i++) {
        if ((s[i] == '(') || (s[i] == '[') || (s[i] == '{')) {
            char val = '}';
            if (s[i] == '(') {
                val = ')';
            } else if (s[i] == '[') {
                val = ']';
            }
            if (head == NULL) {
                head = (LinkNode *)malloc(sizeof(LinkNode));
                head -> val = val;
                head -> next = NULL;
            } else {
                LinkNode *newNode = (LinkNode *)malloc(sizeof(LinkNode));
                newNode -> val = val;
                newNode -> next = head;
                head = newNode;
            }
        } else {
            if (head != NULL) {
                if (s[i] == head -> val) {
                    LinkNode *headPtr = head;
                    head = headPtr -> next;
                    res = true;
                    free(headPtr);
                } else {
                    res = false;
                    break;
                }
            } else {
                if (i != length - 1) {
                    res = false;
                    break;
                }
            }
        }
    }
    if (head != NULL) {
        res = false;
    }
    return res;
}

void merge(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n){
    if (n < 1 || nums2Size < 1) return;
    int lastIndex = m + n - 1;
    while (nums2Size >= 0) {
        if (nums1Size < 1) {
            nums1[lastIndex] = nums2[nums2Size - 1];
            lastIndex--;
            nums2Size--;
        } else {
            int lastNum1 = nums1[nums1Size - 1];
            int lastNum2 = nums2[nums2Size - 1];
            if (lastNum1 > lastNum2) {
                nums1[lastIndex] = nums1[nums1Size - 1];
                nums1Size--;
                lastIndex--;
            } else if (lastNum1 == lastNum2) {
                nums1[lastIndex] = nums2[nums2Size - 1];
                lastIndex--;
                nums2Size--;
            } else {
                nums1[lastIndex] = nums2[nums2Size - 1];
                lastIndex--;
                nums2Size--;
            }
        }
    }
    for (int i = 0; i < m + n; i++) {
        printf("%d", nums1[i]);
        printf("\n");
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        int a[5] = {1, 2, 3, 4, 5};
//        int *p = a;
//        printf("%d\n", *((int *)(&a + 1) - 1));
//        printf("%d\n", *((int *)(&a + 1) - 2));
        
//        isValid("[[[]");
//        int numOne[13] = {1,4,9,10,22,33};
//        int numTwo[7] = {2,5,6,11,44,77,100};
//
//        int *num1 = numOne;
//        int *num2 = numTwo;
//        merge(num1, 6, 6, num2, 7, 7);
        
//        int two[2] = {0};
//        int *p = two;
//        twoSum(num2, 7, 7, NULL);
//        int num[6] = {-1,0,1,2,-1,-4};
//        int *p = num;
//        threeSum(p, 6, 6, 2);
        char haystack[] = "aabba";
        char needle[] = "bb";
        char *p = haystack;
        char *q = needle;
        strStr(p, q);
    }
    return 0;
    
    
}
