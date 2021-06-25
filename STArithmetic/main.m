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

void merge(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n);
char * addBinary(char * a, char * b);

MinStack* minStackCreate(void);
void minStackPush(MinStack* obj, int val);

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
        
        intToRoman(1994);
    }
    return 0;
}
