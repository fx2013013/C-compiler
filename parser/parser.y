%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char*);
#define YYSTYPE char *
int yylex();
%}

%token ELSE IF INT RETURN VOID WHILE
%token ADD SUB
%token MUL DIV LESS_THAN LESS_EQUAL_THAN GREAT_THAN
%token GREAT_EQUAL_THAN DOUBLE_EQUAL NOT_EQUAL EQUAL
%token SEMICOLON COMMA L_PARENTHESIS R_PARENTHESIS
%token L_SQUARE_BRACKET R_SQUARE_BRACKET L_BRACE R_BRACE
%token ANNOTATION MULTI_LINE_ANNOTATION NUM ID


%left EQUAL
%left ADD SUB
%left MUL DIV

%%
program : declaration_list { }
        ;

declaration_list    : declaration_list declaration                                                      { }
                    | declaration                                                                       { }
                    ;

declaration     : var_declaration                                                                       { }
                | fun_declaration                                                                       { }
                ;

var_declaration : type_specifier ID SEMICOLON                                                           { }
                | type_specifier ID L_SQUARE_BRACKET NUM R_SQUARE_BRACKET SEMICOLON                     { }
                ;

type_specifier  : INT                                                                                   { }
                | VOID                                                                                  { }
                ;

fun_declaration     : type_specifier ID L_PARENTHESIS params R_PARENTHESIS { }
                    | compound_stmt                             {}
                    ;

params  : param_list { }
        | VOID { }
        ;

param_list  : param_list COMMA param { }
            | param     { }
            ;

param   : type_specifier ID { }
        | type_specifier ID L_SQUARE_BRACKET R_SQUARE_BRACKET { }
        ;

compound_stmt   : L_BRACE local_declarations statement_list R_BRACE { }
                ;

local_declarations  : local_declarations var_declaration { }
                    |  { }
                    ;

statement_list  : statement_list statement { }
                | { }
                ;

statement   : expression_stmt { }
            | compound_stmt {   }
            | selection_stmt { }
            | iteration_stmt { }
            | return_stmt { }
            ;

expression_stmt : expression SEMICOLON { }
                | SEMICOLON            { }
                ;

selection_stmt  : IF L_PARENTHESIS expression R_PARENTHESIS statement ELSE statement { }
                | IF L_PARENTHESIS expression R_PARENTHESIS statement { }
                ;

iteration_stmt  :   WHILE L_PARENTHESIS expression R_PARENTHESIS statement { }
                ;

return_stmt : RETURN SEMICOLON { }
            | RETURN expression SEMICOLON { }
            ;

expression  : var EQUAL expression    { }
            |   simple_expression   { }
            ;

var     : ID { }
        | ID L_SQUARE_BRACKET expression R_SQUARE_BRACKET { }
        ;

simple_expression       : additive_expression relop additive_expression { }
                        | additive_expression   { }
                        ;

relop   :   LESS_EQUAL_THAN     { }
        |   LESS_THAN     { }
        |   GREAT_THAN    { }
        |   GREAT_EQUAL_THAN    { }
        |   DOUBLE_EQUAL    { }
        |   NOT_EQUAL    { }
        ;

additive_expression     : additive_expression addop term { }
                        | term                           { }
                        ;

addop   :   ADD { }
        |   SUB { }
        ;

term    : term mulop factor { }
        | factor            {  }
        ;

mulop   :   MUL { }
        |   DIV { }
        ;


factor  :   L_PARENTHESIS expression R_PARENTHESIS { }
        | var                  { }
        | call                 { }
        | NUM                { }
        ;

call        : ID L_PARENTHESIS args R_PARENTHESIS     {}
            ;

args        : arg_list    {  }
            |  { }
            ;

arg_list    : arg_list COMMA expression { }
            | expression              { }
            ;

%%

int main() {
    return yyparse();
}