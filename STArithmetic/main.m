//
//  main.m
//  STArithmetic
//
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STUtls.h"
#import "STSortUtls.h"
#import "STFileManager.h"

enum SortType {
    QuickSort = 0,
    SelectSort,
    BubbleSort,
    CountingSort,
    InsertSort
} type;

void quickSortBig(int *nums, int begin, int end) {
    if (begin < end) {
        int i = begin;
        int j = end;
        int k = nums[begin];
        while (i < j) {
            while (i < j && nums[j] < k) j--;
            if (i < j) nums[i++] = nums[j];
            while (i < j && nums[i] > k) i++;
            if (i < j) nums[j--] = nums[i];
        }
        nums[i] = k;
        quickSortBig(nums, begin, i - 1);
        quickSortBig(nums, i + 1, end);
    }
}

int findKth(int* a, int aLen, int n, int K ) {
    // write code here
    if (aLen < 1 || aLen < K) return 0;
    quickSortBig(a, 0, aLen - 1);
    //quickSort(a, 0, aLen - 1);
    for (int i = 0; i < aLen; i++) {
        printf("\n%d\n", a[i]);
    }
    return a[K - 1];
}

char* solve(char* s, char* t ) {
    // write code here
    int sLength = (int)strlen(s);
    int tLength = (int)strlen(t);
    if (sLength < 1) return t;
    if (tLength < 1) return s;
    int count = sLength > tLength ? sLength : tLength;
    char *res = (char *)malloc(sizeof(char) * (count + 1));
    int index = count + 1;
    int sEnd = sLength - 1;
    int tEnd = tLength - 1;
    int carry = 0;
    bool sHasValue = true;
    bool tHasValue = true;
    while (sHasValue || tHasValue) {
        int sValue = 0, tValue = 0;
        if (sEnd < sLength && sEnd >= 0) {
            sValue = s[sEnd--] - '0';
        } else {
            sHasValue = false;
        }
        if (tEnd < tLength && tEnd >= 0) {
            tValue = t[tEnd--] - '0';
        } else {
            tHasValue = false;
        }
        int sum = sValue + tValue + carry;
        carry = 0;
        if (sum >= 0) {
            sum -= 10;
            carry = 1;
        }
        res[index--] = sum + '0';
    }
    if (carry != 0) {
        res[0] = '1';
    }
    return res;
}

void printSortResult(STRandomArrayInfo *randomInfo) {
    printf("排序后:\n");
    for (int i = 0; i < randomInfo->randomCount; i++) {
        printf("%d\n", randomInfo->randomArray[i]);
    }
    printf("\n");
}

void testSelectSort(STRandomArrayInfo *randomInfo) {
    selectSort(randomInfo->randomArray, randomInfo->randomCount);
//    printSortResult(randomInfo);
}

void testBubbleSort(STRandomArrayInfo *randomInfo) {
    bubbleSort(randomInfo->randomArray, randomInfo->randomCount);
//    printSortResult(randomInfo);
}

void testQuickSort(STRandomArrayInfo *randomInfo) {
    quickSort(randomInfo->randomArray, 0, randomInfo->randomCount - 1);
//    printSortResult(randomInfo);
}

void testCountingSort(STRandomArrayInfo *randomInfo) {
    countingSort(randomInfo->randomArray, randomInfo->randomCount);
//    printSortResult(randomInfo);
}

void testInsertSort(STRandomArrayInfo *randomInfo) {
    insertSort(randomInfo->randomArray, randomInfo->randomCount);
    //    printSortResult(randomInfo);
}

void testBinarySearch(STRandomArrayInfo *randomInfo) {
    quickSort(randomInfo->randomArray, 0, randomInfo->randomCount - 1);
    printSortResult(randomInfo);
    int target = generateRandom(100);
    int pos = binarySearch(randomInfo->randomArray, randomInfo->randomCount, target);
    printf("\n");
    NSLog(@"binary search result: pos = %d -- value = %d -- target = %d", pos, randomInfo->randomArray[pos], target);
    printf("\n");
}

void testBinarySearchRange(STRandomArrayInfo *randomInfo) {
    quickSort(randomInfo->randomArray, 0, randomInfo->randomCount - 1);
    int target = generateRandom(100);
    int *res = binarySearchRange(randomInfo->randomArray, randomInfo->randomCount, target);
    NSLog(@"binary search range pos[0] = %d -- pos[1] = %d -- target = %d", res[0], res[1], target);
    for (int i = 0; i < randomInfo->randomCount; i++) {
        if (randomInfo->randomArray[i] == target) {
            NSLog(@"randomInfo->randomArray contains target");
            break;
        }
    }
}

