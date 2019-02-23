%option noyywrap c++ yylineno

%{
#include "Parserbase.h"
%}

LETTER      [a-zA-Z]
DIGIT       [0-9]
WS          [ \t\n]
COMMENT     #([^#]*|[ \t\n])*#
VARIABLE    {LETTER}({LETTER}|{DIGIT}|_)*

%%
{COMMENT}   // std::cout << "komment: " << YYText() << std::endl;

"program"   return Parser::PROGRAM;
"begin"     return Parser::BEGIN_TOKEN;
"end"       return Parser::END;
"natural"   return Parser::NATURAL;
"boolean"   return Parser::BOOLEAN;
"true"      return Parser::TRUE;
"false"     return Parser::FALSE;
"div"       return Parser::DIV;
"mod"       return Parser::MOD;
"and"       return Parser::AND;
"or"        return Parser::OR;
"not"       return Parser::NOT;
"skip"      return Parser::SKIP;
"if"        return Parser::IF;
"then"      return Parser::THEN;
"else"      return Parser::ELSE;
"elseif"    return Parser::ELSEIF;
"endif"     return Parser::ENDIF;
"while"     return Parser::WHILE;
"do"        return Parser::DO;
"done"      return Parser::DONE;
"read"      return Parser::READ;
"write"     return Parser::WRITE;

{DIGIT}+    return Parser::NATURAL_LITERAL;
{VARIABLE}  return Parser::IDENTIFIER;

"("         return Parser::LEFT_PARENTHESIS;
")"         return Parser::RIGHT_PARENTHESIS;
":="        return Parser::ASSIGN;
"-"         return Parser::MINUS;
"+"         return Parser::PLUS;
"*"         return Parser::MULTIPLY;
"<"         return Parser::LESS_THAN;
">"         return Parser::GREATER_THAN;
"="         return Parser::EQUAL;
";"         return Parser::SEMICOLON;

{WS}+       // std::cout << "whitespace" << std::endl;
.           {
                std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
                exit(1);
            }

%%
