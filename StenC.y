%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    
    typedef struct {
        int valeur;
        char* id;
        char* type;
        union {
            struct node* left;
            struct node* right;
            int val;
        }op;
        
    }node;
    
    node  *new_id(char*);
    node  *new_valeur(int);
    node  *new_opration_add(char*,node*,node*);
    node  *new_opration_less(char* type,node* r,node* l);
    node  *new_opration_mul(char* type,node* r,node* l);
    node  *new_opration_div(char* type,node* r,node* l);
    node  *new_opration_equal(char* type,char* id,node* ex);
    
    int yylex();
    void yyerror(char *);

%}

%union
{
    int valeur;
    char *string;
    struct node *n;
    
}


%token <valeur> NUMBER
%token <string> Ident

%type <n> expression
%type <n> statement

%left '+' '-' '*' '%'



%%
program:
          statement '\n'
        ;

statement:
          Ident '=' expression          {$$ = new_opration_equal("equal",$1,$3); /*$$ = new_id($1),printf("%s\n",$1);*/}  //id = id ne marche pas!!
        ;
expression:
          NUMBER                        {$$ = new_valeur($1);printf("Number is: %d\n",$$);}
        | Ident                         {$$ = new_id($1); printf("ID est :   %s\n",$1);}
        | expression '+' expression     {$$ = new_opration_add("add",$1,$3);}
        | expression '-' expression     {$$ = new_opration_less("less",$1,$3);printf("Result: %d\n",$$);}
        | expression '*' expression     {$$ = new_opration_mul("mul",$1,$3);printf("Result: %d\n",$$);}
        | expression '/' expression     {$$ = new_opration_div("div",$1,$3);printf("Result: %d\n",$$);}
        ;

%%

node *new_id(char *id){
    node* new = malloc(sizeof(node));
    new -> id = strdup(id);
    new -> type = "ID";
    return new;
    
}

node  *new_valeur(int val){
    node* new = malloc(sizeof(node));
    new -> valeur = val;
    new -> type = "NUMBER";
    return new;
}

node  *new_opration_add(char* type,node* r,node* l){
    node* new = malloc(sizeof(node));
    new -> type = strdup(type);
    new -> op.right = r;
    new -> op.left = l;
    //if(new->type = "add"){
        printf("type : %s\n ",new->type);
        new -> op.val = r->valeur + l->valeur;
    //}
    /*else if(new->type = "less"){
        printf("type : %s\n ",new->type);
        new -> op.val = r->valeur - l->valeur;
    }
    else if(new->type = "mul"){
        printf("type : %s\n ",new->type);
        new -> op.val = r->valeur * l->valeur;
    }
    else if(new->type = "div"){
        printf("type : %s\n ",new->type);
        new -> op.val = r->valeur / l->valeur;
    };*/
    
    
    
    printf("valeur: %d\n",new -> op.val);
    return new;
}

node  *new_opration_less(char* type,node* r,node* l){
    node* new = malloc(sizeof(node));
    new -> type = strdup(type);
    new -> op.right = r;
    new -> op.left = l;
    printf("type : %s\n ",new->type);
    new -> op.val = r->valeur - l->valeur;
    printf("valeur: %d\n",new -> op.val);
    return new;
}

node  *new_opration_mul(char* type,node* r,node* l){
    node* new = malloc(sizeof(node));
    new -> type = strdup(type);
    new -> op.right = r;
    new -> op.left = l;
    printf("type : %s\n ",new->type);
    new -> op.val = r->valeur * l->valeur;
    printf("valeur: %d\n",new -> op.val);
    return new;
}

node  *new_opration_div(char* type,node* r,node* l){
    node* new = malloc(sizeof(node));
    new -> type = strdup(type);
    new -> op.right = r;
    new -> op.left = l;
    printf("type : %s\n ",new->type);
    new -> op.val = r->valeur / l->valeur;
    printf("valeur: %d\n",new -> op.val);
    return new;
}

node *new_opration_equal(char* type,char* id,node* ex){
    node* new = malloc(sizeof(node));
    new -> type = strdup(type);
    new -> id = strdup(id);
    printf("ID de statement est :  %s\n",new->id);
    new -> valeur = ex->op.val;
    printf("statement: %d\n",new->valeur);
    
    return new;
}


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

