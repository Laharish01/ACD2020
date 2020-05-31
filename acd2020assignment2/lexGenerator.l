%{
#include <stdio.h>
#include "y.tab.h"
int yylineno; 
%}
IF "if"
ELSE "else"
FOR "for"
NUM [0-9]+(\.[0-9]+)?
IDENTIFIER [a-zA-Z_][a-zA-Z0-9_]* 
ASS =
LEQ <=
GEQ >=
GT >
LT < 

RELATIONALOP {LEQ}|{GEQ}|{GT}|{LT
ASSIGNMENTOP {ASS} 

%%
\n {yylineno++;}
"if" {return IF;}
"else" {return ELSE;}
"for" {return FOR;}
[0-9]+(\.[0-9]+)? {return NUM;}
[a-zA-Z_][a-zA-Z0-9_]* {return IDENTIFIER;}
[-+*/] {return yytext[0];}
[{}();] {return yytext[0];}
[\t\v\r ] {;}
"++" {return INCREMENT;}
"=" {return ASSIGNMENTOP;}
"<=" {return RELATIONALOP;}
">=" {return  RELATIONALOP;}
[<>] {return RELATIONALOP;}
%%

int yywrap(void) {
    return 1;
}