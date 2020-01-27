/*Definition Section*/

%{
#include<stdio.h>
%}

/*Rule Section*/

%%

auto|double|int|struct|break|else|long|switch|case|enum|register|typedef|char|extern|return|union|continue|for|signed|void|do|if|static|while|default|goto|sizeof|volatile|const|float|short     {ECHO; printf("\nKEYWORD\n");} 						

[{};,()]   {ECHO; printf("\tSEPERATOR\t");}						

[+-/=*%]|&{1,2}   {ECHO; printf("\tOPERATOR\t");}						

([a-zA-Z][0-9])+|[a-zA-Z]* {ECHO; printf("\tIdentifier\t");}    
.|\n ; 															
%%

/*call the yywrap function*/
int yywrap()								
{
return 1;
}


/*Auxiliary function*/
/*Driver function*/

int main(void)
{
/*call the yylex function.*/
yylex();
return 0;
}