%baseclass-preinclude "semantics.h"
%lsp-needed

%union
{
  std::string *szoveg;
  type* var_type;
}

%type <var_type> expr;

%token PROGRAM BEGIN_TOKEN END
%token NATURAL BOOLEAN
%token TRUE FALSE
%token NOT
%token SKIP
%token IF THEN ELSE ELSEIF ENDIF
%token WHILE DO DONE
%token READ WRITE
%token <szoveg> IDENTIFIER
%token LEFT_PARENTHESIS RIGHT_PARENTHESIS
%token ASSIGN
%token SEMICOLON
%token NATURAL_LITERAL

%left AND OR
%left EQUAL
%left LESS_THAN GREATER_THAN
%left PLUS MINUS
%left MULTIPLY DIV MOD

%%

start: program
    {
        // std::cout << "start -> program" << std::endl;
    }
;

program: header declarations body
    {
        // std::cout << "program -> header declarations body" << std::endl;
    }
;

header: PROGRAM IDENTIFIER
    {
        // std::cout << "header -> PROGRAM IDENTIFIER" << std::endl;
    }
;

declarations:
    {
        // std::cout << "declarations -> \"\"" << std::endl;
    }
|
declaration declarations
    {
        // std::cout << "declarations -> declaration declarations" << std::endl;
    }
;

declaration: 
    NATURAL IDENTIFIER SEMICOLON
    {
        insertSymbol(natural, *$2);
    }
|
    BOOLEAN IDENTIFIER SEMICOLON
    {
        insertSymbol(boolean, *$2);
    }
;

body: BEGIN_TOKEN expressions END
    {
        // std::cout << "body -> BEGIN_TOKEN statements END" << std::endl;
    }
;

expressions:
expression 
    {
        // std::cout << "expressions -> expression" << std::endl;
    }
|
expression expressions
    {
        // std::cout << "expressions -> expression expressions" << std::endl;
    }
;

expression:
read
    {
        // std::cout << "expression -> read" << std::endl;
    }
|
write
    {
        // std::cout << "expression -> write" << std::endl;
    }
|
assignment
    {
        // std::cout << "expression -> assignment" << std::endl;
    }
|
while_loop
    {
        // std::cout << "expression -> while_loop" << std::endl;
    }
|
if_statement
    {
        // std::cout << "expression -> if_statement" << std::endl;
    }
|
skip
    {
        // std::cout << "expression -> skip" << std::endl;
    }
;

read: READ LEFT_PARENTHESIS IDENTIFIER RIGHT_PARENTHESIS SEMICOLON
    {
        // std::cout << "read -> READ LEFT_PARENTHESIS IDENTIFIER RIGHT_PARENTHESIS SEMICOLON" << std::endl;
    }
;

write: WRITE LEFT_PARENTHESIS expr RIGHT_PARENTHESIS SEMICOLON
    {
        // std::cout << "write -> WRITE LEFT_PARENTHESIS expr RIGHT_PARENTHESIS SEMICOLON" << std::endl;
    }
;

assignment: IDENTIFIER ASSIGN expr SEMICOLON
    {
        // std::cout << "assignment -> IDENTIFIER ASSIGN expr SEMICOLON" << std::endl;
        sym_table::iterator it = symbol_table.find(*$1);
        if(it != symbol_table.end()) {
            assertType(":=", it->second.var_type, it->second.var_type, it->second.var_type, *$3);
        } else {
            undeclared(*$1);
        }
        delete $1;
        delete $3;
    }
;

while_loop: WHILE expr DO expressions DONE
    {
        // std::cout << "while_loop -> WHILE expr DO expressions DONE" << std::endl;
        assertType("while ciklus feltetele", boolean, *$2);
        delete $2;
    }
;

if_statement: IF expr THEN if_second_half
    {
       // std::cout << "if_statement -> IF expr THEN if_second_half" << std::endl;
       assertType("if elagazas feltetele", boolean, *$2);
    }
;

if_second_half:
expressions ENDIF
    {
        // std::cout << "if_second_half -> expressions ENDIF" << std::endl;
    }
