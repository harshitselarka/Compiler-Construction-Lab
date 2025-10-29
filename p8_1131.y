%{
#include <stdio.h>
#include <stdlib.h>
#include "prac8.tab.h"
%}

%%
[0-9]+          { yylval = atoi(yytext); return NUMBER; }
[-+*/()]        { return yytext[0]; }
[ \t]           ;    // ignore spaces and tabs
\n              { return '\n'; }
.               { printf("Unknown character: %s\n", yytext); }
%%

int yywrap(void) {
    return 1;
}
