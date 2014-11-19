YACC = yacc
LEX  = lex
CC = gcc
OBJECT = main   

$(OBJECT): lex.yy.o  y.tab.o tabSymbol.o quad.o
	$(CC) -o $(OBJECT) y.tab.o lex.yy.o tabSymbol.o quad.o -ll -ly

tabSymbol.o : tabSymbol.c tabSymbol.h
	$(CC) -c tabSymbol.c

quad.o : quad.c quad.h
	$(CC) -c quad.c

y.tab.o : y.tab.c y.tab.h 
	$(CC) -c y.tab.c 


y.tab.c y.tab.h : StenC.y
	$(YACC) -d StenC.y


lex.yy.c : StenC.l
	$(LEX) StenC.l


lex.yy.o : lex.yy.c y.tab.h 
	$(CC) -c lex.yy.c 


clean : 
	@rm -f $(OBJECT) *.o