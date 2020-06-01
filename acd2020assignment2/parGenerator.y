%{
#include <stdio.h>
#include <stdlib.h>
extern FILE* yyin;
int yylex();
void yyerror();
%}
%left '+' '-'
%token ELSE
%token IF
%token FOR
%token NUM
%token IDENTIFIER
%token RELATIONALOP
%token ASSIGNMENTOP
%token INCREMENT
%start statements
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE
%%

statements : statements statement
      |
      ;

statement : ';'
     | expression ';'
     | IF'(' expression ')' statement %prec LOWER_THAN_ELSE 
     | IF '(' expression ')' statement ELSE statement 
     | FOR '(' expression ';' expression ';' expression ')' statement 
     | '{' statements '}' ;
     ;

expression : expression '+' term
           | expression '-' term
           | expression RELATIONALOP term
           | expression ASSIGNMENTOP term
           | expression INCREMENT
           | term
           ;

term : term '*' factor
     | term '/' factor
     | factor
     ;

factor : '(' expression ')'
       | '-' factor
       | IDENTIFIER
       | NUM
       ;
%%

extern int yylineno;
extern char* yytext;
void yyerror(char *msg) {
     printf("%d: %s\n", (yylineno) ,msg);
     exit(0);
}

int main() {
    FILE* inputFile = fopen("input.txt","r");
    yyin = inputFile;
    yyparse();
    printf("OK");
    return 0;
}