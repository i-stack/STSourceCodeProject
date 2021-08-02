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

struct ListNode {
    int val;
    struct ListNode *next;
};

void merge(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n);
char * addBinary(char * a, char * b);

MinStack* minStackCreate(void);
void minStackPush(MinStack* obj, int val);

int* getMaximumXor(int* nums, int numsSize, int maximumBit, int* returnSize);

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

int* getMaximumXor(int* nums, int numsSize, int maximumBit, int* returnSize){
    *returnSize = 0;
    int *answer = (int *)malloc(sizeof(int) * (numsSize));
    int lastIndex = numsSize - 1;
    int k = 0, value = 0, maxValue = 0;
    int maxBit = pow(2, maximumBit);
    while(lastIndex >= 0) {
        for (int i = lastIndex; i >= 0; i--) {
            value ^= nums[i];
        }
        for (int i = 0; i < maxBit; i++) {
            if ((value ^ i) > maxValue) {
                k = i;
                maxValue = value ^ i;
            }
        }
        answer[*returnSize] = k;
        k = 0;
        value = 0;
        maxValue = 0;
        lastIndex--;
        (*returnSize) += 1;
    }
    for (int i = 0; i < *returnSize; i++) {
        printf("begin ---\n");
        printf("%d\n", answer[i]);
        printf("end ---\n");
    }
    return answer;
}

int searchInsert(int* nums, int numsSize, int target);

int searchInsert(int* nums, int numsSize, int target){
    if (numsSize < 1) return 0;
    int begin = 0;
    int end = numsSize - 1;
    if (nums[begin] >= target) return begin;
    if (nums[end] == target) return end;
    if (nums[end] < target) return numsSize;
    int mid = begin + ((numsSize - begin) >> 1);
    int res = -1;
    while (begin < end) {
        if (nums[mid] > target) {
            end = mid;
        } else if (nums[mid] < target) {
            begin = mid + 1;
        } else {
            res = mid;
            break;
        }
        mid = begin + ((end - begin) >> 1);
    }
    if (res == -1) {
        res = begin;
    }
    return res;
}

int* findErrorNums(int* nums, int numsSize, int* returnSize){
    //*returnSize = 2;
    int *res = (int *)malloc(sizeof(int) * 2);
    int value = numsSize;
    int repeatNum = 0;
    for (int i = 0; i < numsSize; i++) {
        repeatNum ^= nums[i];
        value ^= nums[i] ^ i;
    }
    res[0] = repeatNum;
    res[1] = value;
    return res;
}

bool isPalindrome(struct ListNode* head);
struct ListNode * revertNode(struct ListNode *node);

struct ListNode * revertNode(struct ListNode *node) {
    if (node == NULL || node -> next == NULL) return node;
    struct ListNode *preNode = NULL;
    struct ListNode *tempNode = NULL;
    while (node != NULL) {
        tempNode = node -> next;
        node -> next = preNode;
        preNode = node;
        node = tempNode;
    }
    return preNode;
}

bool isPalindrome(struct ListNode* head){
    if (head == NULL || head -> next == NULL) return head;
    struct ListNode *slow = head;
    struct ListNode *fast = head;
    while (fast != NULL && fast -> next != NULL) {
       slow = slow -> next;
       fast = fast -> next -> next;
    }
    struct ListNode *newHead = slow;
    if (slow -> next != NULL) {
        newHead = revertNode(slow -> next);
    }
    while (head != NULL && newHead != NULL) {
        if (head -> val != newHead -> val) return false;
        head = head -> next;
        newHead = newHead -> next;
    }
    return true;
}

void reorderList(struct ListNode* head);
void reorderList(struct ListNode* head){
    if (head == NULL || head -> next == NULL) return;
    struct ListNode *node1 = head;
    struct ListNode *node2 = head;
    while (node2 -> next != NULL && node2 -> next -> next != NULL) {
        node1 = node1 -> next;
        node2 = node2 -> next -> next;
    }
    node2 = node1 -> next;
    node1 -> next = NULL;
    node2 = revertNode(node2);
    struct ListNode *tmpNode = NULL;
    struct ListNode *curNode = head;
    struct ListNode *nextNode = head -> next;
    while (node2 != NULL) {
        tmpNode = node2 -> next;
        curNode -> next = node2;
        node2 -> next = nextNode;
        curNode = nextNode;
        nextNode = nextNode -> next;
        node2 = tmpNode;
    }
    
    while (head != NULL) {
        printf("--------\n");
        printf("%d", head -> val);
        printf("--------\n");
        head = head -> next;
    }
}

struct LRUKeys {
    int key;
    int value;
    int useCount;
    bool hasValue;
};

typedef struct {
    int capacity;
    int occupied;
    int useLessKey;
    struct LRUKeys *keys;
} LRUCache;

