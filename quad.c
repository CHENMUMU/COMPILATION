#include "quad.h"
#include "tabSymbol.h"
#include <stdio.h>
#include <stdlib.h>

int nextquad = 0;

struct quad* quad_gen(char op, struct symbol* arg1, struct symbol* arg2,
                      struct symbol* res) {
    struct quad* new = (struct quad*)malloc(sizeof(struct quad));
    new->op = op;
    new->arg1 = arg1;
    new->arg2 = arg2;
    new->res  = res;
    new->next = NULL;
    new->label = nextquad;
    nextquad++;
    return new;
    printf("Label : %d \n",nextquad);
}


void quad_add(struct quad** list, struct quad* new)
{
    if (*list == NULL) {
        *list = new;
    }
    else{
        struct quad* scan = *list;
        while (scan -> next != NULL)
            scan = scan -> next;
        
    scan -> next = new;
    }
}


void quad_print(struct quad* quad){
    printf("La quad est : \n");
    while (quad != NULL) {
       printf("%d %c %7s %7s %7s\n",quad->label, quad->op, quad->arg1->identifier,
               quad->arg2->identifier, quad->res->identifier);
        
        quad = quad->next;
    }
   
}

struct quad_list* newlist(struct quad* quad_source)
{
    printf("dd\n");
    struct quad_list* new = (struct quad_list*)malloc(sizeof(struct quad_list*));
    new -> q = quad_source;
    new -> next = NULL;
    return new;
    
}

struct quad_list* quad_concate(struct quad_list* list1, struct quad_list* list2)
{
    struct quad_list* tmp = list1;
    if (tmp == NULL) {     // Situation 1 : list1 est NULL!
        list1 = list2;
    }
    else
    {
        while (tmp -> next != NULL) {
            tmp = tmp -> next;
        }
        tmp ->next = list2;
    }
    return list1;
}

/*
struct quad_list* complete(struct quad_list list1, int label)
{
    quad_list *tmp = list1;
    while (tmp != NULL) {
        
    }
}*/
