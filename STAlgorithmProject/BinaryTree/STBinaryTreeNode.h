//
//  STBinaryTreeNode.h
//  STAlgorithmProject
//
//  Created by song on 2021/4/9.
//  Copyright © 2021 Knowin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STBinaryTreeNode : NSObject

@property (nonatomic,assign)NSInteger value;
@property (nonatomic,strong)STBinaryTreeNode *leftNode;
@property (nonatomic,strong)STBinaryTreeNode *rightNode;

//创建二叉树
+ (STBinaryTreeNode *)createTreeWithValues:(NSArray *)values;

//二叉树中某个位置的节点（按层次遍历）
+ (STBinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(STBinaryTreeNode *)rootNode;

//向二叉排序树节点添加一个节点
+ (STBinaryTreeNode *)addTreeNode:(STBinaryTreeNode *)treeNode value:(NSInteger)value;

//翻转二叉树
+ (STBinaryTreeNode *)invertBinaryTree:(STBinaryTreeNode *)rootNode;

// 非递归方式翻转
+ (STBinaryTreeNode *)invertBinaryTreeNot:(STBinaryTreeNode *)rootNode;

//先序遍历：先访问根，再遍历左子树，再遍历右子树。典型的递归思想。
+ (void)preOrderTraverseTree:(STBinaryTreeNode *)rootNode handler:(void(^)(STBinaryTreeNode *treeNode))handler;

//中序遍历:先遍历左子树，再访问根，再遍历右子树
+ (void)inOrderTraverseTree:(STBinaryTreeNode *)rootNode handler:(void(^)(STBinaryTreeNode *treeNode))handler;

//后序遍历:先遍历左子树，再遍历右子树，再访问根
+ (void)postOrderTraverseTree:(STBinaryTreeNode *)rootNode handler:(void(^)(STBinaryTreeNode *treeNode))handler;

//层次遍历（广度优先)
+ (void)levelTraverseTree:(STBinaryTreeNode *)rootNode handler:(void(^)(STBinaryTreeNode *treeNode))handler;

//二叉树的宽度
+ (NSInteger)widthOfTree:(STBinaryTreeNode *)rootNode;

//二叉树的所有节点数
+ (NSInteger)numberOfNodesInTree:(STBinaryTreeNode *)rootNode;

//二叉树某层中的节点数
+ (NSInteger)numberOfNodesOnLevel:(NSInteger)level inTree:(STBinaryTreeNode *)rootNode;

//二叉树叶子节点数
+ (NSInteger)numberOfLeafsInTree:(STBinaryTreeNode *)rootNode;

//二叉树最大距离（直径）
+ (NSInteger)maxDistanceOfTree:(STBinaryTreeNode *)rootNode;

@end

NS_ASSUME_NONNULL_END
