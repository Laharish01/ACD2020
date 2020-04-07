%{
#include <stdio.h>
int yylineno; 
%}
%%
\n {yylineno++;}
"if" {return IF;}
"else" {return ELSE;}
"for" {return FOR;}
[0-9]+(\.[0-9]+)? {return NUM;}
[-+*/] {return yytext[0];}
[{}();] {return yytext[0];}
[\t\v\r ] {;}
%%