#ifndef H_AVL_TREE_H
#define H_AVL_TREE_H

#include <stdlib.h>
#include <string.h>

typedef struct HAVLTreeNode
{
    struct HAVLTreeNode * _left_child;
    struct HAVLTreeNode * _right_child;
    int _height;
} HAVLTreeNode;

typedef struct HAVLTree
{
    HAVLTreeNode * _root;
} HAVLTree;

HAVLTree * init_avl_tree();

#endif