LRUCache* lRUCacheCreate(int capacity) {
    LRUCache *cache = (LRUCache *)malloc(sizeof(LRUCache));
    cache -> occupied = 0;
    cache -> useLessKey = 0;
    cache -> capacity = capacity;
    cache -> keys = (struct LRUKeys *)malloc(sizeof(struct LRUKeys) * (capacity + 1));
    for (int i = 0; i <= capacity; i++) {
        struct LRUKeys *key = (struct LRUKeys *)malloc(sizeof(struct LRUKeys));
        key -> key = -1;
        key -> value = -1;
        key -> useCount = 0;
        key -> hasValue = false;
        cache -> keys[i] = *key;
    }
    return cache;
}

bool cacheIsFull(LRUCache* obj) {
    if (obj == NULL) return false;
    return obj -> occupied >= obj -> capacity;
}

int cacheUseLessKey(LRUCache* obj) {
    if (obj == NULL) return -1;
    int useLessKey = 0;
    struct LRUKeys *firstKey = &obj -> keys[0];
    int count = firstKey -> useCount;
    for (int i = 1; i <= obj -> capacity; i++) {
        struct LRUKeys *keys = &obj -> keys[i];
        if (keys -> useCount < count && keys -> hasValue) {
            count = keys -> useCount;
            useLessKey = i;
        }
    }
    return useLessKey;
}

int lRUCacheGet(LRUCache* obj, int key);
int lRUCacheGet(LRUCache* obj, int key) {
    if (obj == NULL) return -1;
    int mask = key & obj -> capacity;
    struct LRUKeys *keys = &obj -> keys[mask];
    if (!keys -> hasValue) return -1;
    if (keys -> key != key) return -1;
    keys -> useCount++;
    obj -> keys[mask] = *keys;
    return keys -> value;
}

void lRUCachePut(LRUCache* obj, int key, int value);
void lRUCachePut(LRUCache* obj, int key, int value) {
    if (obj == NULL) return;
    int mask = key & obj -> capacity;
    if (cacheIsFull(obj)) {
        int useLessKey = cacheUseLessKey(obj);
        struct LRUKeys *keys = &obj -> keys[useLessKey];
        keys -> key = -1;
        keys -> value = -1;
        keys -> useCount = 0;
        keys -> hasValue = false;
        obj -> keys[mask] = *keys;
        obj -> occupied--;
    }
    struct LRUKeys *keys = &obj -> keys[mask];
    if (mask == key && lRUCacheGet(obj, key) != -1) {
        int newKey = key - 1;
        while (newKey >= 0) {
            if (lRUCacheGet(obj, newKey & obj -> capacity) == -1) {
                mask = newKey & obj -> capacity;
                break;
            }
            newKey--;
        }
    }
    
    keys -> key = key;
    keys -> value = value;
    keys -> useCount++;
    keys -> hasValue = true;
    obj -> keys[mask] = *keys;
    obj -> occupied++;
}

void lRUCacheFree(LRUCache* obj) {
    free(obj);
}

bool checkInclusion(char * s1, char * s2);
bool checkInclusion(char * s1, char * s2){
    int s1Length = strlen(s1);
    int s2Length = strlen(s2);
    if (s1Length > s2Length) return false;
    int value = 0, tempValue = 0;
    for (int i = 0; i < s1Length; i++) {
        value += s1[i] - 'a';
    }
    bool hasFind = false;
    for (int i = 0; i + s1Length <= s2Length; i++) {
        tempValue = 0;
        for (int j = i; j < s1Length + i; j++) {
            tempValue += s2[j] - 'a';
        }
        if (value == tempValue) {
            hasFind = true;
            break;
        }
    }
    return hasFind;
}

int firstUniqChar(char * s);
int firstUniqChar(char * s){
    int res = -1;
    unsigned long length = strlen(s);
    if (length < 1) return res;
    if (length == 1) return 0;
    char max = 'a', min = 'a';
    for (int i = 0; i < length; i++) {
        if (s[i] > max) max = s[i];
        if (s[i] < min) min = s[i];
    }
    int count = max - 'a' + min - 'a' + 1;
    int *maps = (int *)malloc(sizeof(int) * count);
    for (int i = 0; i < count; i++) {
        maps[i] = -1;
    }
    for (int i = 0; i < length; i++) {
        if (maps[s[i] - 'a'] == 1) continue;
        bool isSignle = true;
        for (int j = i + 1; j < length; j++) {
            if ((s[i] ^ s[j]) == 0) {
                isSignle = false;
                break;
            }
        }
        if (isSignle) {
            res = i;
            break;
        }
        maps[s[i] - 'a'] = 1;
    }
    return res;
}

bool isAnagram(char * s, char * t);
bool isAnagram(char * s, char * t){
    unsigned long sLength = strlen(s);
    unsigned long tLength = strlen(t);
    if (tLength != sLength) return false;
    char max = 'a', min = 'a';
    for (int i = 0; i < tLength; i++) {
        if (t[i] > max) max = t[i];
        if (t[i] < min) min = t[i];
        if (s[i] > max) max = s[i];
        if (s[i] < min) min = s[i];
    }
    int mapCount = max - 'a' + min - 'a' + 1;
    int *maps = (int *)malloc(sizeof(int) * mapCount);
    for (int i = 0; i < mapCount; i++) {
        maps[i] = 0;
    }
    for (int i = 0; i < tLength; i++) {
        if (maps[t[i] - 'a'] == 0) {
            maps[t[i] - 'a'] = 1;
        } else {
            maps[t[i] - 'a'] += 1;
        }
    }
    int count = 0;
    for (int i = 0; i < sLength; i++) {
        if (maps[s[i] - 'a'] != 0) count++;
        maps[s[i] - 'a'] -= 1;
    }
    return count == sLength ? true : false;
}

