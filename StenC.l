%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "y.tab.h"
    
%}


chiffre [0-9]

char [a-zA-Z]

mot ({char})+

entier ({chiffre})+

ident {mot}|{mot}{entier}

blank_chars ([ \f\r\t\v]+)

string \"[.]\"                



%%

{entier}  			{yylval.valeur = atoi(yytext); return NUMBER;}
{ident}             {yylval.string = yytext; return Ident;}

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