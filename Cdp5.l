%{
#include <stdio.h>
#include <stdlib.h>

void E();
void error();

int lookahead;

%}

%option noyywrap

%%

"+"    { lookahead = getchar(); E(); E(); break; }
"-"    { lookahead = getchar(); E(); E(); break; }
"a"    { lookahead = getchar(); break; }
"b"    { lookahead = getchar(); break; }
.      { error(); }
%%

void E() {
    switch(lookahead) {
        case '+':
        case '-':
            lookahead = getchar();
            E();
            E();
            break;
        case 'a':
        case 'b':
            lookahead = getchar();
            break;
        default:
            error();
    }
}

void error() {
    printf("Syntax Error\n");
    exit(1);
}

int main() {
    printf("Enter an expression: ");
    lookahead = getchar();
    E();
    if (lookahead == '\n') {
        printf("Syntax Accepted\n");
    } else {
        error();
    }
    return 0;
}

