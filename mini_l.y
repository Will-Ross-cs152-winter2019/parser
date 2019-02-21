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

%token	FUNCTIONS BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
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

program:	/* empty */ {printf("program -> epsilon\n");}

function:	

statements:	/* empty */ {cout << "statements -> epsilon" << endl;}
		| statement SEMICOLON statements {cout << "statements -> statement SEMICOLON statements" << endl;};

statement:	var ASSIGN expression {cout << "statement -> var ASSIGN expression" << endl;}
		| READ vars {cout << "statement -> READ vars" << endl;}
		| WRITE vars {cout << "statement -> WRITE vars" << endl;}
		| CONTINUE {cout << "statement -> CONTINUE" << endl;}
		| IF bool_exp THEN statements ENDIF {cout << "IF bool_exp THEN statements ENDIF" << endl;}
		| DO BEGINLOOP statements ENDLOOP WHILE bool_exp {cout << "DO BEGINLOOP statements ENDLOOP WHILE bool_exp" << endl;};

bool_exp:	relation_and_exp {cout << "bool_exp -> relation_and_exp" << endl;}
		| relation_and_exp OR relation_and_exp {cout << "bool_exp -> relation_and_exp OR relation_and_exp" << endl;};
		

comparisons:	EQ {cout << "comp -> EQ" << endl;}
		| NEQ {cout << "comp -> NEQ" << endl;}
		| LT {cout << "comp -> LT" << endl;}
		| GT {cout << "comp -> GT" << endl;}
		| LTE {cout << "comp -> LTE" << endl;}
		| GTE {cout << "comp -> GTE" << endl;};

%%
