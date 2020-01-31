/* variable declaration for parser*/
%{
    #include<unistd.h>
    int ID=0, KW=0, LINE=1;
%}

line .*\n$
identifier [a-zA-Z_][a-zA-Z0-9]*

/*Definition of rules*/

%%

line {printf("%d %s", LINE++, yytext);}
#.* {printf("%d ",LINE);printf("%s Preprocessor directive\n", yytext);}

(" "auto|double|int|struct|break|else|long|switch|case|enum|register|typedef|char|extern|return|union|continue|for|signed|void|do|if|static|while|default|goto|sizeof|volatile|const|float|short" ") {ECHO; printf(" KEYWORD "); KW++;}

"/*" {}

{identifier} {printf("%s IDENTIFIER", yytext);}
\".*\" {printf("\n\t %s is a STRING",yytext);}

= {printf("\n\t %s is an ASSIGNMENT OPERATOR",yytext);}

%%

int main(int argc, char* argv[]){

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
    printf("\n %d", KW);
    return 0;
}

int yywrap(){
    return 1;
}