|
expressions ELSE expressions ENDIF
    {
        // std::cout << "if_second_half -> expressions ELSE expressions ENDIF" << std::endl;
    }
|
expressions ELSEIF expr THEN if_second_half
    {
        // std::cout << "if_second_half -> expressions ELSEIF expr THEN if_second_half" << std::endl;
    }
;

expr:
TRUE
    {
        // std::cout << "expr -> TRUE" << std::endl;
        $$ = new type(boolean);
    }
|
FALSE
    {
        // std::cout << "expr -> FALSE" << std::endl;
        $$ = new type(boolean);
    }
|
IDENTIFIER
    {
        // std::cout << "expr -> IDENTIFIER" << std::endl;
         if(symbol_table.count(*$1) != 0) {
            $$ = new type(symbol_table[*$1].var_type);
        } else {
            undeclared(*$1);
        }
        delete $1;
    }
|
NATURAL_LITERAL
    {
        // std::cout << "expr -> NATURAL_LITERAL" << std::endl;
        $$ = new type(natural);
    }
|
expr EQUAL expr
    {
        // std::cout << "expr -> expr EQUAL expr" << std::endl;
         if(assertType("=", *$1, *$1, *$1, *$3)) {
            $$ = new type(boolean);
        }
        delete $1;
        delete $3;
    }
|
LEFT_PARENTHESIS expr RIGHT_PARENTHESIS
    {
        // std::cout << "expr -> LEFT_PARENTHESIS expr RIGHT_PARENTHESIS" << std::endl;
        $$ = $2;
    }
|
NOT expr
    {
        // std::cout << "expr -> NOT expr" << std::endl;
        assertType("not", boolean, *$2);
        $$ = new type(boolean);
        delete $2;
    }
|
expr AND expr
    {
        // std::cout << "expr -> expr AND expr" << std::endl;
        assertType("and", boolean, boolean, *$1, *$3);
        $$ = new type(boolean);
        delete $1;
        delete $3;
    }
|
expr OR expr
    {
        // std::cout << "expr -> expr OR expr" << std::endl;
        assertType("or", boolean, boolean, *$1, *$3);
        $$ = new type(boolean);
        delete $1;
        delete $3;
    }
|
expr LESS_THAN expr
    {
        // std::cout << "expr -> expr LESS_THAN expr" << std::endl;
        assertType("<", natural, natural, *$1, *$3);
        $$ = new type(boolean);
        delete $1;
        delete $3;
    }
|
expr GREATER_THAN expr
    {
        // std::cout << "expr -> expr GREATER_THAN expr" << std::endl;
        assertType(">", natural, natural, *$1, *$3);
        $$ = new type(boolean);
        delete $1;
        delete $3;
    }
|
expr PLUS expr
    {
        // std::cout << "expr -> expr PLUS expr" << std::endl;
        assertType("+", natural, natural, *$1, *$3);
        $$ = new type(natural);
        delete $1;
        delete $3;
    }
|
expr MINUS expr
    {
        // std::cout << "expr -> expr MINUS expr" << std::endl;
        assertType("-", natural, natural, *$1, *$3);
        $$ = new type(natural);
        delete $1;
        delete $3;
    }
|
expr MULTIPLY expr
    {
        // std::cout << "expr -> expr MULTIPLY expr" << std::endl; 
        assertType("*", natural, natural, *$1, *$3);
        $$ = new type(natural);
        delete $1;
        delete $3;
    }
|
expr DIV expr
    {
        // std::cout << "expr -> expr DIV expr" << std::endl;
        assertType("div", natural, natural, *$1, *$3);
        $$ = new type(natural);
        delete $1;
        delete $3;
    }
|
expr MOD expr
    {
        // std::cout << "expr -> expr MOD expr" << std::endl;
        assertType("mod", natural, natural, *$1, *$3);
        $$ = new type(natural);
        delete $1;
        delete $3;
    }
;

skip: SKIP SEMICOLON
    {
        // std::cout << "skip -> SKIP SEMICOLON" << std::endl;
    }
;
