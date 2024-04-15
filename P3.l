%{
#include <stdio.h>
#include <stdlib.h>
%}

INTEGER [-+]?[0-9]+

%%
{INTEGER} {
    long int decimal = strtol(yytext, NULL, 10); // Convert to decimal
    printf("Decimal: %ld\n", decimal);
    printf("Octal: %lo\n", decimal);
    printf("Hexadecimal: %lx\n", decimal);
}
.|\n    ; // Ignore all other characters including newlines
%%

int yywrap() {
    return 1; // Indicate end of input
}

int main() {
    yylex();
    return 0;
}
