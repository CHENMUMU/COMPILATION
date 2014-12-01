
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "tabSymbol.h"

static int symbol_temp_number = 0;

struct symbol* symbol_alloc() {
    struct symbol* new;
    new = (struct symbol*)malloc(sizeof(struct symbol));
    new->identifier = NULL;
    new->value = 0;
    new->isconstant = 0;
    new->next = NULL;
    return new;
}

struct symbol* symbol_newtemp(struct symbol** table, int* tag) {
    struct symbol* scan;
    char nametemp[SYMBOL_MAX_STRING];
    sprintf(nametemp, "temp_%d", *tag);
    symbol_add(table, nametemp);
    (*tag)++;
    scan = *table;
    while (scan->next != NULL)
        scan = scan->next;
    return scan;
}

struct symbol* symbol_lookup(struct symbol* table, char* identifier) {
    while (table != NULL) {
        if (strcmp(table->identifier, identifier) == 0)
            return table;
        table = table->next;
    }
    return NULL;
}

void symbol_add(struct symbol** table, char* identifier) {
    struct symbol* scan;
    
    if (*table == NULL) {
        *table = symbol_alloc();
        (*table)->identifier = strdup(identifier);
    } else {
        scan = *table;
        while (scan->next != NULL)
            scan = scan->next;
        scan->next = symbol_alloc();
        scan->next->identifier = strdup(identifier);
    }
}

void symbol_print(struct symbol* symbol) {
    while (symbol != NULL) {
        printf("id: %7s, isconstant: %d, value: %d\n",
               symbol->identifier, symbol->isconstant, symbol->value);
        symbol = symbol->next;
    }
}
/*

int main(){
    struct Pile *p_tmp = (struct Pile*)malloc(sizeof(struct Pile));
    struct Symbol *s_tmp = (struct Symbol*)malloc(sizeof(struct Symbol));
    init(p_tmp);
    
    //new_symbole(p_tmp,"f",3);
    //new_symbole(p_tmp,"n",5);
    delete_symbol(p_tmp);
    afficheSymbol(p_tmp);
}
*/