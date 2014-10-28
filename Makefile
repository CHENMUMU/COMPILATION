#Makefile PROJ
LEX  = flex
YACC = yacc
CC = gcc
OBJECT = main    #生成的目标文件

$(OBJECT): lex.yy.o  yacc.tab.o
	$(CC) lex.yy.o yac.tab.o -o $(OBJECT)

lex.yy.o : lex.yy.c yacc.tab.h
	$(CC) -c yacc.tab.c

yacc.tab.o : yacc.tab.c 
	$(CC) -c yacc.tab.c

yacc.tab.c yacc.tab.h : yacc.y
	$(YACC) -d yacc.y

lex.yy.c : StenC.l
	$(LEX) StenC.l

clean : 
	@rm -f $(OBJECT) *.o