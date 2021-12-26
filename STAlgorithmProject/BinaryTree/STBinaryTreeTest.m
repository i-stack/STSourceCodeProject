//
//  STBinaryTreeTest.m
//  STAlgorithmProject
//
//  Created by song on 2021/4/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import "STBinaryTreeTest.h"
#import "STBinaryTreeNode.h"

@interface STBinaryTreeTest ()

@property (nonatomic,strong)STBinaryTreeNode *treeNode;

@end

@implementation STBinaryTreeTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _treeNode = [[STBinaryTreeNode alloc]init];
        _treeNode = [STBinaryTreeNode createTreeWithValues:[NSArray arrayWithObjects:@(7),@(6),@(3),@(2),@(1),@(9),@(10),@(12),@(14),@(4),@(14), nil]];
        [STBinaryTreeNode preOrderTraverseTree:_treeNode handler:^(STBinaryTreeNode * _Nonnull treeNode) {
            NSLog(@"%ld", (long)treeNode.value);
        }];
    }
    return self;
}

@end
