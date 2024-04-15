%{
#include <stdio.h>
#include "lex.yy.c"
int yylex();
int yyerror();
%}

%left '+' '-'
%left '*' '/'

%%

expression: expression '+' expression {
    $$ = $1 + $3;
    printf("+:%d\n", $$);
}
| expression '-' expression {
    $$ = $1 - $3;
    printf("-:%d\n", $$);
}
| expression '*' expression {
    $$ = $1 * $3;
    printf("*:%d\n", $$);
}
| expression '/' expression {
    if ($3 == 0) {
        yyerror("Division by zero");
        exit(1);
    }
    $$ = $1 / $3;
    printf("/: %d\n", $$);
}
| NUMBER {
    $$ = $1;
}
;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("Error: %s\n", s);
    return 0;
}

