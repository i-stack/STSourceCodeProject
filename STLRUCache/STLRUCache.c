//
//  STLRUCache.c
//  STLRUCache
//
//  Created by song on 2021/9/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#include "STLRUCache.h"

typedef struct LRUCacheItem {
    int key;
    int value;
    int index;
    struct LRUCacheItem *pre;
    struct LRUCacheItem *next;
} LRUCacheItem;

typedef struct LRUCache {
    int count;
    int capacity;
    LRUCacheItem *items;
    LRUCacheItem *headNode;
    LRUCacheItem *tailNode;
} LRUCache;
