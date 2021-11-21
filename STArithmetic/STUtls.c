//
//  STUtls.c
//  STArithmetic
//
//  Created by song on 2021/9/14.
//  Copyright © 2021 Knowin. All rights reserved.
//

#include "STUtls.h"

int maxIntValue(void) {
    return 2147483647;
}

int minIntValue(void) {
    return -2147483647;
}

int minValue(int a, int b) {
    if (a < b) return a;
    return b;
}

int maxValue(int a, int b) {
    if (a > b) return a;
    return b;
}

void swap(int *a, int *b) {
    *a ^= *b;
    *b ^= *a;
    *a ^= *b;
}

/// 查询是否有重复的随机数
/// @param info STRandomArrayInfo
/// @param randomValue 随机数
bool checkRandomIsRepeat(STRandomArrayInfo *info, int randomValue) {
    if (info -> randomCount > 0) {
        for (int i = 0; i < info -> randomCount; i++) {
            if (randomValue == info -> randomArray[i]) {
                return true;
            }
        }
    }
    return false;
}

/// 生成随机数
/// @param seed 随机数范围
int generateRandom(int seed) {
    return arc4random() % seed;
}

/// 生成随机数 [from, to] 左闭右闭，即包含a和b
/// @param from begin
/// @param to end
STRandomArrayInfo* generateRandomArray(int from, int to) {
    int i = 0;
    int randomCount = to - from + 1;
    STRandomArrayInfo *randomArrayInfo = (STRandomArrayInfo *)malloc(sizeof(STRandomArrayInfo));
    randomArrayInfo -> to = to;
    randomArrayInfo -> from = from;
    randomArrayInfo -> randomCount = 0;
    randomArrayInfo -> randomArray = (int *)malloc(sizeof(int) * randomCount);
    while (i < randomCount) {
        int randomValue = (int)(from + (arc4random() % randomCount));
        randomArrayInfo -> randomArray[i] = randomValue;
        i++;
        randomArrayInfo -> randomCount = i;
    }
    return randomArrayInfo;
}

/// 生成随机不重复数 [from, to] 左闭右闭，即包含a和b
/// @param from begin
/// @param to end
STRandomArrayInfo* generateRandomNoRepeatArray(int from, int to) {
    int i = 0;
    int randomCount = to - from + 1;
    STRandomArrayInfo *randomArrayInfo = (STRandomArrayInfo *)malloc(sizeof(STRandomArrayInfo));
    randomArrayInfo -> to = to;
    randomArrayInfo -> from = from;
    randomArrayInfo -> randomCount = 0;
    randomArrayInfo -> randomArray = (int *)malloc(sizeof(int) * randomCount);
    while (i < randomCount) {
        int randomValue = (int)(from + (arc4random() % randomCount));
        if (checkRandomIsRepeat(randomArrayInfo, randomValue)) continue;
        randomArrayInfo -> randomArray[i] = randomValue;
        i++;
        randomArrayInfo -> randomCount = i;
    }
    return randomArrayInfo;
}
