%{
void yyerror (char *s);
int yylex();
#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
int symbols[52];
int symbolVal(char symbol);
int updateSymbolVal(char symbol, int val, int action);
int devamEt = 1;
%}

%union {int sayi; char krktr;}         /* Yacc definitions */
%token INC DESC
%token BOOLEANEXP_TRUE BOOLEANEXP_FALSE CONST . ML_COMM_START ML_COMM_END OR AND ISEQUAL ISNOTEQUAL LESSTHANOREQUAL GREATERTHANOREQUAL LESSTHAN GREATERTHAN
%token MULVARIABLEITSELF DIVVARIABLEITSELF MODVARIABLEITSELF ADDVARIABLEITSELF SUBSVARIABLEITSELF EQUALITY ADDITIONOP SUBTRACTIONOP NOT LEFTSQRPRT RIGHTSQRPRT THEN ELSE ELSEIF IF COMMA GREATER LOWER EQUAL PRINT SCAN
%token CONTINUE BREAK RETURN DIVIDEOP MULTOP MODOP WHILE FOR LEFTPRT RIGHTPRT START END
%token SL_COMM FLOAT
%token <sayi> INTEGER
%token <krktr> CHAR
%type <krktr> expr and_expression equality_expression relational_expression additive_expression multiplicative_expression expression_with_head expression_with_tail expression_with_parenthesis conditional_expression expr_or_conditional_expression
%type <krktr> assignment vars_and_consts
%start program
%%

/*******************************************************************************/
program    : stmt_list
						 ;

stmt_list    : /* boş */
							| function  stmt_list
              | statement  stmt_list
							| consts  stmt_list
							| comment stmt_list
							;

comment	: SL_COMM
				| ML_COMM_START
				;

consts : CONST assignment line_breaker { printf("bu bir const'tur"); }

statements: 	statement
							| statement statements
							;

function    : CHAR LEFTPRT parameters  RIGHTPRT START statements END { printf("Function definition\n"); }
						;

parameters : expr
           | parameters COMMA expr
					 | /*empty*/
					 ;

line_breaker    : .
									;

expr  : expr  OR and_expression { $$ = symbolVal($1) || symbolVal($3); }
	 | and_expression
	 | equality_expression
	 | relational_expression
	 | additive_expression
	 | multiplicative_expression
	 | expression_with_head
	 | expression_with_tail
	 ;

and_expression    : equality_expression
                           | and_expression  AND equality_expression { $$ = symbolVal($1) && symbolVal($3); }
													 ;

equality_expression    : relational_expression
                        | equality_expression  ISEQUAL relational_expression { $$ = symbolVal($1) == symbolVal($3); }
                        | equality_expression  ISNOTEQUAL relational_expression { $$ = symbolVal($1) != symbolVal($3); }
												;

relational_expression    : additive_expression
                          | relational_expression  LESSTHAN additive_expression { $$ = symbolVal($1) < symbolVal($3); }
                          | relational_expression  GREATERTHAN additive_expression { $$ = symbolVal($1) > symbolVal($3); }
                          | relational_expression  LESSTHANOREQUAL additive_expression { $$ = symbolVal($1) <= symbolVal($3); }
                          | relational_expression  GREATERTHANOREQUAL additive_expression { $$ = symbolVal($1) >= symbolVal($3); }
													;

additive_expression    : multiplicative_expression
                        | additive_expression  ADDITIONOP multiplicative_expression { $$ = symbolVal($1) + symbolVal($3);
																																											// printf("sonuç: %d - ham ilk şey: %d - ham ikinci: %d",$$,$1,$3);
																																										}
                        | additive_expression  SUBTRACTIONOP multiplicative_expression { $$ = symbolVal($1) - symbolVal($3); }
												;

multiplicative_expression    : expression_with_head
                              | multiplicative_expression  MULTOP expression_with_head { $$ = symbolVal($1) * symbolVal($3); }
                              | multiplicative_expression  DIVIDEOP expression_with_head { $$ = symbolVal($1) / symbolVal($3); }
                              | multiplicative_expression  MODOP expression_with_head { $$ = symbolVal($1) % symbolVal($3); }
															;

expression_with_head    : expression_with_tail
                     | INC vars_and_consts { $$ = updateSymbolVal($2, 1, 6); }
                     | DESC vars_and_consts { $$ = updateSymbolVal($2, 1, 7); }
										 ;

expression_with_tail    : expression_with_parenthesis
                       | expression_with_tail  INC { $$ = symbolVal($1); updateSymbolVal($1, 1, 6); }
                       | expression_with_tail  DESC { $$ = symbolVal($1); updateSymbolVal($1, 1, 7); }
											 ;

expression_with_parenthesis  : NOT LEFTPRT expr RIGHTPRT { $$ = !symbolVal($3); }
														| LEFTPRT expr RIGHTPRT { $$ = symbolVal($2); }
 														| vars_and_consts

vars_and_consts    :  CHAR
									 | INTEGER { $$ = $1; }
                   | LEFTPRT  assignment  RIGHTPRT { $$ = ($2); }
	 								 		;

conditional_expression    : LEFTPRT expr THEN expr ELSE expr RIGHTPRT { $$ = (symbolVal($2) ? symbolVal($4) : symbolVal($6)); }
														;

