%{
	#include "y.tab.h"
	int yylex();
int yywrap(void){
	return 1;
}
char karsilik[][50] = {"?","\n","INC", "DESC",
"BOOLEANEXP_TRUE","BOOLEANEXP_FALSE", "CONST", ".", "ML_COMM_START", "ML_COMM_END", "OR", "AND", "ISEQUAL","ISNOTEQUAL",
"LESSTHANOREQUAL","GREATERTHANOREQUAL","LESSTHAN","GREATERTHAN",
"MULVARIABLEITSELF","DIVVARIABLEITSELF","MODVARIABLEITSELF","ADDVARIABLEITSELF","SUBSVARIABLEITSELF","EQUALITY",
"ADDITIONOP","SUBTRACTIONOP",  "NOT", "LEFTSQRPRT", "RIGHTSQRPRT",
"THEN", "ELSE", "ELSEIF", "IF", "COMMA", "GREATER", "LOWER", "EQUAL", "PRINT", "SCAN",
"CONTINUE", "BREAK", "RETURN", "DIVIDEOP","MULTOP","MODOP", "WHILE", "FOR", "LEFTPRT", "RIGHTPRT", "START", "END",
"SL_COMM", "FLOAT","INTEGER", "CHAR"
};
//"\n" { return 1+256; }
// {letter}({letter}|{digit})* { return 6+256; }
// word [A-Za-z_]+
%}

number [0-9]+
char [A-Za-z_]
word [A-Za-z0-9_]+
multiline "#*"([^*]|\*+[^*#])*\*+"#"

%%
" "|"\t"|"\r"|"\n" ;
{multiline} { printf("%s\n",yytext); return 8+256; }
(\+\+) { return 2+256; }
(\-\-) { return 3+256; }
(TRUE|true) { return 4+256; }
(FALSE|false) { return 5+256; }
(CONST|const) { return 6+256; }
(\.) { return 7+256; }

([*][/]) { return 9+256; }
(OR|or) { return 10+256; }
(AND|and) { return 11+256; }
(\==) { return 12+256; }
(\!=) { return 13+256; }
(\<=) { return 14+256; }
(\>=) { return 15+256; }
(\<) { return 16+256; }
(\>) { return 17+256; }

(\*=) { return 18+256; }
(\/=) { return 19+256; }
(\%=) { return 20+256; }
(\+=) { return 21+256; }
(\-=) { return 22+256; }
(\=) { return 23+256; }
(\+) { return 24+256; }
(\-) { return 25+256; }
(not) { return 26+256; }
(\[) { return 27+256; }
(\]) { return 28+256; }
(then|THEN) { return 29+256; }
(else|ELSE) { return 30+256; }
(elseif|ELSEIF) { return 31+256; }
(if|IF) { return 32+256; }
(\,) { return 33+256; }
(greater\(|GREATER\() { return 34+256; }
(lower\(|LOWER\() { return 35+256; }
(equal\(|EQUAL\() { return 36+256; }
(print|PRINT) { return 37+256; }
(scan|SCAN) { return 38+256; }

(CONTINUE|continue) { return 39+256; }
(break|BREAK) { return 40+256; }
(return|RETURN) { return 41+256; }

(\/) { return 42+256; }
(\*) { return 43+256; }
(\%) { return 44+256; }
(WHILE|while) { return 45+256; }
(FOR|for) { return 46+256; }
(\() { return 47+256; }
(\)) { return 48+256; }
(start) { return 49+256; }
(end) { return 50+256; }
(#)([^\n\r]+) { printf("%s\n",yytext); return 51+256; }
{number}\.{number}  { return 52+256; }
{number}  { yylval.sayi = atoi(yytext); return 53+256; }
{char} { yylval.krktr = yytext[0]; return 54+256; }


. printf("unexpected character");

%%
