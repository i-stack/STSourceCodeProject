//
//  main.m
//  STLRUCache
//
//  Created by song on 2021/9/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

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
