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

typedef struct LinkNode {
    int value;
    bool isEmpty;
    struct LinkNode *next;
}LinkNode;

LinkNode * merge(LinkNode *head, int *mergeNums, int colSize) {
    if (head == NULL || colSize < 1) return NULL;
    for (int i = 0; i < colSize; i++) {
        int value = mergeNums[i];
        LinkNode *node = (LinkNode *)malloc(sizeof(LinkNode));
        node -> value = value;
        node -> next = NULL;
        node -> isEmpty = false;
        // 链表为空
        if (head -> isEmpty) {
            head -> value = value;
            head -> isEmpty = false;
            head -> next = NULL;
        } else {
            if (value <= head -> value) {
                node -> next = head;
                head = node;
            } else {
                LinkNode *tempNode = head;
                LinkNode *preNode = NULL;

                while (tempNode != NULL) {
                    if (value <= tempNode -> value) {
                        preNode -> next = node;
                        node -> next = tempNode;
                        break;
                    } else {
                        preNode = tempNode;
                        if (tempNode -> next == NULL) {
                            tempNode -> next = node;
                            break;
                        }
                        tempNode = tempNode -> next;
                    }
                }
            }
        }
    }
    return head;
}

int findValue(LinkNode *head, int k) {
    LinkNode *tempNode = head;
    int index = 1;
    while (tempNode != NULL) {
        if (index == k) {
            return tempNode -> value;
        }
        index++;
        tempNode = tempNode -> next;
    }
    return -1;
}

int kthSmallest(int** matrix, int matrixSize, int* matrixColSize, int k){
    LinkNode *head = (LinkNode *)malloc(sizeof(LinkNode));
    head -> isEmpty = true;
    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < matrixSize; j++) {
            printf("\n---%d\n---\n", matrix[i][j]);
        }
        head = merge(head, matrix[i], matrixSize);
    }
    int value = findValue(head, k);
    return value;
}

long singleNumBits(int num) {
    long count = 1;
    while (num > 10) {
        num /= 10;
        count++;
    }
    return count;
}

void largestNumber(int* nums, int numsSize){
    long totalNumCount = 0;
    int buckets[9][10] = {0};
    int bucketIndexs[9][1] = {0};
    for (int i = 0; i < numsSize; i++) {
        long numCount = singleNumBits(nums[i]);
        totalNumCount += numCount;
        int index = numCount % 9 - 1;
        buckets[index][bucketIndexs[index][0]] = nums[i];
        bucketIndexs[index][0]++;
    }
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 10; j++) {
            printf("\n---%d\n---\n", buckets[i][j]);
        }
    }
}

typedef struct LRUQueryItem {
    int key;
    int value;
    int index;
    bool hasValue;
} LRUQueryItem;

typedef struct LRUCacheItem {
    int key;
    int value;
    int index;
    bool hasValue;
    struct LRUCacheItem *next;
} LRUCacheItem;

typedef struct LRUCache {
    int count;
    int capacity;
    LRUCacheItem *items;
    LRUCacheItem *headNode;
    LRUCacheItem *tailNode;
} LRUCache;

LRUQueryItem hasContainsItemKey(LRUCache *obj, int key);
void addNewNodeToTail(LRUCache *obj, LRUCacheItem item);
void updateLRUNodeToTail(LRUCache* obj, LRUCacheItem item);

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache *cache = (LRUCache *)malloc(sizeof(LRUCache));
    cache -> capacity = capacity;
    cache -> count = 0;
    cache -> headNode = NULL;
    cache -> tailNode = NULL;
    cache -> items = (LRUCacheItem *)malloc(sizeof(LRUCacheItem) * capacity);
    for (int i = 0; i < capacity; i++) {
        LRUCacheItem item = {-1, 0, 0, NULL};
        cache -> items[i] = item;
    }
    return cache;
}

int lRUCacheGet(LRUCache* obj, int key) {
    if (obj == NULL) return -1;
    int value = -1;
    LRUQueryItem queryItem = hasContainsItemKey(obj, key);
    if (queryItem.hasValue) {
        LRUCacheItem item = obj -> items[queryItem.index];
        updateLRUNodeToTail(obj, item);
        value = item.value;
    }
    return value;
}

