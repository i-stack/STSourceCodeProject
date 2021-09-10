//
//  main.m
//  STLRUCache
//
//  Created by song on 2021/9/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct LRUCacheItem {
    int key;
    int value;
    int index;
    struct LRUCacheItem *next;
} LRUCacheItem;

typedef struct LRUCache {
    int count;
    int capacity;
    LRUCacheItem *items;
    LRUCacheItem *headNode;
    LRUCacheItem *tailNode;
} LRUCache;

bool hasContainsItemKey(LRUCache *obj, int key);

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
//    if (hasContainsItemKey(obj, key)) {
//        LRUCacheItem item = obj -> items[queryItem.index];
//        updateLRUNodeToTail(obj, item);
//        value = item.value;
//    }
    return value;
}

bool hasContainsItemKey(LRUCache *obj, int key) {
    if (obj == NULL) return false;
    int newKey = key % obj -> capacity;
    LRUCacheItem item = obj -> items[newKey];
    return item.key == key;
}

void lRUCachePut(LRUCache* obj, int key, int value) {
    printf("lRUCachePut key = %d ,value = %d\n", key, value);
    if (obj == NULL || obj -> capacity < 1) return;
    if (hasContainsItemKey(obj, key)) {
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


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
    }
    return 0;
}
