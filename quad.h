#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "tabSymbol.h"

struct quad {
    char op;
    struct symbol* arg1;
    struct symbol* arg2;
    struct symbol* res;
    struct quad* next;
};


struct quad* quad_gen(char,struct symbol*,struct symbol*,struct symbol*);
void quad_add(struct quad**,struct quad*);
void quad_print(struct quad*);