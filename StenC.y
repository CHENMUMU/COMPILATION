%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    
    int yylex();
    void yyerror(char *);
    
%}

%union
{
    int valeur;
    char *string;

}


%token <valeur> NUMBER

%type <valeur> expression_list
%type <valeur> expression

%left '+'


%%
program:
          expression_list '\n'
        ;


expression_list:
            expression '+' expression {$$ = $1 + $3;printf("expression_list est: %d\n",$$);}
          | expression '-' expression {$$ = $1 - $3;printf("expression_list est: %d\n",$$);}
          | expression '*' expression {$$ = $1 * $3;printf("expression_list est: %d\n",$$);}
          | expression '/' expression {$$ = $1 / $3;printf("expression_list est: %d\n",$$);}
        ;

expression:
          NUMBER     {$$ = $1;}
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

