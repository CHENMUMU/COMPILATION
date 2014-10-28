YACC = yacc
LEX  = lex
CC = gcc
OBJECT = main   

$(OBJECT): lex.yy.o  y.tab.o
	$(CC) -o $(OBJECT) y.tab.o lex.yy.o  -ll -ly


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