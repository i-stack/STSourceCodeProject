//
//  STUtls.h
//  STArithmetic
//
//  Created by song on 2021/9/14.
//  Copyright © 2021 Knowin. All rights reserved.
//

#ifndef STUtls_h
#define STUtls_h

#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct STRandomArrayInfo {
    int to;
    int from;
    int randomCount;
    int *randomArray;
} STRandomArrayInfo;

int maxIntValue(void);
int minIntValue(void);
int minValue(int a, int b);
int maxValue(int a, int b);
void swap(int *a, int *b);
STRandomArrayInfo* generateRandomArray(int from, int to);
STRandomArrayInfo* generateRandomNoRepeatArray(int from, int to);

#endif /* STUtls_h */
