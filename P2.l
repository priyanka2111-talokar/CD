%{
#include <stdio.h>
%}

DIGIT       [0-9]
LETTER      [a-zA-Z]
%%
{LETTER}({LETTER}|{DIGIT})*    { printf("Identifier: %s\n", yytext); }
{DIGIT}+                        { printf("Integer Constant: %s\n", yytext); }
{DIGIT}+"."{DIGIT}+             { printf("Real Constant: %s\n", yytext); }
.                               { printf("Invalid Token: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
