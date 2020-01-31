 //Implementation of Lexical Analyzer using Lex tool
%{
int COMMENT=0;
int COUNT[8]={0}; int LINE=1;
%}
identifier [a-zA-Z_][a-zA-Z0-9]*
line .*\n
%%

line {printf("%d %s", LINE++, yytext);}
#.* {printf("\n %s is a preprocessor directive",yytext);}
auto|double|int|struct|break|else|long|switch|case|enum|register|typedef|char|extern|return|union|continue|for|signed|void|do|if|static|while|default|goto|sizeof|volatile|const|float|short {printf("\n %s is KEYWORD", yytext);}

"/*" {COMMENT=1;}{printf("\n %s is a COMMENT",yytext);}
{identifier}\( {COUNT[0]++;if(!COMMENT)printf("\n FUNCTION \n%s",yytext);}
{identifier}(\[[0-9]*\])? {if(!COMMENT) printf("\n %s IDENTIFIER",yytext);}
\".*\" {if(!COMMENT)printf("\n %s is a STRING",yytext);}
\{|\}|","|";"|\.|":"|\(|\)|\[|\] {if(!COMMENT)ECHO;printf("\nSEPARATOR");}
[0-9]+ {if(!COMMENT) printf("\n %s is a NUMBER ",yytext);}
\)(\:)? {if(!COMMENT)ECHO;printf("\n");}
= {if(!COMMENT)printf("\n %s is an ASSIGNMENT OPERATOR",yytext);}
\<=|\>=|\<|==|\> {if(!COMMENT) printf("\n %s is a RELATIONAL OPERATOR",yytext);}
"+"|"-"|"/"|"%" {if(!COMMENT) printf("\n %s is an OPERATOR", yytext);}

%%

int main(int argc, char **argv)
{
    if(argc < 2){
        printf("Enter a file!");
        return 1;
    }
    FILE *inputFile, *outputFile;
    inputFile = fopen(argv[1], "r");
    if(!inputFile){
        printf("Error opening file!");
        exit(0);
    }
    yyin = inputFile;
    yylex();
    printf("\n %d", LINE);
    return 0;
}
int yywrap()
{
return(1);
}
