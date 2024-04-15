%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define MAX_RULES 10
#define MAX_LEN 50

char productions[MAX_RULES][MAX_LEN];
char nonTerminals[MAX_RULES];
int numProductions = 0;

void eliminateLeftRecursion() {
    printf("\nGrammar Without Left Recursion:\n\n");
    for (int i = 0; i < numProductions; i++) {
        char pro[MAX_LEN], alpha[MAX_LEN], beta[MAX_LEN];
        int j, index = 3;
        strcpy(pro, productions[i]);
        char nonTerminal = pro[0];
        if (nonTerminal == pro[index]) {
            int hasLeftRecursion = 0;
            for (j = index + 1; pro[j] != '\0'; j++) {
                if (pro[j] == '|') {
                    hasLeftRecursion = 1;
                    break;
                }
            }
            if (hasLeftRecursion) {
                index++;
                int k = 0;
                // Extracting alpha and beta
                for (j = index; pro[j] != '|'; j++) {
                    alpha[k++] = pro[j];
                }
                alpha[k] = '\0';
                k = 0;
                for (j = j + 1; pro[j] != '\0'; j++) {
                    beta[k++] = pro[j];
                }
                beta[k] = '\0';
                printf(" %c -> %s%c'\n", nonTerminal, beta, nonTerminal);
                printf(" %c' -> %s%c'\n", nonTerminal, alpha, nonTerminal);
                printf(" %c' -> epsilon\n", nonTerminal);
            } else {
                printf(" %s\n", productions[i]);
            }
        } else {
            printf(" %s\n", productions[i]);
        }
    }
}

int main() {
    printf("Enter the number of production rules: ");
    scanf("%d", &numProductions);

    printf("Enter the production rules in the form 'E->E|a':\n");

    for (int i = 0; i < numProductions; i++) {
        scanf("%s", productions[i]);
        nonTerminals[i] = productions[i][0];
    }
    eliminateLeftRecursion();
    return 0;
}
%}

%%
[A-Za-z]->[A-Za-z|]+ {
    printf("Production: %s\n", yytext);
    strcpy(productions[numProductions], yytext);
    nonTerminals[numProductions] = yytext[0];
    numProductions++;
}

.|\n ; // Ignore any other characters or newlines
%%

int yywrap() {
    return 1;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}
