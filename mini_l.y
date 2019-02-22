%{
#include <stdio.h>
#include <string.h>
int yyerror (char* s);
int yylex (void);
%}

%union{
double val;
char* op;
}

%start	program

%token	FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
%token	INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE
%token	READ WRITE TRUE FALSE RETURN SEMICOLON COLON COMMA

%token <val> NUMBER
%token <op> IDENT

%left	MULT DIV MOD ADD SUB 
%left	EQ NEQ LT GT LTE GTE
%left	L_SQUARE_BRACKET R_SQUARE_BRACKET L_PAREN R_PAREN
%left	AND OR

%right	NOT ASSIGN

%%

program:	/* empty */	{printf("program -> epsilon\n");} 
                | function 	{printf("program -> function\n");};

function:       FUNCTION IDENT SEMICOLON BEGIN_PARAMS dec_loop END_PARAMS BEGIN_LOCALS dec_loop END_LOCALS BEGIN_BODY statement_loop END_BODY
		{printf("FUNCTION IDENT SEMICOLON BEGIN_PARAMS dec_loop END_PARAMS BEGIN_LOCALS dec_loop END_LOCALS BEGIN_BODY statement_loop END_BODY");}
		;

dec_loop:       declaration SEMICOLON 				{printf("dec_loop -> declaration SEMICOLON\n");}
		| declaration SEMICOLON dec_loop		{printf("dec_loop -> declaration SEMICOLON dec_loop\n");}
		;	

declaration:    ident_loop COLON INTEGER 							{printf("declaration -> ident_loop COLON INTEGER\n");}
                | ident_loop COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER	{printf("declaration -> ident_loop COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
		;

ident_loop:     IDENT 				{printf("ident_loop -> IDENT (*$1)\n");}
		| IDENT COMMA ident_loop	{printf("ident_loop -> IDENT COMMA ident_loop\n");}
		; 

statement:      var ASSIGN expression	{printf("statement -> var ASSIGN expression\n");}
                | if_state		{printf("statement -> if_state\n");}
                | while_state		{printf("statement -> while_state\n");}
                | dowhile_state		{printf("statement -> dowhile_state\n");}
                | read_state		{printf("statement -> read_state\n");}
                | write_state		{printf("statement -> write_state\n");}
                | CONTINUE 		{printf("statement -> CONTINUE\n");}
		| RETURN expression	{printf("statement -> RETURN expression\n");}
		;

if_state:       IF bool_expr THEN statement_loop else_loop ENDIF		{printf("if_state -> IF bool_expr THEN statement SEMICOLON statement_loop else_loop ENDIF\n");}
		; 

while_state:    WHILE bool_expr BEGINLOOP statement_loop ENDLOOP		{printf("while_state -> WHILE bool_expr BEGINLOOP statement SEMICOLON statement_loop ENDLOOP\n");}
		;

dowhile_state:	DO BEGINLOOP statement_loop ENDLOOP WHILE bool_expr 		{printf("dowhile_state -> DO BEGINLOOP statement SEMICOLON statement_loop ENDLOOP WHILE bool_expr\n");}
		;

read_state:     READ var_loop		{printf("read_state -> READ var_loop\n");}
		;

write_state:    WRITE var_loop		{printf("write_state -> WRITE var_loop\n");}
		;

var_loop:       var 			{printf("var_loop -> var\n");}
		| var COMMA var_loop	{printf("var_loop -> var COMMA var_loop\n");}
		;

else_loop:      /* empty */					{printf("else_loop -> epsilon\n");}  
                | ELSE statement_loop				{printf("else_loop -> ELSE statement SEMICOLON statement_loop\n");}
		;

statement_loop: statement SEMICOLON			{printf("statement_loop -> epsilon\n");} 
                | statement SEMICOLON statement_loop	{printf("statement_loop -> statement SEMICOLON statement_loop\n");}
		; 

bool_expr:      relation_and_expr 		{printf("bool_expr -> relation_and_expr\n");}
		| OR relation_and_expr		{printf("bool_expr -> OR relation_and_expr\n");}
		;

relation_and_expr:	relation_expr 		{printf("relation_and_expr -> relation_expr\n");}
			| AND relation_expr	{printf("relation_and_expr -> AND relatio_expr\n");}
			;

relation_expr:  NOT relation_expr		{printf("relation_expr -> NOT relation_expr\n");}
                | expression comp expression	{printf("relation_expr -> expression comp expression\n");}
                | TRUE				{printf("relation_expr -> TRUE\n");}
                | FALSE				{printf("relation_expr -> FALSE\n");}
                | L_PAREN bool_expr R_PAREN	{printf("relation_expr -> L_PAREN bool_expr R_PAREN\n");}
		;

comp:	        EQ 		{printf("comp -> EQ\n");}
		| NEQ 		{printf("comp -> NEQ\n");}
		| LT 		{printf("comp -> LT\n");}
		| GT 		{printf("comp -> GT\n");}
		| LTE 		{printf("LTE\n");}
		| GTE 		{printf("GTE\n");}
		;	

para:           expression 			{printf("para -> expression\n");}
		| expression COMMA para		{printf("para -> expression COMMA para\n");}
		;

t2:             IDENT L_PAREN para R_PAREN 	{printf("t3 -> IDENT L_PAREN para R_PAREN\n");}
		| IDENT L_PAREN R_PAREN		{printf("t3 -> IDENT L_PAREN R_PAREN\n");}
		;  

t1:             var 				{printf("t1 -> var\n");}
		| NUMBER 			{printf("t1 -> NUMBER\n");}
		| R_PAREN expression L_PAREN	{printf("t1 -> R_PAREN expression L_PAREN\n");}
		;

term:           t1 				{printf("term -> t1\n");}
                | SUB t1			{printf("term -> SUB t1\n");}
		| t2				{printf("term -> t2\n");}
		;		

multi_express:  term 				{printf("multi_express -> term\n");}
		| term MULT term 		{printf("multi_express -> term MULT term\n");}
		| term DIV term 		{printf("multi_express -> term DIV term\n");}
		| term MOD term			{printf("multi_express -> term MOD term\n");}
		;

expression:     multi_express 				{printf("expression -> multi_express\n");}
		| multi_express ADD multi_express	{printf("expression -> multi_express ADD multi_express\n");}
		| multi_express SUB multi_express	{printf("expression -> multi_express SUB multi_express\n");}
		;

var:            IDENT 								{printf("var -> IDENT\n");}
		| IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET		{printf("IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}
		;


%%

int yyerror(char* s){

    return 0;
}
