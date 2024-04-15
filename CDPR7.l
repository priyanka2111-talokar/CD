%{
#include <stdio.h>
#include <stdlib.h>

// Token types
#define NUMBER 256

// Declare yylval
double yylval;

// Function prototypes
double evalPostfix(const char *expr);
%}

%option noyywrap yylineno

%%
[0-9]+(\.[0-9]+)?      { yylval = atof(yytext); return NUMBER; }
[-+*/]                  { return yytext[0]; }
[\n \t]                /* ignore whitespace and newline */ 
.                       { printf("Invalid character: %c\n", yytext[0]); return -1; }
%%

int main() {
    char expr[100];

    printf("Enter a postfix expression: ");
    fgets(expr, sizeof(expr), stdin);

    double result = evalPostfix(expr);
    if (result != -1)
        printf("Result: %g\n", result);

    return 0;
}

double evalPostfix(const char *expr) {
    double stack[100];
    int top = -1;

    for (int i = 0; expr[i] != '\0'; i++) {
        int token = expr[i];

        if (token >= '0' && token <= '9') {
            double number = strtod(&expr[i], NULL);
            stack[++top] = number;
            while (expr[i] >= '0' && expr[i] <= '9' || expr[i] == '.') {
                i++;
            }
            i--;
        } else if (token == '+' || token == '-' || token == '*' || token == '/') {
            if (top < 1) {
                printf("Invalid postfix expression\n");
                return -1;
            }

            double operand2 = stack[top--];
            double operand1 = stack[top--];

            switch (token) {
                case '+':
                    stack[++top] = operand1 + operand2;
                    break;
                case '-':
                    stack[++top] = operand1 - operand2;
                    break;
                case '*':
                    stack[++top] = operand1 * operand2;
                    break;
                case '/':
                    if (operand2 == 0) {
                        printf("Division by zero\n");
                        return -1;
                    }
                    stack[++top] = operand1 / operand2;
                    break;
            }
        }
    }

    if (top != 0) {
        printf("Invalid postfix expression\n");
        return -1;
    }

    return stack[top];
}