LRUQueryItem hasContainsItemKey(LRUCache *obj, int key) {
    LRUQueryItem queryItem = {0, 0, 0, false};
    if (obj == NULL) return queryItem;
    LRUCacheItem *tempNode = obj -> headNode;
    while (tempNode != NULL) {
        if (tempNode -> key == key) {
            queryItem.hasValue = true;
            queryItem.key = tempNode -> key;
            queryItem.value = tempNode -> value;
            queryItem.index = tempNode -> index;
            break;
        }
        tempNode = tempNode -> next;
    }
    return queryItem;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    printf("lRUCachePut key = %d ,value = %d\n", key, value);
    if (obj == NULL || obj -> capacity < 1) return;
    LRUQueryItem queryItem = hasContainsItemKey(obj, key);
    if (queryItem.hasValue) {
        int newKey = key % obj -> capacity;
        LRUCacheItem item = obj -> items[newKey];
        item.value = value;
        item.index = newKey;
        obj -> items[newKey] = item;
        updateLRUNodeToTail(obj, item);
    } else if (obj -> count < obj -> capacity) {
        int newKey = key % obj -> capacity;
        LRUCacheItem item = obj -> items[newKey];
        item.key = key;
        item.value = value;
        item.index = newKey;
        addNewNodeToTail(obj, item);
        obj -> count++;
        obj -> items[newKey] = item;
    } else {
        int newKey = obj -> headNode -> index;
        LRUCacheItem item = obj -> items[newKey];
        item.key = key;
        item.value = value;
        item.index = newKey;
        obj -> items[newKey] = item;
        updateLRUNodeToTail(obj, item);
    }
}

void lRUCacheFree(LRUCache* obj) {

}

void updateLRUNodeToTail(LRUCache* obj, LRUCacheItem item) {
    if (obj == NULL || obj -> headNode == NULL) return;
    if (obj -> headNode -> key == item.key) {
        LRUCacheItem *node = obj -> headNode;
        node -> key = item.key;
        node -> value = item.value;
        node -> index = item.index;
        obj -> headNode = obj -> headNode -> next;
        obj -> tailNode -> next = node;
        obj -> tailNode = node;
        obj -> tailNode -> next = NULL;
    } else if (obj -> tailNode -> key == item.key) {
        obj -> tailNode -> value = item.value;
    } else {
        LRUCacheItem *preNode = obj -> headNode;
        LRUCacheItem *tempNode = obj -> headNode;
        while (tempNode != NULL) {
            if (tempNode -> key == item.key) {
                preNode -> next = tempNode -> next;
                tempNode -> key = item.key;
                tempNode -> value = item.value;
                tempNode -> index = item.index;
                obj -> tailNode -> next = tempNode;
                obj -> tailNode = tempNode;
                obj -> tailNode -> next = NULL;
                break;
            }
            preNode = tempNode;
            tempNode = tempNode -> next;
        }
    }
}

