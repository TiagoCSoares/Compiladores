%{
#include "lexico.c"
%}

%token NUM
%token MAIS
%token MENOS
%token ENTER

%start comando

%%
comando : comando expr ENTER ;
    | ;

expr : NUM
    | expr MAIS expr
    | expr MENOS expr
    ;
%%

void yyerror (char *s) {
    printf("ERRO: %s\n\n", s);
    exit(10);
}

int main (void) {
    if yyparse()
        puts("aceita!");
    else
        puts("rejeita!");
}