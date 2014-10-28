%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "y.tab.h"
    
    void count();
    
%}


chiffre [0-9]

char [a-zA-Z]

mot ({char})+

entier ({chiffre})+

indent {mot}|{mot}{entier}

int \\INT
stencil \\STENCIL
const \\CONST

string \"[.]\"                 /*STRING 可以用于什么呢?*/



%%

{entier}  			{count();return NUMBER;}
{indent}			{count(); return ID;}


"int"               {count();return INT;}
"stencil"           {count();return STENCIL;}
"const"			    {count(); return CONST;}
"sqrt"              {count(); return FUNC_NAME;}

"$"                 {count(); return '$';}
"+"                 {count(); return '+';}
"-"                 {count(); return '-';}
"*"                 {count(); return '*';}
"/"                 {count(); return '/';}
"="                 {count(); return '=';}

"++"                {count(); return INC_OP;}
"--"                {count(); return DEC_OP;}
"=="                {count(); return EQ_OP; }


"if"                {count(); return IF;}
"else"              {count(); return ELSE;}
"for"               {count(); return FOR;}
"while"             {count(); return WHILE;}


"("                 {count(); return '(';}
")"                 {count(); return ')';}
"{"                 {count(); return '{';}
"}"                 {count(); return '}';}
"["                 {count(); return '[';}
"]"                 {count(); return ']';}

"."                 {count(); return '.';}
";"                 {count(); return ';';}
","                 {count(); return ',';}

[ \t\v\n\f]         {count(); }
.                   { /* ignore bad characters */ }


%%

int column = 0;

void count(){
    int i = 0;
    
    for(i = 0; yytext[i] != '\0'; i++){
        if(yytext[i] == '\n')
        column = 0;
        else if(yytext[i] == '\t')
        column += 8 - (column % 8);
        else
        column++;
        
        ECHO;
    }
}





int main(){
	
	yyin = fopen("./test.c", "r");
	
	if(yyin == NULL)
	{
		fprintf(stderr, "mauvaise déclaraion de fichier\n");
	}
	yylex();
    
    return  0;
}