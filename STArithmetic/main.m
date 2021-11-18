//
//  main.m
//  STArithmetic
//
//  Created by song on 2021/6/22.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STUtls.h"
#import "STSortUtls.h"

typedef struct LRUItem {
    int val;
    int key;
    struct LRUItem *next;
} LRUItem;

typedef struct LRUCache {
    int count;
    int capacity;
    LRUItem *cache;
    LRUItem *head;
} LRUCache;

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache *cache = (LRUCache *)malloc(sizeof(LRUCache));
    cache->capacity = capacity;
    cache->cache = (LRUItem *)malloc(sizeof(LRUItem) * capacity);
     for (int i = 0; i < capacity; i++) {
         LRUItem *item = NULL;
         cache->cache[i] = *item;
     }
    cache->head = NULL;
    cache->count = 0;
    return cache;
}

int lRUCacheGet(LRUCache* obj, int key) {
    int value = -1;
    if (obj == NULL) return value;
    int pos = key % obj->capacity;
    if (&obj->cache[pos] != NULL) {
        LRUItem *item = &obj->cache[pos];
        if (item != NULL && item->key == key) {
            value = item->val;
        } else {
            LRUItem *tempItem = item;
            LRUItem *preItem = item;
            while (tempItem != NULL) {
                if (tempItem->key == key) {
                    value = tempItem->val;
                    preItem->next = tempItem->next;
                    tempItem->next = item;
                    item = tempItem;
                    obj->cache[pos] = *item;
                    break;
                }
                preItem = tempItem;
                tempItem = tempItem->next;
            }
            tempItem = obj->head;
            if (tempItem != NULL && tempItem->key != key) {
                preItem = obj->head;
                while(tempItem != NULL) {
                    if (tempItem->key == key) {
                        preItem->next = tempItem->next;
                        tempItem->next = obj->head;
                        obj->head = tempItem;
                        break;
                    }
                    preItem = tempItem;
                    tempItem = tempItem->next;
                }
            }
        }
    }
    return value;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    if (obj == NULL) return;
    if (obj->count == obj->capacity) {
        // 删除链表的尾节点
        int delKey = 0;
        LRUItem *preItem = obj->head;
        LRUItem *tempItem = obj->head;
        while(tempItem != NULL) {
            if (tempItem->next == NULL) {
                delKey = tempItem->key;
                preItem->next = NULL;
                break;
            }
            preItem = tempItem;
            tempItem = tempItem->next;
        }
        // 删除map中key
        int pos = delKey % obj->capacity;
        LRUItem *item = &obj->cache[pos];
        if (item != NULL && item->next == NULL) {
            item = NULL;
            obj->cache[pos] = *item;
        } else {
            if (item->key == delKey) {
                item = item->next;
                obj->cache[pos] = *item;
            } else {
                LRUItem *tItem = item;
                LRUItem *pItem = item;
                while (tItem != NULL) {
                    if(tItem->key == delKey) {
                        pItem->next = tItem->next;
                        obj->cache[pos] = *item;
                        break;
                    }
                    pItem = tItem;
                    tItem = tItem->next;
                }
            }
        }
    }
    LRUItem *newNode = (LRUItem *)malloc(sizeof(LRUItem));
    newNode->val = value;
    newNode->key = key;
    int pos = key % obj->capacity;
    // 查询当前map中pos是否有值
    LRUItem *item = &obj->cache[pos];
    if (item != NULL) {
        LRUItem *item = &obj->cache[pos];
        if(item->key == key) { // key相同更新val
            item->val = value;
            obj->cache[pos] = *item;
        } else {
            newNode->next = item;
            item = newNode;
        }
    } else {
        newNode->next = obj->head;
        obj->head = newNode;
        obj->cache[pos] = *newNode;
    }
}

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
    for (int i = 0; i < randomInfo -> randomCount; i++) {
        printf("%d\n", randomInfo -> randomArray[i]);
    }
    printf("\n");
}

void testSelectSort(STRandomArrayInfo *randomInfo) {
    selectSort(randomInfo -> randomArray, randomInfo -> randomCount);
//    printSortResult(randomInfo);
}

void testBubbleSort(STRandomArrayInfo *randomInfo) {
    bubbleSort(randomInfo -> randomArray, randomInfo -> randomCount);
//    printSortResult(randomInfo);
}

void testQuickSort(STRandomArrayInfo *randomInfo) {
    quickSort(randomInfo -> randomArray, 0, randomInfo -> randomCount - 1);
//    printSortResult(randomInfo);
}

void testCountingSort(STRandomArrayInfo *randomInfo) {
    countingSort(randomInfo -> randomArray, randomInfo -> randomCount);
//    printSortResult(randomInfo);
}

void testSort(void) {
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
//        testQuickSort(randomInfo);
//        testSelectSort(randomInfo);
//        testBubbleSort(randomInfo);
        testCountingSort(randomInfo);
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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int num[13] = {9,8,7,6,5,4,3,2,1,2,3,4,5};
        int *p = num;
        insertSort(p, 13);
        for (int i = 0; i < 13; i++) {
            NSLog(@"%d", num[i]);
        }        
    }
    return 0;
}
