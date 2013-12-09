#ifndef _H_ast
#define _H_ast

#include <stdlib.h>   // for NULL
#include "location.h"
#include <iostream>
using namespace std;

class Scope;

class Node  {
  protected:
    yyltype *location;
    Node *parent;
    Scope *scope;

  public:
    Node(yyltype loc);
    Node();
    virtual ~Node() {}

    Scope *GetScope()        { return scope; }
    yyltype *GetLocation()   { return location; }
    void SetParent(Node *p)  { parent = p; }
    Node *GetParent()        { return parent; }
};

class Identifier : public Node
{
  protected:
    char *name;

  public:
    Identifier(yyltype loc, const char *name);
    friend ostream& operator<<(ostream& out, Identifier *id) { return out << id->name; }

    const char* GetName() { return name; }
};

// This node class is designed to represent a portion of the tree that
// encountered syntax errors during parsing. The partial completed tree
// is discarded along with the states being popped, and an instance of
// the Error class can stand in as the placeholder in the parse tree
// when your parser can continue after an error.
class Error : public Node
{
  public:
    Error() : Node() {}
};

#endif
