#include <stdio.h>
#include <assert.h>

#include "havltree.h"


int main(int argc, char ** argv)
{
    HAVLTree * newbie_test_avl_tree = init_avl_tree();
    if (newbie_test_avl_tree != NULL)
    {
        assert(newbie_test_avl_tree->_root == NULL);
    }
    else
    {
        printf("memory is running out.\n");
    }

    free(newbie_test_avl_tree);

    printf("All verification passed.\n");    
    return 0;
}