#ifndef _SYMBOL_H_
#define _SYMBOL_H_
#define SYMBOL_MAX_STRING 42

struct symbol {
    char* identifier;
    int   isconstant;
    int   value;
    struct symbol* next;
};

struct symbol* symbol_alloc();
struct symbol* symbol_newtemp(struct symbol**, int*);
struct symbol* symbol_lookup(struct symbol*, char*);
void           symbol_add(struct symbol**, char*);
void           symbol_print(struct symbol*);

#endif


