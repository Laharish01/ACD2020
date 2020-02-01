 //Implementation of Lexical Analyzer using Lex tool
%{
    #include<stdio.h>
    #include<string.h>
    int COMMENT=0;
    int COUNT[8]={0};
    char identifiers[10][100]; 
%}
identifier [a-zA-Z_][a-zA-Z0-9]*

%%
#.* {
        printf("\n%s is a preprocessor directive",yytext);
    }
auto|double|int|struct|break|else|long|switch|case|enum|register|typedef|char|extern|return|union|continue|for|signed|void|do|if|static|while|default|goto|sizeof|volatile|const|float|short {
        printf("\n %s is KEYWORD", yytext);
    }

"/*" { 
        COMMENT = 1;
        printf("\n\t %s is a COMMENT",yytext);
    }
{identifier}\( {
        if(!COMMENT)printf("\nFUNCTION \n\t%s",yytext);
        strcpy(identifiers[COUNT[0]],yytext);
            COUNT[0]++;
    }
\{  {
        if(!COMMENT)printf("\n BLOCK BEGINS");
    }
\}  {
        if(!COMMENT)printf("BLOCK ENDS ");
    }
{identifier}(\[[0-9]*\])? {
        if(!COMMENT){
            printf("\n %s IDENTIFIER",yytext);
            strcpy(identifiers[COUNT[0]],yytext);
            COUNT[0]++;
        }
    }
\".*\" {
        COMMENT = 0;
        if(!COMMENT)printf("\n\t %s is a STRING",yytext);
    }
[0-9]+ {
        if(!COMMENT) printf("\n %s is a NUMBER ",yytext);
        }
\)(\:)? {
        if(!COMMENT)printf("\n\t");ECHO;printf("\n");
    }
\( ECHO;
= { 
    if(!COMMENT)printf("\n\t %s is an ASSIGNMENT OPERATOR",yytext);
}
\<= |
\>= |
\< |
== |
\> {
        if(!COMMENT) printf("\n\t%s is a RELATIONAL OPERATOR",yytext);
    }
%%

int main(int argc, char **argv)
{
    FILE *file;
    file=fopen("prog_ex.c","r");
    if(!file)
    {
        printf("could not open the file");
        exit(0);
    }
    yyin=file;
    yylex();
    printf("\n");
    printf("%d", COUNT[0]);
    for(int i = 0;i < COUNT[0];i++){
        printf("identifiers are %s \n",identifiers[i]);
    }
    return(0);
}
int yywrap()
{
    return(1);
}
