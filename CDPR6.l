%{
#include <stdio.h>
#include <stdlib.h>
double yylval;
%}

%%
[0-9]+           { yylval = atof(yytext); return '0'; }
[0-9]+[.][0-9]+  { yylval = atof(yytext); return '0'; }
"+"              { return '+'; }
"-"              { return '-'; }
""              { return ' '; }
"/"              { return '/'; }
[ \t\n]          /* Skip whitespace */
.                { printf("Invalid expression: %s\n", yytext); }

%%

int main(void) {
    double result;
    char op;

    printf("Enter operation (operand1 operator operand2):\n");

    while (scanf("%lf %c %lf", &result, &op, &yylval) != EOF) {
        double operand = yylval;
        double answer;
        switch (op) {
            case '+':
                answer = result + operand;
                printf("%s: %.2f\n", "Addition", answer);
                break;
            case '-':
                answer = result - operand;
                printf("%s: %.2f\n", "Subtraction", answer);
                break;
            case '*':
                answer = result * operand;
                printf("%s: %.2f\n", "Multiplication", answer);
                break;
            case '/':
                if (operand != 0) {
                    answer = result / operand;
                    printf("%s: %.2f\n", "Division", answer);
                }
                else {
                    printf("Error: Division by zero\n");
                    continue; // Skip to next iteration
                }
                break;
            default:
                printf("Invalid operation\n");
                continue; // Skip to next iteration
        }
        result = answer;
        printf("\n"); // Print a newline for spacing between operations
    }

    return 0;
}

int yywrap() { return 1; }
