
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
        typedef std::map<std::string,var_data> sym_table;
        Parser(std::istream& in) : lexer(&in, &std::cerr) {}
        int parse();

    private:
        yyFlexLexer lexer;
        sym_table symbol_table;
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
        
        void insertSymbol(type var_type, std::string name) {
            if( symbol_table.count(name) > 0 )
            {
                std::stringstream ss;
                ss << "Ujradeklaralt valtozo: " << name << ".\n"
                << "Korabbi deklaracio sora: " << symbol_table[name].decl_row << std::endl;
                error( ss.str().c_str() );
            } else {
                symbol_table[name] = var_data( d_loc__.first_line, var_type );
            }
        }

        void undeclared(const std::string& identifier){
            error(("Ismeretlen valtozo \"" + identifier + "\"").c_str());
        }

        inline std::string typeToString(type var_type) {
            if(var_type == natural) {
                return "natural";
            }
            if(var_type == boolean) {
                return "boolean";
            }
        }

        bool assertType(const std::string& owner, type expected, type actual) {
            if(expected == actual) {
                return true;
            } else {
                std::stringstream ss;
                ss << "Tipus elteres hiba.\n"
                << "\tElvart tipus: " << typeToString(expected) << "\n"
                << "\tKapott tipus: " << typeToString(actual) << "\n"
                << "\titt: " << owner << std::endl;
                error(ss.str().c_str());
                return false;
            }
        }

        bool assertType(const std::string& owner, type expected1, type expected2, type actual1, type actual2) {
            return
                assertType("az elso parameter \""+owner+"\"", expected1, actual1)
                && assertType("a masodik parameter \""+owner+"\"", expected2, actual2);
        }
};


#endif