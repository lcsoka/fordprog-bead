%baseclass-preinclude "semantics.h"
%lsp-needed

%token PROGRAM BEGIN_TOKEN END
%token NATURAL BOOLEAN
%token TRUE FALSE
%token NOT
%token SKIP
%token IF THEN ELSE ELSEIF ENDIF
%token WHILE DO DONE
%token READ WRITE
%token IDENTIFIER
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
        std::cout << "start -> program" << std::endl;
    }
;

program: header declarations body
    {
        std::cout << "program -> header declarations body" << std::endl;
    }
;

header: PROGRAM IDENTIFIER
    {
        std::cout << "header -> PROGRAM IDENTIFIER" << std::endl;
    }
;

declarations:
    {
        std::cout << "declarations -> \"\"" << std::endl;
    }
|
declaration declarations
    {
        std::cout << "declarations -> declaration declarations" << std::endl;
    }
;

declaration: type IDENTIFIER SEMICOLON
    {
        std::cout << "declaration -> type IDENTIFIER SEMICOLON" << std::endl;
    }
;

type:
NATURAL
    {
        std::cout << "type -> NATURAL" << std::endl;
    }
|
BOOLEAN
    {
        std::cout << "type -> BOOLEAN" << std::endl;
    }
;

body: BEGIN_TOKEN expressions END
    {
        std::cout << "body -> BEGIN_TOKEN statements END" << std::endl;
    }
;

expressions:
expression 
    {
        std::cout << "expressions -> expression" << std::endl;
    }
|
expression expressions
    {
        std::cout << "expressions -> expression expressions" << std::endl;
    }
;

expression:
read
    {
        std::cout << "expression -> read" << std::endl;
    }
|
write
    {
        std::cout << "expression -> write" << std::endl;
    }
|
assignment
    {
        std::cout << "expression -> assignment" << std::endl;
    }
|
while_loop
    {
        std::cout << "expression -> while_loop" << std::endl;
    }
|
if_statement
    {
        std::cout << "expression -> if_statement" << std::endl;
    }
|
skip
    {
        std::cout << "expression -> skip" << std::endl;
    }
;

read: READ LEFT_PARENTHESIS IDENTIFIER RIGHT_PARENTHESIS SEMICOLON
    {
        std::cout << "read -> READ LEFT_PARENTHESIS IDENTIFIER RIGHT_PARENTHESIS SEMICOLON" << std::endl;
    }
;

write: WRITE LEFT_PARENTHESIS expr RIGHT_PARENTHESIS SEMICOLON
    {
        std::cout << "write -> WRITE LEFT_PARENTHESIS expr RIGHT_PARENTHESIS SEMICOLON" << std::endl;
    }
;

assignment: IDENTIFIER ASSIGN expr SEMICOLON
    {
        std::cout << "assignment -> IDENTIFIER ASSIGN expr SEMICOLON" << std::endl;
    }
;

while_loop: WHILE expr DO expressions DONE
    {
        std::cout << "while_loop -> WHILE expr DO expressions DONE" << std::endl;
    }
;

if_statement: IF expr THEN if_second_half
    {
        std::cout << "if_statement -> IF expr THEN if_second_half" << std::endl;
    }
;

if_second_half:
expressions ENDIF
    {
        std::cout << "if_second_half -> expressions ENDIF" << std::endl;
    }
|
expressions ELSE expressions ENDIF
    {
        std::cout << "if_second_half -> expressions ELSE expressions ENDIF" << std::endl;
    }
|
expressions ELSEIF expr THEN if_second_half
    {
        std::cout << "if_second_half -> expressions ELSEIF expr THEN if_second_half" << std::endl;
    }
;

expr:
TRUE
    {
        std::cout << "expr -> TRUE" << std::endl;
    }
|
FALSE
    {
        std::cout << "expr -> FALSE" << std::endl;
    }
|
IDENTIFIER
    {
        std::cout << "expr -> IDENTIFIER" << std::endl;
    }
|
NATURAL_LITERAL
    {
        std::cout << "expr -> NATURAL_LITERAL" << std::endl;
    }
|
expr EQUAL expr
    {
        std::cout << "expr -> expr EQUAL expr" << std::endl;
    }
|
LEFT_PARENTHESIS expr RIGHT_PARENTHESIS
    {
        std::cout << "expr -> LEFT_PARENTHESIS expr RIGHT_PARENTHESIS" << std::endl;
    }
|
NOT expr
    {
        std::cout << "expr -> NOT expr" << std::endl;
    }
|
expr AND expr
    {
        std::cout << "expr -> expr AND expr" << std::endl;
    }
|
expr OR expr
    {
        std::cout << "expr -> expr OR expr" << std::endl;
    }
|
expr LESS_THAN expr
    {
        std::cout << "expr -> expr LESS_THAN expr" << std::endl;
    }
|
expr GREATER_THAN expr
    {
        std::cout << "expr -> expr GREATER_THAN expr" << std::endl;
    }
|
expr PLUS expr
    {
        std::cout << "expr -> expr PLUS expr" << std::endl;
    }
|
expr MINUS expr
    {
        std::cout << "expr -> expr MINUS expr" << std::endl;
    }
|
expr MULTIPLY expr
    {
        std::cout << "expr -> expr MULTIPLY expr" << std::endl;
    }
|
expr DIV expr
    {
        std::cout << "expr -> expr DIV expr" << std::endl;
    }
|
expr MOD expr
    {
        std::cout << "expr -> expr MOD expr" << std::endl;
    }
;

skip: SKIP SEMICOLON
    {
        std::cout << "skip -> SKIP SEMICOLON" << std::endl;
    }
;
