/*
* Numbers, letters, identifiers
*/
DIGIT 	0|1|2|3|4|5|6|7|8|9
LOWER 	[a-z]
UPPER 	[A-Z]
LETTER 	({LOWER}|{UPPER})
NUMBER 	{DIGIT}+
FLOAT 	{DIGIT}*\.{DIGIT}+
IDENT 	({LETTER}({LETTER}|{DIGIT}|_)*({LETTER}|{DIGIT}))|{LETTER}
/*
* Arithmetic Symbols
*/

ADD 	\+
SUB 	-
MULT 	\*
DIV 	\/
MOD 	%

/*
* Comparison Operators
*/

EQ 	==
NEQ 	<>
LT 	<
GT 	>
LTE 	<=
GTE 	>=

/*
* Other Special Symbols
*/

SEMICOLON		;
COLON 			:
COMMA 			,
L_PAREN 		\(
R_PAREN 		\)
L_SQUARE_BRACKET	\[
R_SQUARE_BRACKET 	\]
ASSIGN :=
WH			" "
TAB			\t
/*
* Reserved Words
*/

FUNCTION	"function"
BEGIN_PARAMS	"beginparams"
END_PARAMS	"endparams"
BEGIN_LOCALS	"beginlocals"
END_LOCALS	"endlocals"
BEGIN_BODY	"beginbody"
END_BODY	"endbody"
INTEGER		"integer"
ARRAY		"array"
OF		"of"
IF		"if"
THEN		"then"
ENDIF		"endif"
ELSE		"else"
WHILE		"while"
DO		"do"
BEGINLOOP	"beginloop"
ENDLOOP		"endloop"
CONTINUE	"continue"
READ		"read"
WRITE		"write"
AND		"and"
OR		"or"
NOT		"not"
TRUE		"true"
FALSE		"false"
RETURN		"return"

/*
* Main function
*/
	 int numLines = 1, numChar = 1;

%%
{ADD} 			{printf("ADD\n");numChar+= yyleng;}
{SUB} 			{printf("SUB\n");numChar+= yyleng;}
{MULT} 			{printf("MULT\n");numChar+= yyleng;}
{MOD} 			{printf("MOD\n");numChar+= yyleng;}
{DIV} 			{printf("DIV\n");numChar+= yyleng;}

{EQ} 			{printf("EQ\n");numChar+= yyleng;}
{NEQ} 			{printf("NEQ\n");numChar+= yyleng;}
{LT} 			{printf("LT\n");numChar+= yyleng;}
{GT} 			{printf("GT\n");numChar+= yyleng;}
{LTE} 			{printf("LTE\n");numChar+= yyleng;}
{GTE} 			{printf("GTE\n");numChar+= yyleng;}

{SEMICOLON} 		{printf("SEMICOLON\n");numChar+= yyleng;}
{COLON} 		{printf("COLON\n");numChar+= yyleng;}
{COMMA} 		{printf("COMMA\n");numChar+= yyleng;}
{L_PAREN} 		{printf("L_PAREN\n");numChar+= yyleng;}
{R_PAREN} 		{printf("R_PAREN\n");numChar+= yyleng;}
{L_SQUARE_BRACKET} 	{printf("L_SQUARE_BRACKET\n");numChar+= yyleng;}
{R_SQUARE_BRACKET} 	{printf("R_SQUARE_BRACKET\n");numChar+= yyleng;}
{ASSIGN} 		{printf("ASSIGN\n");numChar+= yyleng;}

{FUNCTION}		{printf("FUNCTION\n");numChar+= yyleng;}
{BEGIN_PARAMS}		{printf("BEGIN_PARAMS\n");numChar+= yyleng;}
{END_PARAMS}		{printf("END_PARAMS\n");numChar+= yyleng;}
{BEGIN_LOCALS}		{printf("BEGIN_LOCALS\n");numChar+= yyleng;}
{END_LOCALS}		{printf("END_LOCALS\n");return END_LOCALS;}
{BEGIN_BODY}		{printf("BEGIN_BODY\n");return BEGIN_BODY;}
{END_BODY}		{printf("END_BODY\n"); return END_BODY;}
{INTEGER}		{printf("INTEGER\n"); return INTEGER;}
{ARRAY}			{printf("ARRAY\n"); return ARRAY;}
{OF}			{printf("OF\n"); return OF;}
{IF}			{printf("IF\n"); return IF;}
{THEN}			{printf("THEN\n"); return THEN;}
{ENDIF}			{printf("ENDIF\n"); return ENDIF;}
{ELSE}			{printf("ELSE\n"); return ELSE;}
{WHILE}			{printf("WHILE\n"); return WHILE;}
{DO}			{printf("DO\n"); return DO;}
{BEGINLOOP}		{printf("BEGINLOOP\n"); return BEGINLOOP;}
{ENDLOOP}		{printf("ENDLOOP\n"); return ENDLOOP;}
{CONTINUE}		{printf("CONTINUE\n"); return CONTINUE;}
{READ}			{printf("READ\n"); return READ;}
{WRITE}			{printf("WRITE\n"); return WRITE;}
{AND}			{printf("AND\n"); return AND;}
{OR}			{printf("OR\n"); return OR;}
{NOT}			{printf("NOT\n"); return NOT;}
{TRUE}			{printf("TRUE\n"); return TRUE;}
{FALSE}			{printf("FALSE\n"); return FALSE;}
{RETURN}		{printf("RETURN\n"); return RETURN;}

{IDENT} 		{numChar += yyleng; yylval.op = new std::string(yytext); return IDENT;}
{NUMBER} 		{printf("NUMBER %d\n", atoi(yytext));numChar += yyleng;}
{WH}+			{numChar += yyleng;}
\n			{++numLines; numChar = 1;}
{TAB}			{numChar += 3;}
"##".*
{IDENT}_+ 			{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", numLines, numChar, yytext); exit(1);}
(_|{NUMBER})+({IDENT})		{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", numLines, numChar, yytext); exit(1);}
.				{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", numLines, numChar, yytext); exit(1);}

%%
int main(){
    yylex();
    yyparse();
    return 0;
}
