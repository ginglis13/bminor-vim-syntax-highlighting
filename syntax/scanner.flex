%{
#include "include/token.h"
#include <string.h>
int linenum = 1;
%}
DIGIT  [0-9]
LETTER [a-zA-Z]
EXTRACHAR [\_\*\-\%\!\&\(\)\{\}\.\+\/\:\;\=\?\[\]\#\$  ]
%%
\n 			{ linenum++; }
(" "|\t|\n)  /* skip whitespace */


\/\*([^\*]|[^\/])*\*\/   //{ return TOKEN_C_COM;  }

\/\/([^\n]*(\\\n)*)*$    //{ return TOKEN_CPP_COM;  }

\"([^\"\n\\]|\\\n|\\.){0,255}\"   { return TOKEN_STRING_LITERAL;  }

\'([^\\\']|\\.|�)\' { return TOKEN_CHAR_LITERAL; } /*\'({LETTER}|{DIGIT}|{EXTRACHAR}){2,}\' {return TOKEN_CHAR_ERROR;}*/

\+         { return TOKEN_ADD;    }
-          { return TOKEN_MINUS;  }
\*         { return TOKEN_MULT; }
\/         { return TOKEN_DIV; }
%          { return TOKEN_MODULO; }
\^         { return TOKEN_EXP; }
\<=         { return TOKEN_LTE; }
\<          { return TOKEN_LT; }
>=         { return TOKEN_GTE; }
>          { return TOKEN_GT; }
==         { return TOKEN_EQ; }
!=         { return TOKEN_NEQ; }
&&         { return TOKEN_AND; }
\|\| 	   { return TOKEN_OR; }
=          { return TOKEN_ASSIGN; }
,          { return TOKEN_COMMA; }
\{          { return TOKEN_LCURLY; }
\}          { return TOKEN_RCURLY; }
! 			{ return TOKEN_NOT; }
while      { return TOKEN_WHILE;  }
for        { return TOKEN_FOR; }
if 		   { return TOKEN_IF; }
else       { return TOKEN_ELSE; }
array      { return TOKEN_ARRAY; }
auto       { return TOKEN_AUTO; }
boolean    { return TOKEN_BOOLEAN; }
char       { return TOKEN_CHAR; }
false      { return TOKEN_FALSE; }
integer    { return TOKEN_INTEGER; }
print      { return TOKEN_PRINT; }
return     { return TOKEN_RETURN; }
string     { return TOKEN_STRING; }
true       { return TOKEN_TRUE; }
void       { return TOKEN_VOID; }
function   { return TOKEN_FUNC;   }

({LETTER}|\_)({LETTER}|{DIGIT}|\_)* { return TOKEN_IDENT; }

{DIGIT}+ {
		/* For checking 64 bit. negative numbers will be checked in parser */
		char *end;
		unsigned long yyval = strtoul(yytext, &end, 10);

		if ( yyval <= (unsigned long)1<<63) {
			return TOKEN_INT;
		}

		return TOKEN_INT_ERROR;
	}

:          { return TOKEN_COLON;  }
;          { return TOKEN_SEMI;   }
--         { return TOKEN_DECREMENT; }
\+\+       { return TOKEN_INCREMENT; }
\(         { return TOKEN_LPARENS; }
\)         { return TOKEN_RPARENS; }
\[         { return TOKEN_LBRACK; }
\]         { return TOKEN_RBRACK; }



.          { printf("Unsuccessful scan\n"); exit(1);  }
%%
int yywrap() { return 1; }