void addNewNodeToTail(LRUCache *obj, LRUCacheItem item) {
    if (obj == NULL) return;
    if (obj -> headNode == NULL) {
        obj -> headNode = (LRUCacheItem *)malloc(sizeof(LRUCacheItem));
        obj -> headNode -> key = item.key;
        obj -> headNode -> value = item.value;
        obj -> headNode -> index = item.index;
        obj -> headNode -> next = NULL;
        obj -> tailNode = obj -> headNode;
    } else {
        LRUCacheItem *node = (LRUCacheItem *)malloc(sizeof(LRUCacheItem));
        node -> key = item.key;
        node -> value = item.value;
        node -> index = item.index;
        node -> next = NULL;
        obj -> tailNode -> next = node;
        obj -> tailNode = node;
    }
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LRUCache *cache = lRUCacheCreate(10);
        lRUCachePut(cache, 10, 13);
        lRUCachePut(cache, 3, 17);
        lRUCachePut(cache, 6, 11);
        lRUCachePut(cache, 10, 5);
        lRUCachePut(cache, 9, 10);
        printf("\n===%d===\n", lRUCacheGet(cache, 13));
        
        lRUCachePut(cache, 2, 19);
        printf("\n===%d===\n", lRUCacheGet(cache, 2));
        printf("\n===%d===\n", lRUCacheGet(cache, 3));

        lRUCachePut(cache, 5, 25);
        printf("\n===%d===\n", lRUCacheGet(cache, 8));
        
        lRUCachePut(cache, 9, 22);
        lRUCachePut(cache, 5, 5);
        lRUCachePut(cache, 1, 30);
        printf("\n===%d===\n", lRUCacheGet(cache, 11));
        
        lRUCachePut(cache, 9, 12);
        printf("\n===%d===\n", lRUCacheGet(cache, 7));
        printf("\n===%d===\n", lRUCacheGet(cache, 5));
        printf("\n===%d===\n", lRUCacheGet(cache, 8));
        printf("\n===%d===\n", lRUCacheGet(cache, 9));

        lRUCachePut(cache, 4, 30);
        lRUCachePut(cache, 9, 3);
        printf("\n===%d===\n", lRUCacheGet(cache, 9));
        printf("\n===%d===\n", lRUCacheGet(cache, 10));
        printf("\n===%d===\n", lRUCacheGet(cache, 10));

        lRUCachePut(cache, 2, 14);
        printf("\n===%d===\n", lRUCacheGet(cache, 9));
        printf("\n===%d===\n", lRUCacheGet(cache, 9));
        printf("\n===%d===\n", lRUCacheGet(cache, 10));

        lRUCachePut(cache, 11, 4);
        lRUCachePut(cache, 12, 24);
        lRUCachePut(cache, 5, 18);
        printf("\n===%d===\n", lRUCacheGet(cache, 10));
        
        lRUCachePut(cache, 7, 23);
        printf("\n===%d===\n", lRUCacheGet(cache, 3));
        printf("\n===%d===\n", lRUCacheGet(cache, 8));
        
        lRUCachePut(cache, 3, 27);
        lRUCachePut(cache, 2, 12);
        printf("\n===%d===\n", lRUCacheGet(cache, 1));
        
        lRUCachePut(cache, 2, 9);
        lRUCachePut(cache, 13, 4);
        lRUCachePut(cache, 8, 18);
        lRUCachePut(cache, 1, 7);
        printf("\n===%d===\n", lRUCacheGet(cache, 5));
        
        lRUCachePut(cache, 9, 29);
        lRUCachePut(cache, 8, 21);
        printf("\n===%d===\n", lRUCacheGet(cache, 4));
        
        lRUCachePut(cache, 6, 30);
        lRUCachePut(cache, 1, 12);
        printf("\n===%d===\n", lRUCacheGet(cache, 13));
        
        lRUCachePut(cache, 4, 15);
        lRUCachePut(cache, 7, 22);
        lRUCachePut(cache, 11, 26);
        lRUCachePut(cache, 8, 17);
        lRUCachePut(cache, 9, 29);
        printf("\n===%d===\n", lRUCacheGet(cache, 8));
        
        lRUCachePut(cache, 3, 4);
        lRUCachePut(cache, 11, 30);
        printf("\n===%d===\n", lRUCacheGet(cache, 12));
        
        lRUCachePut(cache, 4, 29);
        printf("\n===%d===\n", lRUCacheGet(cache, 5));
        printf("\n===%d===\n", lRUCacheGet(cache, 6));
        printf("\n===%d===\n", lRUCacheGet(cache, 5));

        lRUCachePut(cache, 3, 4);
        printf("\n===%d===\n", lRUCacheGet(cache, 10));
        printf("\n===%d===\n", lRUCacheGet(cache, 5));

        lRUCachePut(cache, 3, 29);
        lRUCachePut(cache, 10, 28);
        lRUCachePut(cache, 1, 20);
        lRUCachePut(cache, 11, 13);
        printf("\n===%d===\n", lRUCacheGet(cache, 12));
        
        lRUCachePut(cache, 3, 12);
        lRUCachePut(cache, 3, 8);
        lRUCachePut(cache, 10, 9);
        lRUCachePut(cache, 3, 26);
        printf("\n===%d===\n", lRUCacheGet(cache, 3));
        printf("\n===%d===\n", lRUCacheGet(cache, 9));
        printf("\n===%d===\n", lRUCacheGet(cache, 6));
        
        lRUCachePut(cache, 13, 17);
        lRUCachePut(cache, 2, 27);
        lRUCachePut(cache, 11, 15);
        printf("\n===%d===\n", lRUCacheGet(cache, 1));
        
        lRUCachePut(cache, 9, 19);
        lRUCachePut(cache, 2, 15);
        lRUCachePut(cache, 3, 16);
        printf("\n===%d===\n", lRUCacheGet(cache, 10));
        
        lRUCachePut(cache, 12, 17);
        lRUCachePut(cache, 9, 1);
        lRUCachePut(cache, 6, 19);
        printf("\n===%d===\n", lRUCacheGet(cache, 3));
        printf("\n===%d===\n", lRUCacheGet(cache, 8));
        printf("\n===%d===\n", lRUCacheGet(cache, 7));

        lRUCachePut(cache, 8, 1);
        lRUCachePut(cache, 11, 7);
        lRUCachePut(cache, 5, 2);
        lRUCachePut(cache, 9, 28);
        printf("\n===%d===\n", lRUCacheGet(cache, 5));
        
        lRUCachePut(cache, 2, 2);
        lRUCachePut(cache, 7, 4);
        lRUCachePut(cache, 4, 22);
        lRUCachePut(cache, 7, 24);
        lRUCachePut(cache, 9, 26);
        lRUCachePut(cache, 13, 28);
        lRUCachePut(cache, 11, 26);
    }
    return 0;
}