bool isUnique(char* astr) {
    int length = strlen(astr);
    if (length < 1) return false;
    for (int i = 0; i < length - 1; i++) {
        for (int j = i + 1; j < length; j++) {
            if (astr[i] == astr[j]) {
                return false;
            }
        }
    }
    return true;
}

bool canPermutePalindrome(char* s);
bool canPermutePalindrome(char* s){
    int length = strlen(s);
    if (length < 1) return false;
    int max = s[0] - 'a', min = s[0] - 'a';
    for (int i = 1; i < length; i++) {
        if (s[i] < min) min = s[i] - 'a';
        if (s[i] > max) min = s[i] - 'a';
    }
    int mapCount = max - min + 1;
    int *map = (int *)malloc(sizeof(int) * mapCount);
    for (int i = 0; i < mapCount; i++) {
        map[i] = 0;
    }
    for (int i = 0; i < length; i++) {
        if (map[s[i] - 'a'] >= 1) {
            map[s[i] - 'a'] += 1;
        } else {
            map[s[i] - 'a'] = 1;
        }
    }
    bool ans = true;
    bool isEven = false;
    bool isFlag = false;
    if ((length & 1) == 0) isEven = true;
    for (int i = 0; i < length; i++) {
        int count = map[s[i] - 'a'];
        if (isEven) {
            if ((count & 1) != 0) {
                ans = false;
                break;
            }
        } else {
            if (count != length) {
                if ((count & 1) != 0) {
                    if (isFlag) {
                        ans = false;
                        break;
                    }
                    isFlag = true;
                }
            }
        }
    }
    return ans;
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
        
//        intToRoman(1994);
        
//        int num[4] = {1,2,2,4};
//        int num[4] = {1,3,5,6};
//        int numSize = 0;
//        int *p = num;
//        int *q = &numSize;
//        getMaximumXor(p, 4, 2, q);
//        searchInsert(num, 4, 4);
//        findErrorNums(num, 4, 2);
        
        struct ListNode *head = (struct ListNode *)malloc(sizeof(struct ListNode));
        struct ListNode *headPtr;
        head -> val = 1;
        head -> next = NULL;
        headPtr = head;
        
        struct ListNode *node1 = (struct ListNode *)malloc(sizeof(struct ListNode));;
        node1 -> val = 2;
        node1 -> next = NULL;
        headPtr -> next = node1;
        headPtr = node1;
        
        struct ListNode *node2 = (struct ListNode *)malloc(sizeof(struct ListNode));;
        node2 -> val = 3;
        node2 -> next = NULL;
        headPtr -> next = node2;
        headPtr = node2;

        struct ListNode *node3 = (struct ListNode *)malloc(sizeof(struct ListNode));;
        node3 -> val = 4;
        node3 -> next = NULL;
        headPtr -> next = node3;
        headPtr = node3;
//        "kitten"
//        "sitting"
//        isPalindrome(head);
//        char *s1 = "kitten";
//        char *s2 = "sitting";
        //checkInclusion(s1, s2);
        
//        char *s = "loveleetcode";
//        firstUniqChar(s);
        
        struct ListNode *node4 = (struct ListNode *)malloc(sizeof(struct ListNode));;
        node4 -> val = 5;
        node4 -> next = NULL;
        headPtr -> next = node4;
        headPtr = node4;
        
//        isPalindrome(head);
        
        //reorderList(head);
        
//        ["LRUCache","put","put","get","put","get","put","get","get","get"]
//        [[2],[1,1],[2,2],[1],[3,3],[2],[4,4],[1],[3],[4]]
//        [null,null,null,1,null,-1,null,-1,3,4]
//        ["LRUCache","put","get","put","get","get"]
//        [[1],[2,1],[2],[3,2],[2],[3]]
        
//        ["LRUCache","put","put","get","put","put","get"]
//        [[2],[2,1],[2,2],[2],[1,1],[4,1],[2]]
//        LRUCache *cache = lRUCacheCreate(2);
//        lRUCachePut(cache, 2, 1);
//        lRUCachePut(cache, 2, 2);
//        printf("\nget(2)%d\n", lRUCacheGet(cache, 2));
//        lRUCachePut(cache, 1, 1);
//        lRUCachePut(cache, 4, 1);
//        printf("\nget(2)%d\n", lRUCacheGet(cache, 2));
//        lRUCachePut(cache, 4, 4);
//        printf("\nget(2)%d\n", lRUCacheGet(cache, 2));
//        printf("\nget(2)%d\n", lRUCacheGet(cache, 3));
//        printf("\nget(2)%d\n", lRUCacheGet(cache, 4));
        char *s = "tactcoa";
        canPermutePalindrome(s);
    }
    return 0;
}
