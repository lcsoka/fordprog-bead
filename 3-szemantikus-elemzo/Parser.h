
#ifndef Parser_h_included
#define Parser_h_included

// $insert baseclass
#include "Parserbase.h"
#include "FlexLexer.h"
#include <cstdlib>

#undef Parser
class Parser: public ParserBase
{
        
    public:
        typedef std::map<std::string,var_data> symbol_table;
        Parser(std::istream& in) : lexer(&in, &std::cerr) {}
        int parse();

    private:
        yyFlexLexer lexer;
        symbol_table symbols;
        void error(char const *msg);    // called on (syntax) errors
        int lex();                      // returns the next token from the
                                        // lexical scanner. 
        void print();                   // use, e.g., d_token, d_loc

    // support functions for parse():
        void executeAction(int ruleNr);
        void errorRecovery();
        int lookup(bool recovery);
        void nextToken();
        void print__();
        void exceptionHandler__(std::exception const &exc);
        
        // std::string typeToString(type var_type);
        // bool assertType(const std::string& owner, type expected, type actual);
        // bool assertType(const std::string& owner, type expected1, type expected2, type actual1, type actual2);
        // void insertSymbol(type var_type, std::string name);
        // void undeclared(const std::string& identifier);
};


#endif