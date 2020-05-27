lex lexGenerator.l
yacc -d parGenerator.y
gcc y.tab.c -ll -ly -w
