
/* Tokens.  */
#define GO 258
#define TURN 259
#define VAR 260
#define JUMP 261
#define FOR 262
#define STEP 263
#define TO 264
#define DO 265
#define COPEN 266
#define CCLOSE 267
#define SIN 268
#define COS 269
#define SQRT 270
#define FLOAT 271
#define ID 272
#define NUMBER 273
#define SEMICOLON 274
#define PLUS 275
#define MINUS 276
#define TIMES 277
#define DIV 278
#define OPEN 279
#define CLOSE 280
#define ASSIGN 281
#define WHILE 282
#define IF 283
#define FUNC 284
#define ELSE 285
#define THEN 286
#define OCURLY 287
#define CCURLY 288
#define NOTEQUAL 289
#define EQUALEQUAL 290
#define LESSER 291
#define LESSEREQUAL 292
#define GREATER 293
#define GREATEREQUAL 294

typedef union YYSTYPE
{ int i; node *n; double d;}
        YYSTYPE;
YYSTYPE yylval;

