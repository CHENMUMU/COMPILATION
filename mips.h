#ifndef _MIPS_H
#define _MIPS_H

#include "quad.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tabSymbol.h"

FILE* openFile(char*);

void quadGenreate(struct quad*,int i);

void closeFile(FILE* f);


#endif