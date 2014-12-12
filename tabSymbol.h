#ifndef _SYMBOL_H_
#define _SYMBOL_H_
#define SYMBOL_MAX_STRING 42

struct symbol {
    char* identifier;
    int   isconstant;
    int   value;
    struct symbol* next;
};



struct symbol* symbol_alloc();  // 给定空间
struct symbol* symbol_newtemp(struct symbol**, int*); //
struct symbol* symbol_lookup(struct symbol*, char*);  // 检查是否已经存在
void           symbol_add(struct symbol**, char*);   //  加入新symbol
void           symbol_print(struct symbol*);         // 输出tab
struct symbol* symbol_replace(struct symbol* source, struct symbol* cible);  //  赋值

#endif


