%{
#include "heading.h"
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

program:	/* empty */  {printf("program -> epsilon\n");} 
                | function {printf("program -> function\n");};

function:       FUNCTION IDENT SEMICOLON BEGIN_PARAMS dec_loop END_PARAMS BEGIN_LOCALS dec_loop 
                    END_LOCALS BEGIN_BODY statement SEMICOLON statement_loop END_BODY;

dec_loop:       declaration SEMICOLON | declaration SEMICOLON dec_loop;

declaration:    ident_loop COLON INTEGER 
                | ident_loop COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER;

ident_loop:     IDENT| IDENT COMMA ident_loop;    	

statement:      var ASSIGN expression
                | if_state
                | while_state
                | dowhile_state
                | read_state
                | write_state
                | CONTINUE | RETURN expression;
if_state:       IF bool_expr THEN statement SEMICOLON statement_loop else_loop ENDIF; 
        

while_state:    WHILE bool_expr BEGINLOOP statement SEMICOLON statement_loop ENDLOOP;

dowhile_state:   DO BEGINLOOP statement SEMICOLON statement_loop ENDLOOP WHILE bool_expr;

read_state:     READ var_loop;

write_state:    WRITE var_loop;

var_loop:       var | var COMMA var_loop;

else_loop:      /* empty */  
                | ELSE statement SEMICOLON statement_loop;

statement_loop: /* empty */ 
                | statement SEMICOLON statement_loop; 

bool_expr:      relation_and_expr | OR relation_and_expr;

relation_and_expr:  relation_expr | AND relation_expr;

relation_expr:  NOT relation_expr
                | expression comp expression
                | TRUE
                | FALSE
                | L_PAREN bool_expr R_PAREN;

comp:	        EQ {cout << "comp -> EQ" << endl;}
		| NEQ {cout << "comp -> NEQ" << endl;}
		| LT {cout << "comp -> LT" << endl;}
		| GT {cout << "comp -> GT" << endl;}
		| LTE {cout << "comp -> LTE" << endl;}
		| GTE {cout << "comp -> GTE" << endl;};

para:           expression | expression COMMA para;
t3:             IDENT L_PAREN para R_PAREN | IDENT L_PAREN R_PAREN;  
t2:             SUB t1;
t1:             var | NUMBER | R_PAREN expression L_PAREN;
term:           t1 | t2 | t3;
multi_express:  term | term MULT term | term DIV term | term MOD term;
expression:     multi_express | multi_express ADD multi_express | multi_express SUB multi_express;
var:            IDENT | IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET;


%%
