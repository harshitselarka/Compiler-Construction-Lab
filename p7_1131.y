%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);

%}

%token NUMBER

%%

input:
    /* empty */
  | input line
  ;

line:
    expr '\n'     { printf("Result = %d\n", $1); }
  ;

expr:
    expr expr '+'   { $$ = $1 + $2; }
  | expr expr '-'   { $$ = $1 - $2; }
  | expr expr '*'   { $$ = $1 * $2; }
  | expr expr '/'   { 
                      if ($2 == 0) {
                          yyerror("Division by zero");
                          YYABORT;
                      }
                      $$ = $1 / $2; 
                    }
  | NUMBER          { $$ = $1; }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter postfix expression (end with newline):\n");
    yyparse();
    return 0;
}
