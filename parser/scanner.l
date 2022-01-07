%{
# include <stdio.h>
# include <string.h>
# include "y.tab.h"
#define YYSTYPE char *
void scannerError();
void yyerror(const char *msg);
%}

%option yylineno
delim      [ \t\n]
letter     [a-zA-Z]
digit      [0-9]
id         {letter}({letter}|{digit})*
num        {digit}{digit}*

%%
{delim}+                    {}
"else"                      { return ELSE; }
"if"                        { return IF; }
"int"                       { return INT; }
"return"                    { return RETURN; }
"void"                      { return VOID; }
"while"                     { return WHILE; }
"+"                         { return ADD; }
"-"                         { return SUB; }
"*"                         { return MUL; }
"/"                         { return DIV; }
"<"                         { return LESS_THAN; }
"<="                        { return LESS_EQUAL_THAN; }
">"                         { return GREAT_THAN; }
">="                        { return GREAT_EQUAL_THAN; }
"=="                        { return DOUBLE_EQUAL; }
"!="                        { return NOT_EQUAL; }
"="                         { return EQUAL; }
";"                         { return SEMICOLON; }
","                         { return COMMA; }
"("                         { return L_PARENTHESIS; }
")"                         { return R_PARENTHESIS; }
"["                         { return L_SQUARE_BRACKET; }
"]"                         { return R_SQUARE_BRACKET; }
"{"                         { return L_BRACE; }
"}"                         { return R_BRACE; }
"//"[^\n]*                  {  }
"/*"[^\n]*"*/"              {  }
"/*"[^*]*"*/"               {  }
{num}                       { return NUM; }
{id}                        { return ID; }
.                           { scannerError(); }

%%
void scannerError()
{
    yyerror("词法错误");
}
void yyerror(const char *msg) {
    if(!strcmp(msg ,"syntax error"))
        msg = "语法错误";
    fprintf(stderr, "Error at line %d:%s:'%s'\n", yylineno, msg,yytext);
    exit(-1);
}
int yywrap(){
    return 1;
}