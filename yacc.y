%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    
    
    
    
%}



%token MAIN RETURN
%token CONST ID NUMBER INT
%token IF ELSE FOR WHILE
%token STENCIL FUNC_NAME
%token INC_OP DEC_OP EQ_OP



%%
program:
        statement_list '\n' INT MAIN'('')''{' statement_list function_list RETURN '0' ';' '}'
        ;


statement_list:
          statement
        | statement_list  statement
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
        ;

id_list
        : ',' ID id_list
        ;

function_list
        : function_list function
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
        ;

exp_equal
        : ID '=' NUMBER
        ;

exp_eq_op
        : ID EQ_OP ID
        ;

exp_compare
        : ID '<' expression
        | ID '>' expression
        ;

exp_add
        : expression '+' expression
        ;

exp_inc_op
        : ID INC_OP
        ;

exp_less
        : expression '-' expression
        ;

exp_dec_op
        : ID DEC_OP
        ;

exp_mul
        : expression '*' expression
        ;

exp_div
        : expression '/' expression
        ;

exp_function
        : FUNC_NAME '(' function_list ')'
        | function_list
        ;


%%

int main(){
    FILE *file = fopen("test.c","r");
    printf("ddd\n");
    
    if(file == NULL){
        printf("File Error!\n");
        return 1;
    }
    
    yyin = file;
    yyparse();
    
    fclose(file);
}


