%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "y.tab.h"
    #include "tabSymbol.h"
    
    struct symbol *tds;
    
%}


chiffre [0-9]

char [a-zA-Z]

mot ({char})+

entier ({chiffre})+

ident {mot}|{mot}{entier}

blank_chars ([ \f\r\t\v]+)

string \"[.]\"                

stencil \\Stencil

%%

{entier}  			{yylval.valeur = atoi(yytext); return NUMBER;}

{ident}             {yylval.string = yytext;
                    struct symbol* id;
                    id = symbol_lookup(tds,yytext);
                    if(id == NULL)
                    {
                        symbol_add(&tds,yytext);
                        
                    }
                    yylval.string = strdup(yytext);
                     return Ident;}

{stencil}           {printf("stencil\n");return STENCIL;}

"+"                 { return '+';}
"-"                 { return '-';}
"*"                 { return '*';}
"/"                 { return '/';}
"="                 { return ASSIGN;}

"("                 { return '(';}
")"                 { return ')';}
"{"                 { return '{';}
"}"                 { return '}';}
"["                 { return '[';}
"]"                 { return ']';}

"."                 { return '.';}
";"                 { return ';';}
","                 { return ',';}

blank_chars         { }
.                   { /* ignore bad characters */ }


%%