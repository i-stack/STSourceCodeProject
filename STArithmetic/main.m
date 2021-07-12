//
//  main.m
//  STArithmetic
//
//  Created by song on 2021/6/22.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    int *vals;
    int index;
    int minVal;
} MinStack;

struct ListNode {
    int val;
    struct ListNode *next;
};

void merge(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n);
char * addBinary(char * a, char * b);

MinStack* minStackCreate(void);
void minStackPush(MinStack* obj, int val);

int* getMaximumXor(int* nums, int numsSize, int maximumBit, int* returnSize);

char* join(char *s1, char *s2)
{
    unsigned long s1Length = 0;
    if (s1 != NULL) {
        s1Length = strlen(s1);
    }
    unsigned long s2Length = 0;
    if (s2 != NULL) {
        s2Length = strlen(s2);
    }
    char *result = malloc(s1Length + s2Length + 1);
    if (result == NULL) exit (1);
    if (s1 != NULL) {
        strcpy(result, s1);
    }
    if (s2 != NULL) {
        strcat(result, s2);
    }
    return result;
}

char * intToRoman(int num){
    char *res = "";
    char *tempRes = "";
    while (num != 0) {
        if (num >= 1000) {
            num -= 1000;
            tempRes = "M";
            res = join(res, tempRes);
        } else if (num >= 900) {
            num -= 900;
            tempRes = "C";
            res = join(res, tempRes);
            tempRes = "M";
            res = join(res, tempRes);
        } else if (num >= 500) {
            num -= 500;
            tempRes = "D";
            res = join(res, tempRes);
        } else if (num >= 400) {
            num -= 400;
            tempRes = "C";
            res = join(res, tempRes);
            tempRes = "D";
            res = join(res, tempRes);
        } else if (num >= 100) {
            num -= 100;
            tempRes = "C";
            res = join(res, tempRes);
        } else if (num >= 90) {
            num -= 90;
            tempRes = "X";
            res = join(res, tempRes);
            tempRes = "C";
            res = join(res, tempRes);
        } else if (num >= 50) {
            num -= 50;
            tempRes = "L";
            res = join(res, tempRes);
        } else if (num >= 40) {
            num -= 40;
            tempRes = "X";
            res = join(res, tempRes);
            tempRes = "L";
            res = join(res, tempRes);
        } else if (num >= 10) {
            num -= 10;
            tempRes = "X";
            res = join(res, tempRes);
        } else if (num == 9) {
            num -= 9;
            tempRes = "I";
            res = join(res, tempRes);
            tempRes = "X";
            res = join(res, tempRes);
        } else if (num >= 5) {
            num -= 5;
            tempRes = "V";
            res = join(res, tempRes);
        } else if (num == 4) {
            num -= 4;
            tempRes = "I";
            res = join(res, tempRes);
            tempRes = "V";
            res = join(res, tempRes);
        } else if (num <= 3) {
            num -= 1;
            tempRes = "I";
            res = join(res, tempRes);
        }
    }
    return res;
}

/** initialize your data structure here. */
MinStack* minStackCreate(void) {
    MinStack *minStack = (MinStack *)malloc(sizeof(MinStack));
    minStack -> index = 0;
    minStack -> minVal = 0;
    minStack -> vals = (int *)malloc(sizeof(int));
    return minStack;
}

void minStackPush(MinStack* obj, int val) {
    if (obj != NULL) {
        obj -> vals[obj -> index] = val;
        obj -> index++;
        obj -> minVal = (val < obj -> minVal) ? val : obj -> minVal;
    }
}

char * addBinary(char * a, char * b) {
    unsigned long aLength = strlen(a);
    unsigned long bLength = strlen(b);
    int carry = 0, index = 0;
    int aNum = 0, bNum = 0, sum = 0;
    char *tempRes = (char *)malloc(sizeof(char));
    while (aLength > 0 || bLength > 0) {
        if (aLength > 0) {
            if (a[aLength - 1] == '0') {
                aNum = 0;
            } else {
                aNum = 1;
            }
            aLength--;
        } else {
            aNum = 0;
        }
        if (bLength > 0) {
            if (b[bLength - 1] == '0') {
                bNum = 0;
            } else {
                bNum = 1;
            }
            bLength--;
        } else {
            bNum = 0;
        }
        sum = aNum + bNum + carry;
        carry = 0;
        if (sum > 1) {
            carry = 1;
            sum = 0;
        }
        if (sum == 0) {
            tempRes[index] = '0';
        } else {
            tempRes[index] = '1';
        }
        index++;
    }
    if (carry != 0) {
        tempRes[index] = '1';
    }
    int resIndex = 0;
    char *res = (char *)malloc(sizeof(char) * index);
    for (int i = index; i >= 0; i--) {
        res[resIndex] = tempRes[i];
        resIndex++;
    }
    free(tempRes);
    return res;
}

void merge(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n){
    if (nums2Size < 1) return;
    if (nums1Size < m + n) return;
    int p = m + n - 1;
    while (m > 0 && n > 0) {
        if (nums1[m - 1] >= nums2[n - 1]) {
            nums1[p] = nums1[m - 1];
            m--;
        } else {
            nums1[p] = nums2[n - 1];
            n--;
        }
        p--;
    }
    while(n > 0) {
        nums1[p] = nums2[n - 1];
        n--;
        p--;
    }
}

