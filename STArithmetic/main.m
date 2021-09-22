//
//  main.m
//  STArithmetic
//
//  Created by song on 2021/6/22.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCommonC.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
    }
    return 0;
}

/*
 * leetcode 633
 * 给定一个非负整数 c ，你要判断是否存在两个整数 a 和 b，使得 a^2 + b^2 = c 。
 */
bool judgeSquareSum(int c) {
    if (c == 1) return true;
    int left = 0, right = c >> 1;
    while (left <= right) {
        int mid = left + ((right - left) >> 1);
        if (mid > c / mid) {
            right--;
        } else if (mid * mid < c) {
            left++;
        } else {
            return true;
        }
    }
    return false;
}
