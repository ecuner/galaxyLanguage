%{
char karsilik[][50] = {"?","\n","INCRDESC",
"BOOLEAN", "CONST", "DOT", "ML_COMM_START", "ML_COMM_END", "OR", "AND", "EQUALITY", "COMPARISON",
"MULDIVMOD", "ADDSUB",  "NOT", "LEFTSQRPRT", "RIGHTSQRPRT", "THEN", "ELSE", "ELSEIF", "IF",
"CONTINUE", "BREAK", "RETURN", "ASSIGNOPR", "WHILE", "FOR", "LEFTPRT", "RIGHTPRT", "START", "END",
"SL_COMM", "INTEGER","FLOAT", "WORD"
};

// {letter}({letter}|{digit})* { return 6; }
// word [A-Za-z_]+
%}

digit [0-9]
letter [A-Za-z_]
word [A-Za-z0-9_]+

%%
" "|"\t" ;
"\n" { return 1; }
(\+\+|\-\-) { return 2; }
(TRUE|FALSE|true|false) { return 3; }
(CONST|const) { return 4; }
(\.) { return 5; }
([/][*]) { return 6; }
([*][/]) { return 7;  }
(OR|or) { return 8; }
(AND|and) { return 9; }
(==|!=) { return 10; }
(<=|>=|<|>) { return 11; }
(\*=|\/=|\%=|\+=|\-=|=) { return 24; }
(\-|\+) { return 13; }
(not) { return 14; }
(\[) { return 15; }
(\]) { return 16; }
(then|THEN) { return 17; }
(else|ELSE) { return 18; }
(elseif|ELSEIF) { return 19; }
(if|IF) { return 20; }
(CONTINUE|continue) { return 21; }
(break|BREAK) { return 22; }
(return|RETURN) { return 23; }

(\/|\*|\%) { return 12; }
(WHILE|while) { return 25; }
(FOR|for) { return 26; }
(\() { return 27; }
(\)) { return 28; }
(start) { return 29; }
(end) { return 30; }
(#) { return 31; }
{digit}+  { return 32; }
{digit}+\.{digit}+  { return 33; }
{word} { return 34; }


. printf("unexpected character");

%%

int main()
{
	int result;
	int running = 1;
	while(running)
	{
			result = yylex();
            if(result == 0)
                return 0;

			printf("%s ",karsilik[result]);
/*			switch(result)
			{
			case INTEGER: printf("INTEGER "); break;
			case FLOAT: printf("FLOAT "); break;
			case OPERATOR: printf("OPERATOR "); break;
			case IDENTIFIER: printf("IDENTIFIER "); break;
			case COMMENT: printf("COMMENT "); break;
			case BOOLEAN: printf("BOOLEAN "); break;
			case CONST: printf("CONST "); break;
			}
*/

	}
	return 0;
}
