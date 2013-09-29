
%{
#include "symtab.h"
#include "turtle.tab.h"
%}

%%

\/\/.*          ;
[[:space:]]     ;

GO              return GO;
TURN            return TURN; 
VAR             return VAR;
JUMP            return JUMP;
FOR             return FOR;
STEP            return STEP;
TO              return TO;
DO              return DO;
BEGIN           return COPEN;
END             return CCLOSE;

sin             return SIN;
cos             return COS;
sqrt            return SQRT;

WHILE		return WHILE;
IF		return IF;
ELSEIF		return ELSEIF;
ELSE		return ELSE;

\|		return OR;
\&		return AND;

\=\=		return EQUALS;
\!\=		return NOTEQUALS;
\<\=		return LESSEQUALS;
\>\=		return MOREEQUALS;
\<		return LESS;
\>		return MORE;

;               return SEMICOLON;
\+              return PLUS;
-               return MINUS;
\*              return TIMES;
\/              return DIV;
\(              return OPEN;
\)              return CLOSE;
=               return ASSIGN;

[a-z]+          { yylval.n = lookup(yytext); 
                  if (yylval.n==NULL)
		    yylval.n = insert(yytext);
                  return ID;
		}
    
[0-9]+\.[0-9]+  yylval.d = atof(yytext);  return FLOAT;
[0-9]+          yylval.i = atoi(yytext);  return NUMBER;

.               fprintf(stderr,"Unexpected character %c (%2X)\n",yytext[0],yytext[0]);

%%

