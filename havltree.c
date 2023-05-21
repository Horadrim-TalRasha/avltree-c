#include "havltree.h"

HAVLTree * init_avl_tree()
{
    HAVLTree * newbie_tree = (HAVLTree *)malloc(sizeof(HAVLTree));
    if (newbie_tree != NULL)
    {
        newbie_tree->_root = NULL;
    }
    return newbie_tree;
}
