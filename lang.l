%option noyywrap c++ yylineno

%{
#include <iostream>
#include <cstdlib>
%}

LETTER      [a-zA-Z]
DIGIT       [0-9]
WS          [ \t\n]
COMMENT     #([^#]*|[ \t\n])*#
VARIABLE    {LETTER}({LETTER}|{DIGIT}|_)*

%%
{COMMENT}   // std::cout << "komment: " << YYText() << std::endl;

"program"   std::cout << "kulcsszo: " << YYText() << std::endl;
"begin"     std::cout << "kulcsszo: " << YYText() << std::endl;
"end"       std::cout << "kulcsszo: " << YYText() << std::endl;
"natural"   std::cout << "kulcsszo: " << YYText() << std::endl;
"boolean"   std::cout << "kulcsszo: " << YYText() << std::endl;
"true"      std::cout << "kulcsszo: " << YYText() << std::endl;
"false"     std::cout << "kulcsszo: " << YYText() << std::endl;
"div"       std::cout << "kulcsszo: " << YYText() << std::endl;
"mod"       std::cout << "kulcsszo: " << YYText() << std::endl;
"and"       std::cout << "kulcsszo: " << YYText() << std::endl;
"or"        std::cout << "kulcsszo: " << YYText() << std::endl;
"not"       std::cout << "kulcsszo: " << YYText() << std::endl;
"skip"      std::cout << "kulcsszo: " << YYText() << std::endl;
"if"        std::cout << "kulcsszo: " << YYText() << std::endl;
"then"      std::cout << "kulcsszo: " << YYText() << std::endl;
"else"      std::cout << "kulcsszo: " << YYText() << std::endl;
"elseif"    std::cout << "kulcsszo: " << YYText() << std::endl;
"endif"     std::cout << "kulcsszo: " << YYText() << std::endl;
"while"     std::cout << "kulcsszo: " << YYText() << std::endl;
"do"        std::cout << "kulcsszo: " << YYText() << std::endl;
"done"      std::cout << "kulcsszo: " << YYText() << std::endl;
"read"      std::cout << "kulcsszo: " << YYText() << std::endl;
"write"     std::cout << "kulcsszo: " << YYText() << std::endl;

{DIGIT}+    std::cout << "szam: " << YYText() << std::endl;
{VARIABLE}  std::cout << "valtozo: " << YYText() << std::endl;

"("         std::cout << "zarojel: " << YYText() << std::endl;
")"         std::cout << "zarojel: " << YYText() << std::endl;
":="        std::cout << "operator: " << YYText() << std::endl;
"-"         std::cout << "operator: " << YYText() << std::endl;
"+"         std::cout << "operator: " << YYText() << std::endl;
"*"         std::cout << "operator: " << YYText() << std::endl;
"<"         std::cout << "operator: " << YYText() << std::endl;
">"         std::cout << "operator: " << YYText() << std::endl;
"="         std::cout << "operator: " << YYText() << std::endl;
";"         std::cout << "separator: " << YYText() << std::endl;

{WS}+       // std::cout << "whitespace" << std::endl;
.           {
                std::cerr << lineno() << ": Lexikalis hiba." << std::endl;
                exit(1);
            }

%%
