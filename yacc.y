%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
%}

%token MAIN RETURN
%token CONST ID NUMBER INT
%token IF ELSE FOR WHILE
%token STENCIL FUNC_NAM
%token


%%
program
        : statement_list INT MAIN'('')''{' statement_list function_list RETURN '0' ';' '}'
        ;


statement_list
        : statement
        | statement_list  statement
        | NULL
        ;

statement
        : CONST INT statement
        | ID '=' expression
        | STENCIL id_stencil '=' expr_table
        | INT ID id_list
        | ID '[' NUMBER ']' '[' NUMBER ']'
        ;

id_stencil
        : ID '{' NUMBER '}' ',' NUMBER '}'
        ;

expr_table
        : '{' table table_list '}'
        ;

table
        : '{' NUMBER ',' NUMBER ',' NUMBER '}'
        ;

table_list
        : ',' table_list
        | NULL
        ;

id_list
        : ',' ID id_list
        | NULL
        ;

function_list
        : function_list function
        | NULL
        ;

function
        : function_stencil
        | function_for
        | function_while
        | function_cond
        ;

function_stencil
        : ID '$' statement ',' NUMBER
        ;

function_for
        : FOR '(' exp_for ')' '{' function_list '}'
        ;

exp_for
        : exp_equal ';' exp_compare ';' exp_add
        | exp_equal ';' exp_compare ';' exp_less
        ;

function_while
        : WHILE '(' expression ')' '{'function_list '}'
        ;

function_cond
        : IF '(' expression ')' function_list ELSE function_list
        | IF '(' expression ')' function_list
        ;

expression
        : NUMBER
        | ID
        | exp_equal
        | exp_eq_op
        | exp_compare
        | exp_add
        | exp_inc_op
        | exp_less
        | exp_dec_op
        | exp_mul
        | exp_div
        | exp_function
        ;

exp_list
        : expression exp_list
        | NULL
        ;

exp_equal
        : ID '=' NUMBER
        | ID '==' ID
        | NULL
        ;

exp_eq_op
        : ID '==' ID
        | NULL
        ;

exp_compare
        : ID '<' expression
        | ID '>' expression
        | NULL
        ;

exp_add
        : expression '+' expression
        | NULL
        ;

exp_inc_op
        : ID '++'
        | NULL
        ;

exp_less
        : expression '-' expression
        | NULL
        ;

exp_dec_op
        : ID '--'
        | NULL
        ;

exp_mul
        : expression '*' expression
        ;

exp_div
        : expression '/' expression

exp_function
        : FUNC_NAME '(' function_list ')'
        | function_list
        ;


%%
/*
int main(){
    FILE *file = fopen("test.txt","r");
    
    if(file == NULL){
        printf("File Error!\n");
        return 1;
    }
    
    yyin = file;
    yyparse();
    
    fclose(file);
}
 */