void testSort(enum SortType type) {
    NSLog(@"开始排序:\n");
    int loopCount = 900;
    int totalSuccessCount = 0;
    for (int i = 0; i < loopCount; i++) {
        STRandomArrayInfo *randomInfo = generateRandomArray(1500, 2000);//generateRandomNoRepeatArray(0, 10000);
        NSMutableArray *array = [NSMutableArray array];
        for (int k = 0; k < randomInfo -> randomCount; k++) {
            array[k] = @(randomInfo -> randomArray[k]);
        }
        NSArray *newArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSNumber *tNumber1 = (NSNumber *)obj1;
            NSNumber *tNumber2 = (NSNumber *)obj2;
            if ([tNumber1 integerValue] < [tNumber2 integerValue]) {
                return NSOrderedAscending;
            }
            return NSOrderedDescending;
        }];
        switch (type) {
            case QuickSort:
                testQuickSort(randomInfo);
                break;
            case SelectSort:
                testSelectSort(randomInfo);
                break;
            case BubbleSort:
                testBubbleSort(randomInfo);
                break;
            case InsertSort:
                testInsertSort(randomInfo);
                break;
            case CountingSort:
                testCountingSort(randomInfo);
                break;
            default:
                break;
        }
        int compareSuccessCount = 0;
        for (int k = 0; k < randomInfo -> randomCount; k++) {
            if ([newArray[k] intValue] != randomInfo -> randomArray[k]) {
                NSLog(@"sort error: index = %d -- newArray value = %d -- randomInfo value = %d\n", k, [newArray[k] intValue], randomInfo -> randomArray[k]);
                break;
            }
            compareSuccessCount++;
        }
        if (compareSuccessCount == randomInfo -> randomCount) {
            totalSuccessCount++;
        }
    }
    NSLog(@"排序完成:\n");
    if (totalSuccessCount == loopCount) {
        NSLog(@"success: totalSuccessCount is same loopCount = %d次", loopCount);
    } else {
        NSLog(@"error: totalSuccessCount = %d次", totalSuccessCount);
    }
}

void merge(int* A, int ALen, int m, int* B, int BLen, int n) {
    if (ALen != m + n) return;
    if (BLen < 1 || ALen < 1) return;
    int i = m - 1;
    int j = n - 1;
    int k = m + n - 1;
    while (i >= 0 && j >= 0) {
        if (A[i] >= B[j]) {
            A[k--] = A[i--];
        } else {
            A[k--] = B[j--];
        }
    }
    while (i >= 0) {
        A[k--] = A[i--];
    }
    while (j >= 0) {
        A[k--] = B[j--];
    }
}

int lengthOfLIS(int* nums, int numsSize){
    if (numsSize < 1) return 0;
    int dp[numsSize];
    for (int i = 0; i < numsSize; i++) {
        dp[i] = INT_MIN;
    }
    int index = 0;
    for (int i = 0; i < numsSize; i++) {
        int left = 0;
        int right = index;
        while (left < right) {
            int mid = left + ((right - left) >> 1);
            if (dp[mid] < nums[i]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        dp[left] = nums[i];
        if(index == right) index++;
    }
    return index;
}

// 辗转相处求最大公约数
int testGCD(int a, int b) {
    if (b == 0) return a;
    return testGCD(b, a % b);
//    int t = 1;
//    while (t != 0) {
//        t = a % b;
//        a = b;
//        b = t;
//    }
//    return a;
}

void resetMap(int res[], int length) {
    for (int i = 0; i < length; i++) {
        res[i] = -1;
    }
}

int lengthOfLongestSubstring(char * s){
    int length = (int)strlen(s);
    if (length < 1) return 0;
    int maxLength = 1;
    int map[128] = {0};
    resetMap(map, 128);
    for (int i = 0; i < length - 1; i++) {
        int sLength = 1;
        resetMap(map, 128);
        int iIndex = s[i] - 'a';
        map[iIndex] = iIndex;
        for (int j = i + 1; j < length; j++) {
            int jIndex = s[j] - 'a';
            if (map[jIndex] != -1) break;
            sLength++;
            map[jIndex] = jIndex;
        }
        if (sLength > maxLength) maxLength = sLength;
    }
    return maxLength;
}

bool containsDuplicate(int* nums, int numsSize) {
    bool result = false;
    if (numsSize < 1) return false;
    int minValue = nums[0];
    int maxValue = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < minValue) minValue = nums[i];
        if (nums[i] > maxValue) maxValue = nums[i];
    }
    int mapCount = maxValue - minValue + 1;
    int *map = (int *)malloc(sizeof(int) * mapCount);
    for (int i = 0; i < mapCount; i++) {
        map[i] = 0;
    }
    for (int i = 0; i < numsSize; i++) {
        int value = nums[i] - minValue;
        map[value]++;
        if (map[value] > 1) {
            result = true;
            break;
        }
    }
    return result;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        enum SortType type;
//        type = InsertSort;
//        testSort(type);
//
//        STRandomArrayInfo *info = generateRandomArray(0, 100);
//        testBinarySearch(info);
//        testBinarySearchRange(info);
//
//        lengthOfLongestSubstring("abcabcccb");
        
        int nums[4] = {1,2,4,3};
        int *p = nums;
        containsDuplicate(p, 4);

    }
    return 0;
}
