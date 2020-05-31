yacc -d parGenerator.y
lex lexGenerator.l
gcc lex.yy.c y.tab.c
./a.out