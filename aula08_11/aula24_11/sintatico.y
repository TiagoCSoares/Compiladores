%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "lexico.c"
%}

%token T_PROGRAMA
%token T_INICIO
%token T_FIM
%token T_LEIA
%token T_ESCREVA
%token T_SE
%token T_ENTAO
%token T_SENAO
%token T_FIMSE
%token T_ENQTO
%token T_FACA
%token T_FIMENQTO
%token T_INTEIRO
%token T_LOGICO
%token T_MAIS
%token T_MENOS
%token T_VEZES
%token T_DIV
%token T_ATRIBUI
%token T_MAIOR
%token T_MENOR
%token T_IGUAL
%token T_E
%token T_OU
%token T_NAO
%token T_ABRE
%token T_FECHA
%token T_V
%token T_F
%token T_IDENTIF
%token T_NUMERO

%start programa

%left T_E T_OU
%left T_IGUAL
%left T_MAIOR T_MENOR
%left T_MAIS T_MENOS
%left T_VEZES T_DIV

%%

programa 
    : cabecalho variaveis T_INICIO lista_comandos T_FIM
        {printf("\tAMEM\tx\n");}
        T_inicio lista_comandos T_FIM
    ;

cabecalho
    : T_PROGRAMA T_IDENTIF
        {printf("\tINPP\n");}
    ;   

variaveis
    : /* vazio */
    | declaracao_variaveis
    ;

declaracao_variaveis
    : tipo lista_variaveis declaracao_variaveis
    | tipo lista_variaveis
    ;

tipo
    : T_LOGICO
    | T_INTEIRO
    ;

lista_variaveis
    :T_IDENTIF lista_variaveis
    | T_IDENTIF
    ;

lista_comandos
    : /* vazio */
    | comando lista_comandos
    ;

comando
    : entrada_saida
    | repeticao
    | selecao
    | atribuicao
    ;

entrada_saida
    : leitura
    | escrita
    ;

leitura
    : T_LEIA T_IDENTIF
        {printf("\tLEIA\n\tARZG\tx");}
    ;

escrita
    : T_ESCREVA expressao
        {printf("\tESCR\n");}
    ;

repeticao
    : T_ENQTO
        {printf("Lx\tNADA\n");} 
    expressao T_FACA 
        {printf("\tDSVF\tLy\n");}
    lista_comandos 
    T_FIMENQTO
        {printf("\tDSVS\tLx\nLy\tNADA\n");}
    ;

selecao
    : T_SE expressao T_ENTAO
        {printf("\tDSVF\tLx\n");}
      lista_comandos T_SENAO 
        {printf("\tDSVS\tLy\nLx\tNADA\n");}
      lista_comandos T_FIMSE
        {printf("Ly\tNADA\n");}
    ;

atribuicao
    : T_IDENTIF T_ATRIBUI expressao  
        {printf("\tARZG\tx\n");}  
    ;

expressao 
    : expressao T_VEZES expressao
        {printf("\tMULT\n");}
    | expressao T_DIV expressao 
        {printf("\tDIVI\n");}
    | expressao T_MAIS expressao
        {printf("\tSOMA\n");}
    | expressao T_MENOS expressao
        {printf("\tMENOS\n");}
    | expressao T_MAIOR expressao
        {printf("\tCMMA\n");}
    | expressao T_MENOR expressao
        {printf("\tCMME\n");}
    | expressao T_IGUAL expressao
        {printf("\tCMMIG\n");}
    | expressao T_E expressao
        {printf("\tCONJ\n");}
    | expressao T_OU expressao
        {printf("\tDISJ\n");}
    | termo
    ;

termo
    : T_IDENTIF
    | T_NUMERO
    | T_V
    | T_F
    | T_NAO termo
    | T_ABRE expressao T_FECHA
    ;

%%


int main () {
    yyparse();
    puts ("Programa ok!");
}