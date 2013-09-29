
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
#define WHILE 280
#define EQUALS 281
#define OR 282
#define AND 283
#define NOTEQUALS 284
#define LESSEQUALS 285
#define MOREEQUALS 286
#define LESS 287
#define MORE 288
#define IF 289
#define ELSEIF 290
#define ELSE 291

typedef union YYSTYPE
{ int i; node *n; double d;}
        YYSTYPE;
extern YYSTYPE yylval;

