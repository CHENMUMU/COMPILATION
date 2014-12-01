#include "quad.h"


struct quad* quad_gen(char op, struct symbol* arg1, struct symbol* arg2,
                      struct symbol* res) {
    struct quad* new = (struct quad*)malloc(sizeof(struct quad));
    new->op = op;
    new->arg1 = arg1;
    new->arg2 = arg2;
    new->res  = res;
    new->next = NULL;
    return new;
}


void quad_add(struct quad** list, struct quad* new)
{
    if (*list == NULL) {
        *list = new;
    }
    else{
        struct quad* scan = *list;
        while (scan -> next != NULL) {
            scan = scan -> next;
            scan -> next = new;
        }
    }
    
}

void quad_print(struct quad* quad){
    while (quad != NULL) {
        
        //printf("%s\n",quad -> arg1 -> identifier);
       printf("%c %7s %7s %7s\n", quad->op, quad->arg1->identifier,
               quad->arg2->identifier, quad->res->identifier);
        printf("dd\n");
        quad = quad->next;
    }
}