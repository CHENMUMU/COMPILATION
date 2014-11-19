%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "y.tab.h"
    #include "tabSymbol.h"
    
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
{ident}             {yylval.string = yytext; return Ident;}
{stencil}           {printf("stencil\n");return STENCIL;}

"+"                 { return '+';}
"-"                 { return '-';}
"*"                 { return '*';}
"/"                 { return '/';}
"="                 { return '=';}

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