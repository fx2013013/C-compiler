%{
#include<stdio.h>
enum TokenType
{
    ELSE                    = 1001,             // else
    IF                      = 1002,             // if
    INT                     = 1003,             // int
    RETURN                  = 1004,             // return
    VOID                    = 1005,             // void
    WHILE                   = 1006,             // while
    ADD                     = 1007,             // +
    SUB                     = 1008,             // -
    MUL                     = 1009,             // /
    DIV                     = 1010,             // /
    LESS_THAN               = 1011,             // <
    LESS_EQUAL_THAN         = 1012,             // <=
    GREAT_THAN              = 1013,             // >
    GREAT_EQUAL_THAN        = 1014,             // >=
    DOUBLE_EQUAL            = 1015,             // ==
    NOT_EQUAL               = 1016,             // !=
    EQUAL                   = 1017,             // =
    SEMICOLON               = 1018,             // ;
    COMMA                   = 1019,             // ,
    L_PARENTHESIS           = 1020,             // (
    R_PARENTHESIS           = 1021,             // )
    L_SQUARE_BRACKET        = 1022,             // [
    R_SQUARE_BRACKET        = 1023,             // ]
    L_BRACE                 = 1024,             // {
    R_BRACE                 = 1025,             // }
    ANNOTATION              = 1026,             // 单行注释
    MULTI_LINE_ANNOTATION   = 1027,             // 多行注释
    NUM                     = 1028,             // 数字
    ID                      = 1029,             // 标识符

};
static char* token_strs[] = {
        "ELSE", "IF", "INT", "RETURN", "VOID", "WHILE", "ADD", "SUB",
        "MUL", "DIV", "LESS_THAN", "LESS_EQUAL_THAN", "GREAT_THAN",
        "GREAT_EQUAL_THAN", "DOUBLE_EQUAL", "NOT_EQUAL", "EQUAL",
        "SEMICOLON", "COMMA", "L_PARENTHESIS", "R_PARENTHESIS",
        "L_SQUARE_BRACKET", "R_SQUARE_BRACKET", "L_BRACE", "R_BRACE",
        "ANNOTATION", "MULTI_LINE_ANNOTATION", "NUM", "ID"
    };
void token_error();
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
"//"[^\n]*                  { return ANNOTATION; }
"/*"[^\n]*"*/"              { return ANNOTATION; }
"/*"[^*]*"*/"               { return MULTI_LINE_ANNOTATION; }
{num}                       { return NUM; }
{id}                        { return ID; }
.                           { token_error(); }
%%

void token_error()
{
    printf("词法错误:line%d:\t\t%s\n", yylineno, yytext);
    exit(0);
}

int main() {
	int token;
	while (token = yylex()) {
		printf("%-20s", token_strs[token-1001]);
		puts(yytext);
	}
	return 0;
}

int yywrap() {
	return 1;
}