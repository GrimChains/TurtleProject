#ifndef _H_ast
#define _H_ast

#include <stdlib.h>   // for NULL
#include "location.h"
#include <iostream>
using namespace std;

class Node  {
  protected:
    yyltype *location;
    Node *parent;

  public:
    Node(yyltype loc);
    Node();
    virtual ~Node() {}

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
    bool operator==(const Identifier &rhs);
    const char* Name() { return name; }
};

class Error : public Node
{
  public:
    Error() : Node() {}
};

#endif
