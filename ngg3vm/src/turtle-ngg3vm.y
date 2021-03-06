
%{
#include <stdio.h>
#include "symtab.h"
%}

%union { int i; node *n; double d;}

%token GO TURN VAR JUMP
%token FOR STEP TO DO
%token COPEN CCLOSE
%token SIN COS SQRT
%token <d> FLOAT
%token <n> ID               
%token <i> NUMBER       
%token SEMICOLON PLUS MINUS TIMES DIV OPEN CLOSE ASSIGN
%token WHILE
%token IF ELSEIF ELSE
%token EQUALS NOTEQUALS LESSEQUALS MOREEQUALS LESS MORE
%token OR AND
%token OCURL CCURL

%type <n> decl
%type <n> decllist

%%
program: head decllist stmtlist tail;

head: { printf("%%!PS Adobe\n"
               "\n"
	       "newpath 0 0 moveto\n"
	       );
      };

tail: { printf("stroke\n"); };

decllist: ;
decllist: decllist decl;

decl: VAR ID SEMICOLON {if (strlen($2->symbol) > 1020) { yyerror(("Variable is too big"));} else { printf("/tlt%s 0 def\n",$2->symbol);}} ;


stmtlist: ;
stmtlist: stmtlist stmt ;

stmt: ID ASSIGN expr SEMICOLON {printf("/tlt%s exch store\n",$1->symbol);} ;
stmt: GO expr SEMICOLON {printf("0 rlineto\n");};
stmt: JUMP expr SEMICOLON {printf("0 rmoveto\n");};
stmt: TURN expr SEMICOLON {printf("rotate\n");};

stmt: WHILE {printf("{ ");} bool {printf("{} {exit} ifelse\n");} curl stmtlist curl {printf("loop\n");};
stmt: IF bool {printf("{ ");} curl stmtlist curl else;

else: {printf("if\n");};
else: ELSE {printf("{ ");} curl stmtlist curl {printf("ifelse\nclosepath\n");};

stmt: FOR ID ASSIGN expr 
          STEP expr
	  TO expr
	  DO {printf("{ /tlt%s exch store\n",$2->symbol);} 
	     block {printf("} for\n");};

block: COPEN stmtlist CCLOSE;
block: stmt;

expr: expr PLUS term { printf("add ");};
expr: expr MINUS term { printf("sub ");};
expr: term;

term: term TIMES factor { printf("mul ");};
term: term DIV NUMBER {if ($3 == 0) {yyerror("Cannot divide by zero.");} else { printf("%f div\n"); }};
term: term DIV factor { printf("div ");};
term: factor;

factor: MINUS atomic { printf("neg ");};
factor: PLUS atomic;
factor: SIN factor { printf("sin ");};
factor: COS factor { printf("cos ");};
factor: SQRT factor { printf("sqrt ");};
factor: atomic;

bool: OPEN expr EQUALS expr CLOSE {printf("eq\n");};
bool: OPEN expr NOTEQUALS expr CLOSE {printf("ne\n");};
bool: OPEN expr LESSEQUALS expr CLOSE {printf("le\n");};
bool: OPEN expr MOREEQUALS expr CLOSE {printf("ge\n");};
bool: OPEN expr MORE expr CLOSE {printf("gt\n");};
bool: OPEN expr LESS expr CLOSE {printf("lt\n");};

curl: OCURL {printf("");};
curl: CCURL {printf("} ");};

atomic: OPEN expr CLOSE;
atomic: NUMBER {printf("%d ",$1);};
atomic: FLOAT {printf("%f ",$1);};
atomic: ID {printf("tlt%s ", $1->symbol);};


%%
int yyerror(char *msg)
{  fprintf(stderr,"Error: %s\n",msg);
   return 0;
}

int main(void)
{   yyparse();
    return 0;
}

