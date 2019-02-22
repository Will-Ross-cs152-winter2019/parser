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
{END_LOCALS}		{printf("END_LOCALS\n");numChar+= yyleng;}
{BEGIN_BODY}		{printf("BEGIN_BODY\n");numChar+= yyleng;}
{END_BODY}		{printf("END_BODY\n");numChar+= yyleng;}
{INTEGER}		{printf("INTEGER\n");numChar+= yyleng;}
{ARRAY}			{printf("ARRAY\n");numChar+= yyleng;}
{OF}			{printf("OF\n");numChar+= yyleng;}
{IF}			{printf("IF\n");numChar+= yyleng;}
{THEN}			{printf("THEN\n");numChar+= yyleng;}
{ENDIF}			{printf("ENDIF\n");numChar+= yyleng;}
{ELSE}			{printf("ELSE\n");numChar+= yyleng;}
{WHILE}			{printf("WHILE\n");numChar+= yyleng;}
{DO}			{printf("DO\n");numChar+= yyleng;}
{BEGINLOOP}		{printf("BEGINLOOP\n");numChar+= yyleng;}
{ENDLOOP}		{printf("ENDLOOP\n");numChar+= yyleng;}
{CONTINUE}		{printf("CONTINUE\n");numChar+= yyleng;}
{READ}			{printf("READ\n");numChar+= yyleng;}
{WRITE}			{printf("WRITE\n");numChar+= yyleng;}
{AND}			{printf("AND\n");numChar+= yyleng;}
{OR}			{printf("OR\n");numChar+= yyleng;}
{NOT}			{printf("NOT\n");numChar+= yyleng;}
{TRUE}			{printf("TRUE\n");numChar+= yyleng;}
{FALSE}			{printf("FALSE\n");numChar+= yyleng;}
{RETURN}		{printf("RETURN\n");numChar+= yyleng;}

{IDENT} 		{printf("IDENT %s\n", yytext);numChar += yyleng;}
{NUMBER} 		{printf("NUMBER %d\n", atoi(yytext));numChar += yyleng;}
{WH}+			{numChar += yyleng;}
\n			{++numLines; numChar = 1;}
{TAB}			{numChar += 3;}
"##".*
{IDENT}_+ 			{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", numLines, numChar, yytext); exit(1);}
(_|{NUMBER})+({IDENT})	{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", numLines, numChar, yytext); exit(1);}
.				{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", numLines, numChar, yytext); exit(1);}

%%
int main(){
    yylex();
    return 0;
}
