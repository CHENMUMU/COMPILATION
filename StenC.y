%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <stddef.h>
    
    #include "tabSymbol.h"
    #include "quad.h"
    #include "mips.h"
    
    struct symbol *tds;
    int tds_taille = 0;
    
    int yylex();
    void yyerror(char *);

%}

%union
{
    int valeur;
    char *string;
    struct symbol* symbol;
    struct codegen{
        struct symbol* result;
        struct quad* code;
    }codegen;
    
}


%token <valeur> NUMBER
%token <string> Ident
%token   STENCIL ASSIGN


%type <codegen> statement
%type <codegen> expression
//%type <codegen> dis_voisinage
//%type <codegen> nb_dimension id_table


%left '+' '-' '*' '%'



%%
program:
              statement '\n'
               ;

statement:
            expression
{
    printf("Match :-) !\n");
    symbol_print(tds);
    quad_print($1.code);

}
            | Ident ASSIGN expression
{
    printf("ID = expression!\n");
    $$.result = symbol_lookup(tds,$1);
    if($$.result == NULL)
    {
        symbol_add(&tds,$1);
        $$.result = symbol_lookup(tds,$1);
    }
    $$.result -> value = $3.result -> value;
    
    struct quad* new;
    new = quad_gen('=',$3.result, $3.result/* NULL*/, $$.result);
    $$.code = $3.code;
    quad_add(&$$.code,new);
    
    quad_print($$.code);
    symbol_print($$.result);
    
}

/*| WHILE condition DO statement_list DONE
| IF condition THEN statement_list ENDIF
| IF condition THEN statement_list ELSE statement_list ENDIF*/
;


/*        | STENCIL id_table //'=' expression
{
    $$ = $2; printf("dd\n");
    
}
| STENCIL NUMBER {$$ = new_valeur($2); printf("stencil\n");}*/
        ;
/*
id_table:
Ident  dis_voisinage  nb_dimension   {
                                        printf("Le cas du Ident_table ! \n");
                                        struct Pile *p = (struct Pile*)malloc (sizeof(struct Pile));
                                        new_symbol_tab(p,$1,$3,$2);
                                        afficheSymbol(p);
                                        }
        ;

dis_voisinage:
                                       // {$$ = NULL;}//la distance de voisinage peut etre nombre positif ou null
         NUMBER                        {$$ = new_valeur($1);printf("Dis_dimension is: %d\n",$$ -> valeur);}
        ;

nb_dimension:
          NUMBER                        {$$ = new_valeur($1);printf("Nb_dimension is: %d\n",$$ -> valeur);}
        ;

*/

expression:
          NUMBER
{
    printf("exp -> NUMBER(%d)!\n",$1);
    struct symbol *new = $$.result;
    $$.result = symbol_newtemp(&tds,&tds_taille);
   
    $$.result -> isconstant = 1;
    $$.result -> value = $1;
    $$.code = NULL;
    quad_print($$.code);
}


        | Ident
{
    printf("exp -> Ident(%s)!\n",$1);
    $$.result = symbol_lookup(tds,$1);
    if($$.result == NULL)
    {
        symbol_add(&tds,$1);
        $$.result = symbol_lookup(tds,$1);
    }
    $$.code = NULL;
}



        | expression '+' expression
{
    printf("exp -> exp + exp!\n");
    struct quad *new;
    $$.result = symbol_newtemp(&tds,&tds_taille);
    $$.result -> value = $1.result -> value + $3.result -> value;
    new = quad_gen('+',$1.result,$3.result,$$.result);
    $$.code = $1.code;
    quad_add(&$$.code,$3.code);
    quad_add(&$$.code,new);
    quad_print($$.code);
}


        | expression '-' expression
{
    printf("exp -> exp - exp!\n");
    struct quad *new;
    $$.result = symbol_newtemp(&tds,&tds_taille);
    $$.result -> value = $1.result -> value - $3.result -> value;
    new = quad_gen('-',$1.result,$3.result,$$.result);
    $$.code = $1.code;
    quad_add(&$$.code,$3.code);
    quad_add(&$$.code,new);

}


        | expression '*' expression
{
    printf("exp -> exp * exp!\n");
    struct quad *new;
    $$.result = symbol_newtemp(&tds,&tds_taille);
    $$.result -> value = $1.result -> value * $3.result -> value;
    new = quad_gen('*',$1.result,$3.result,$$.result);
    $$.code = $1.code;
    quad_add(&$$.code,$3.code);
    quad_add(&$$.code,new);

}


        | expression '/' expression
{
    printf("exp -> exp / exp!\n");
    struct quad *new;
    $$.result = symbol_newtemp(&tds,&tds_taille);
    $$.result -> value = $1.result -> value / $3.result -> value;
    new = quad_gen('/',$1.result,$3.result,$$.result);
    $$.code = $1.code;
    quad_add(&$$.code,$3.code);
    quad_add(&$$.code,new);

}

        | '(' expression ')'
{
    $$.result = $2.result;
    $$.code = $2.code;
}

        | expression '=' expression
{
    printf("expression = expression!\n");
    
    struct quad *new;
    $1.result = symbol_newtemp(&tds,&tds_taille);
    $1.result -> value = $3.result->value;
    printf("dd\n");
    symbol_print($1.result);
     quad_print($3.code);
    //新建一个quad
    new = quad_gen('=',$3.result,NULL,$1.result);//TODO: 需要将$3的result赋值给$1的id
    
    quad_add(&$1.code,$3.code);
    quad_add(&$1.code,new);
    printf("$1\n");
    quad_print($1.code);
    
    $$.result = $1.result;
    $$.code = $1.code;
    quad_add(&$$.code, $1.code);
}


        | exp_table
        ;


exp_table:
          '{' exp_table ',' exp_table ',' exp_table'}'
        | NUMBER
        ;

%%

extern FILE *yyin;


int main(){
   /* FILE *file = fopen("Sobel.c","r");
     printf("ddd\n");
    
     if(file == NULL){
        printf("File Error!\n");
        return 1;
    }
    
    yyin = file;*/
   
   printf("Entrez une expression : \n");
   //FILE *file = fopen("text.c","r");
   //FILE *res = fopen("mips.s","w");
   
   
   yyparse();
    
   // fclose(file);
    //fclose(res);
}

