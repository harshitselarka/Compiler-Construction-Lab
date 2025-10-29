%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void decToHex(int decimal, char hexStr[]) {
    char hexDigits[] = "0123456789ABCDEF";
    int i = 0;

    if (decimal == 0) {
        strcpy(hexStr, "0");
        return;
    }

    while (decimal > 0) {
        int remainder = decimal % 16;
        hexStr[i++] = hexDigits[remainder];
        decimal /= 16;
    }

    hexStr[i] = '\0';

    // Reverse the string
    for (int start = 0, end = i - 1; start < end; start++, end--) {
        char temp = hexStr[start];
        hexStr[start] = hexStr[end];
        hexStr[end] = temp;
    }
}
%}

%%
[0-9]+ {
    int decimal = atoi(yytext);     // Convert string to integer
    char hexStr[50];
    decToHex(decimal, hexStr);
    printf("Decimal: %d -> Hexadecimal: %s\n", decimal, hexStr);
}

[ \t\n] ;   // Ignore whitespace
.       ;   // Ignore other characters
%%

int main() {
    printf("Enter decimal numbers (press Ctrl+D to stop):\n");
    yylex(); // Reads from standard input by default
    return 0;
}

int yywrap() {
    return 1;
}
