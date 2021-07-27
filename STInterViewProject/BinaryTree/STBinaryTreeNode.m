//
//  STBinaryTreeNode.m
//  STInterViewProject
//
//  Created by song on 2021/4/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STBinaryTreeNode.h"

@interface STBinaryTreeNode()

@end

@implementation STBinaryTreeNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        @property(atomic, strong)NSString *stringA;

        //thread A
        for (int i = 0; i < 100000; i ++) {
            if (i % 2 == 0) {
                self.stringA = @"a very long string";
            } else {
                self.stringA = @"string";
            }
            NSLog(@"Thread A: %@\n", self.stringA);
        }

        //thread B
        for (int i = 0; i < 100000; i ++) {
            if (self.stringA.length >= 10) {
                NSString* subStr = [self.stringA substringWithRange:NSMakeRange(0, 10)];
            }
            NSLog(@"Thread B: %@\n", self.stringA);
        }
    }
    return self;
}

+ (STBinaryTreeNode *)createTreeWithValues:(NSArray *)values {
    STBinaryTreeNode *treeNode = nil;
    for (int i = 0; i < values.count; i++) {
        NSInteger value = [(NSNumber *)[values objectAtIndex:i] integerValue];
        treeNode = [STBinaryTreeNode addTreeNode:treeNode value:value];
    }
    return treeNode;
}

+ (STBinaryTreeNode *)addTreeNode:(STBinaryTreeNode *)treeNode value:(NSInteger)value {
    if (!treeNode) {
        treeNode = [[STBinaryTreeNode alloc]init];
        treeNode.value = value;
    } else if (value <= treeNode.value) {
        treeNode.leftNode = [STBinaryTreeNode addTreeNode:treeNode.leftNode value:value];
    } else {
        treeNode.rightNode = [STBinaryTreeNode addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

+ (void)preOrderTraverseTree:(STBinaryTreeNode *)rootNode handler:(void (^)(STBinaryTreeNode * _Nonnull))handler {
    if (rootNode) {
        if (handler) {
            handler(rootNode);
        }
        [STBinaryTreeNode preOrderTraverseTree:rootNode.leftNode handler:handler];
        [STBinaryTreeNode preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

@end
