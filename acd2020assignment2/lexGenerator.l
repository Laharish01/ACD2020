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
[a-zA-Z_][a-zA-Z0-9_]* {return IDENTIFIER;}
[-+*/] {return yytext[0];}
[{}();] {return yytext[0];}
[\t\v\r ] {;}
"=" {return ASSIGNMENTOP;}
"<=" {return RELATIONALOP;}
">=" {return  RELATIONALOP;}
[<>] {return RELATIONALOP;}
%%