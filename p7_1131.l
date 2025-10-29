%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t\r\n]+  ;                     /* ignore whitespace */
"+"|"-"|"*"|"/"  { return yytext[0]; }
.           { return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}
