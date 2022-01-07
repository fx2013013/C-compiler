flex scanner.l
bison -vdty parser.y
flex scanner.l
gcc -o parser y.tab.c lex.yy.c
rm lex.yy.c y.tab.c y.tab.h