int* getMaximumXor(int* nums, int numsSize, int maximumBit, int* returnSize){
    *returnSize = 0;
    int *answer = (int *)malloc(sizeof(int) * (numsSize));
    int lastIndex = numsSize - 1;
    int k = 0, value = 0, maxValue = 0;
    int maxBit = pow(2, maximumBit);
    while(lastIndex >= 0) {
        for (int i = lastIndex; i >= 0; i--) {
            value ^= nums[i];
        }
        for (int i = 0; i < maxBit; i++) {
            if ((value ^ i) > maxValue) {
                k = i;
                maxValue = value ^ i;
            }
        }
        answer[*returnSize] = k;
        k = 0;
        value = 0;
        maxValue = 0;
        lastIndex--;
        (*returnSize) += 1;
    }
    for (int i = 0; i < *returnSize; i++) {
        printf("begin ---\n");
        printf("%d\n", answer[i]);
        printf("end ---\n");
    }
    return answer;
}

int searchInsert(int* nums, int numsSize, int target);

int searchInsert(int* nums, int numsSize, int target){
    if (numsSize < 1) return 0;
    int begin = 0;
    int end = numsSize - 1;
    if (nums[begin] >= target) return begin;
    if (nums[end] == target) return end;
    if (nums[end] < target) return numsSize;
    int mid = begin + ((numsSize - begin) >> 1);
    int res = -1;
    while (begin < end) {
        if (nums[mid] > target) {
            end = mid;
        } else if (nums[mid] < target) {
            begin = mid + 1;
        } else {
            res = mid;
            break;
        }
        mid = begin + ((end - begin) >> 1);
    }
    if (res == -1) {
        res = begin;
    }
    return res;
}

int* findErrorNums(int* nums, int numsSize, int* returnSize){
    //*returnSize = 2;
    int *res = (int *)malloc(sizeof(int) * 2);
    int value = numsSize;
    int repeatNum = 0;
    for (int i = 0; i < numsSize; i++) {
        repeatNum ^= nums[i];
        value ^= nums[i] ^ i;
    }
    res[0] = repeatNum;
    res[1] = value;
    return res;
}

bool isPalindrome(struct ListNode* head);
struct ListNode * revertNode(struct ListNode *node);

struct ListNode * revertNode(struct ListNode *node) {
    if (node == NULL || node -> next == NULL) return node;
    struct ListNode *preNode = NULL;
    struct ListNode *tempNode = NULL;
    while (node != NULL) {
        tempNode = node -> next;
        node -> next = preNode;
        preNode = node;
        node = tempNode;
    }
    return preNode;
}

bool isPalindrome(struct ListNode* head){
    if (head == NULL || head -> next == NULL) return head;
    struct ListNode *slow = head;
    struct ListNode *fast = head;
    while (fast != NULL && fast -> next != NULL) {
       slow = slow -> next;
       fast = fast -> next -> next;
    }
    struct ListNode *newHead = slow;
    if (slow -> next != NULL) {
        newHead = revertNode(slow -> next);
    }
    while (head != NULL && newHead != NULL) {
        if (head -> val != newHead -> val) return false;
        head = head -> next;
        newHead = newHead -> next;
    }
    return true;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        int num1[6] = {6,7,9,0,0,0};
//        int num2[3] = {2,5,6};
//        int *p = num1;
//        int *q = num2;
//        merge(p, 6, 3, q, 3, 3);
//        char a[] = "1010";
//        char b[] = "1011";
//        char *p = a;
//        char *q = b;
//        addBinary(p, q);
        
//        MinStack* obj = minStackCreate();
//        minStackPush(obj, -2);
//        minStackPush(obj, -4);
//        minStackPush(obj, -0);
        
//        intToRoman(1994);
        
        int num[4] = {1,2,2,4};
//        int num[4] = {1,3,5,6};
//        int numSize = 0;
//        int *p = num;
//        int *q = &numSize;
//        getMaximumXor(p, 4, 2, q);
//        searchInsert(num, 4, 4);
        findErrorNums(num, 4, 2);
        
        struct ListNode *head = (struct ListNode *)malloc(sizeof(struct ListNode));
        struct ListNode *headPtr;
        head -> val = 1;
        head -> next = NULL;
        headPtr = head;
        
        struct ListNode *node1 = (struct ListNode *)malloc(sizeof(struct ListNode));;
        node1 -> val = 1;
        node1 -> next = NULL;
        headPtr -> next = node1;
        headPtr = node1;
        
        struct ListNode *node2 = (struct ListNode *)malloc(sizeof(struct ListNode));;
        node2 -> val = 2;
        node2 -> next = NULL;
        headPtr -> next = node2;
        headPtr = node2;

        struct ListNode *node3 = (struct ListNode *)malloc(sizeof(struct ListNode));;
        node3 -> val = 1;
        node3 -> next = NULL;
        headPtr -> next = node3;
        headPtr = node3;
        
        isPalindrome(head);
    }
    return 0;
}
