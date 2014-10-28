%{
    
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    
    int yylex();
    void yyerror(char *);
    
%}

%token MAIN RETURN
%token CONST ID NUMBER INT
%token IF ELSE FOR WHILE
%token STENCIL FUNC_NAME
%token INC_OP DEC_OP EQ_OP


%%
program:
          statement_list '\n' INT MAIN '('')''{' statement_list RETURN '0' ';' '}'
        ;

statement_list:
          statement
        | statement_list statement
        ;

statement:
          CONST INT statement
        | ID '=' expression ';'
        ;

expression:
          NUMBER
        ;

%%

int main(){
   /* FILE *file = fopen("Sobel.c","r");
     printf("ddd\n");
    
     if(file == NULL){
        printf("File Error!\n");
        return 1;
    }
    
    yyin = file;*/
   
   printf("Entrez une expression : \n");
    yyparse();
    
    //fclose(file);
}