expr_or_conditional_expression	: expr
																| conditional_expression
																	;

assignment    : vars_and_consts  EQUALITY  expr_or_conditional_expression { updateSymbolVal($1,symbolVal($3),0);
																																						// printf("sonuç: %d - ham hedef: %d - ham kaynak: %d",symbolVal($1),$1,$3);
																																					}
							| vars_and_consts  MULVARIABLEITSELF  expr_or_conditional_expression { updateSymbolVal($1,symbolVal($3),1); }
							| vars_and_consts  DIVVARIABLEITSELF  expr_or_conditional_expression { updateSymbolVal($1,symbolVal($3),2); }
							| vars_and_consts  MODVARIABLEITSELF  expr_or_conditional_expression { updateSymbolVal($1,symbolVal($3),3); }
							| vars_and_consts  ADDVARIABLEITSELF  expr_or_conditional_expression { updateSymbolVal($1,symbolVal($3),4); }
							| vars_and_consts  SUBSVARIABLEITSELF  expr_or_conditional_expression { updateSymbolVal($1,symbolVal($3),5); }
							;

statement    :  line_breaker
							| assignment line_breaker
              | condition
						  | CONTINUE line_breaker
							| BREAK line_breaker
              | lup
							| expression_with_head line_breaker
							| PRINT LEFTPRT vars_and_consts RIGHTPRT line_breaker
								{ if(devamEt == 1 || devamEt == 2){
										printf("Print: %d\n", symbolVal($3));
									}
								}
							| SCAN LEFTPRT CHAR RIGHTPRT line_breaker
								{	if(devamEt == 1 || devamEt == 2){
										int temp;
										printf("Enter a digit:\n");
										scanf("%d",&temp);
										updateSymbolVal($3, temp, 0);
										printf("OK, now variable %c is %d\n",$3,symbolVal($3));
									}
								}
							;

function_expr    : LEFTPRT expr RIGHTPRT THEN
													{
														/*
															devamEt:
															0-Çalışma (if bitiminde sıfırlanacak)
															1-Çalış
															2-if-elseif'te ilk if çalıştı, diğerlerine bakma
															3-elseif'leri geziyoruz, belki çalışan olur
														*/
														if(devamEt == 1 || devamEt == 3){
															if(symbolVal($2)){
																if(devamEt == 1){
																	devamEt = 2;
																} else {
																	devamEt = 1;
																}
															} else {
																if(devamEt == 1){
																	devamEt = 3;
																}
															}
														} else if(devamEt == 2)
															devamEt = 0;
													}
											;

function_else	: ELSE
								{
									if(devamEt == 3){
										devamEt = 1;
									} else {
										devamEt = 0;
									}
								}

expr_and_statement_zero_or_more:	/* empty */
																| ELSEIF function_expr statements expr_and_statement_zero_or_more { printf("Elseif condition \n"); }
																;

condition    : IF  function_expr statements  expr_and_statement_zero_or_more END
								{
									printf("If condition without else \n");
									devamEt = 1;
								}
						 | IF  function_expr statements expr_and_statement_zero_or_more function_else statements END
						 		{
									printf("If condition with else \n");
									devamEt = 1;
								}
						 ;

for_assignment	: expression_with_head | assignment
								;

lup    : WHILE LEFTPRT expr RIGHTPRT START statements END { printf("While lup \n"); }
       | FOR LEFTPRT assignment line_breaker expr  line_breaker  for_assignment RIGHTPRT START statements END { printf("For lup \n"); }
			 ;
%%                     /* C code */

int computeSymbolIndex(char token)
{
	int idx = -1;
	if(islower(token)) {
		idx = token - 'a' + 26;
	} else if(isupper(token)) {
		idx = token - 'A';
	}
	return idx;
}

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
	if(isdigit(symbol) || (symbol>=0 && symbol<=9)) return (symbol);
	int bucket = computeSymbolIndex(symbol);
//	printf("%d\n",symbols[bucket]);
	return symbols[bucket];
}

/* updates the value of a given symbol */
int updateSymbolVal(char symbol, int val, int action)
{
	if(devamEt == 0 || devamEt == 3) return 0;

	int bucket = computeSymbolIndex(symbol);
	// printf("%c",symbol);
	switch(action){
		case 0:
			symbols[bucket] = val;
			break;
		case 1:
			symbols[bucket] *= val;
			break;
		case 2:
			symbols[bucket] /= val;
			break;
		case 3:
			symbols[bucket] %= val;
			break;
		case 4:
			symbols[bucket] += val;
			break;
		case 5:
			symbols[bucket] -= val;
			break;
		case 6:
			printf("%c increased. \n",symbol);
			return ++symbols[bucket];
			break;
		case 7:
			printf("%c decreased. \n",symbol);
			return --symbols[bucket];
			break;
	}

	// printf("updateSymbolVal: %d %d - sonuç: %d\n",val,action,symbols[bucket]);
	return 0;
}

int main (void) {
	/* init symbol table */
	int i;
	for(i=0; i<52; i++) {
		symbols[i] = 0;
	}

	return yyparse ( );
}

void yyerror (char *s) {fprintf (stderr, "%s\n", s);}
