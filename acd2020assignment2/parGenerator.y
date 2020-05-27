%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
extern FILE* yyin;
//#include "lex.yy.c"
%}
%token ELSE
%token IF
%token FOR
%token NUM
%token IDENTIFIER
%token RELATIONALOP
%token ASSIGNMENTOP
%start statements 
%%

statements : | statements statement 

statement : ';'
     | expression ';'
     | IF '(' expression ')' statement
     | IF '(' expression ')' statement ELSE statement 
     | FOR '(' expression ';' expression ';' expression ')' statement
     | '{' statements '}'

expression : expression '+' term
           | expression '-' term
           | expression RELATIONALOP term
           | expression ASSIGNMENTOP term
           | term

term : term '*' factor
     | term '/' factor
     | factor

factor : '(' expression ')'
       | '-' factor
       | IDENTIFIER
       | NUM
%%

extern int yylineno;
extern char* yytext;
yyerror(char *msg) {
     printf("%d: %s %s\n", (yylineno),msg, (yytext));
    exit(0);
}

int main() {
    FILE* inputFile = fopen("input.txt","r");
    yyin = inputFile;
    yyparse();
    printf("OK");
    return 0;
}