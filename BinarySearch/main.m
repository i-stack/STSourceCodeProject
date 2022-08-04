//
//  main.m
//  BinarySearch
//
//  Created by qcraft on 2022/7/25.
//  Copyright © 2022 qcraft. All rights reserved.
//

#import <Foundation/Foundation.h>

int* testNum(void);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int length = 11;
        int *nums = malloc(sizeof(int *) * length);
        for (int i = 0; i < length; i++) {
            nums[i] = i;
        }
        int findValue = 20;
        int first = 0;
        int base = first;
        int probe = first;
        for (int count = length; count != 0; count >>= 1) {
            probe = base + (count >> 1);
            int probeValue = nums[probe];
            NSLog(@"probe = %d -- base = %d -- count = %d -- probeValue = %d -- findValue = %d", probe, base, count, probeValue, findValue);
            if (probeValue == findValue) {
                break;
            }
            if (probeValue < findValue) {
                base = probe + 1;
                count--;
            }
        }
        NSLog(@"result: probe=%d -- base = %d", probe, base);
        
        int begin = 0;
        int end = length - 1;
        int mid = 0;
        while (begin < end) {
            mid = begin + ((end - begin) >> 1);
            if (nums[mid] == findValue) {
                break;
            } else if (nums[mid] < findValue) {
                begin = mid + 1;
            } else {
                end = mid;
            }
            NSLog(@"begin = %d -- mid = %d -- end = %d -- nums[mid] = %d -- findValue = %d", begin, end, mid, nums[mid], findValue);
        }
        NSLog(@"result: begin = %d -- mid = %d -- end = %d", begin, mid, end);
    }
    return 0;
}




























int* testNum(void) {
    int nums[20] = {1,3,4,6,9,10,20,33,35,39,40,44,46,50,55,80,100,400,500,600};
    int *p = nums;
    return p;
}
