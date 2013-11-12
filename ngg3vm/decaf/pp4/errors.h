#ifndef _errors_h_
#define _errors_h_

#include <string>
#include "location.h"
using namespace std;
class Type;
class Identifier;
class Expr;
class BreakStmt;
class ReturnStmt;
class This;
class Decl;
class Operator;

typedef enum {LookingForType, LookingForClass, LookingForInterface, LookingForVariable, LookingForFunction} reasonT;

class ReportError {
 public:

  // Errors used by scanner
  static void UntermComment(); 
  static void LongIdentifier(yyltype *loc, const char *ident);
  static void UntermString(yyltype *loc, const char *str);
  static void UnrecogChar(yyltype *loc, char ch);

  
  // Errors used by semantic analyzer for declarations
  static void DeclConflict(Decl *newDecl, Decl *prevDecl);
  static void OverrideMismatch(Decl *fnDecl);
  static void InterfaceNotImplemented(Decl *classDecl, Type *intfType);


  // Errors used by semantic analyzer for identifiers
  static void IdentifierNotDeclared(Identifier *ident, reasonT whyNeeded);

  
  // Errors used by semantic analyzer for expressions
  static void IncompatibleOperand(Operator *op, Type *rhs); // unary
  static void IncompatibleOperands(Operator *op, Type *lhs, Type *rhs); // binary
  static void ThisOutsideClassScope(This *th);

  
 // Errors used by semantic analyzer for array acesss & NewArray
  static void BracketsOnNonArray(Expr *baseExpr); 
  static void SubscriptNotInteger(Expr *subscriptExpr);
  static void NewArraySizeNotInteger(Expr *sizeExpr);


  // Errors used by semantic analyzer for function/method calls
  static void NumArgsMismatch(Identifier *fnIdentifier, int numExpected, int numGiven);
  static void ArgMismatch(Expr *arg, int argIndex, Type *given, Type *expected);
  static void PrintArgMismatch(Expr *arg, int argIndex, Type *given);


  // Errors used by semantic analyzer for field access
  static void FieldNotFoundInBase(Identifier *field, Type *base);
  static void InaccessibleField(Identifier *field, Type *base);


  // Errors used by semantic analyzer for control structures
  static void TestNotBoolean(Expr *testExpr);
  static void ReturnMismatch(ReturnStmt *rStmt, Type *given, Type *expected);
  static void BreakOutsideLoop(BreakStmt *bStmt);


  // Generic method to report a printf-style error message
  static void Formatted(yyltype *loc, const char *format, ...);


  // Returns number of error messages printed
  static int NumErrors() { return numErrors; }
  
 private:
  static void UnderlineErrorInLine(const char *line, yyltype *pos);
  static void OutputError(yyltype *loc, string msg);
  static int numErrors;
};
#endif
