#ifndef _QUAD_H
#define _QUAD_H

struct quad{
    int label;  // Label comme ID de quad;
    char op;
    struct symbol* arg1;
    struct symbol* arg2;
    struct symbol* res;
    struct quad* next;
};

struct quad_list{
    struct quad* q;
    struct quad_list* next;
};


struct quad* quad_gen(char,struct symbol*,struct symbol*,struct symbol*); 
void quad_add(struct quad**,struct quad*);
void quad_print(struct quad*);

struct quad_list* newlist(struct quad* quad_source);
struct quad_list* quad_concat(struct quad_list* list1, struct quad_list* list2);
struct quad_list* complete(struct quad_list list1, int label);

#endif