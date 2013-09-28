
%{
#include "symtab.h"
#include "token.h"
%}

%%

\/\/.*          ;
[[:space:]]     ;

GO              return GO;
ROTATE          return TURN; 
DIM             return VAR;
HOP             return JUMP;
FOR             return FOR;
STEP            return STEP;
TO              return TO;
DO              return DO;
START           return COPEN;
END             return CCLOSE;

WHILE		return WHILE;
IF		return IF;
ELSE		return ELSE;
THEN		return THEN;
\{		return OCURLY;
\}		return CCURLY;
\!\=		return NOTEQUAL;
\=\=		return EQUALSEQUALS;
\<		return LESSER;
\<\=		return LESSEREQUAL;
\>		return GREATER;
\>\=		return GREATEREQUAL;


[A-Z][a-z]*.*	insert(yytext);

sin             return SIN;
cos             return COS;
sqrt            return SQRT;

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
