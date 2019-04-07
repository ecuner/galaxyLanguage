Galaxy Programming Language

GX is a syntax friendly and easy to understand language programming language without any ambiguity. One of the difference from other language is that GX using . (dot) for line breaking. GX License v1.0.

Syntax and Semantics of Galaxy

- The default file extension for Galaxy files is ".gx".
- GX statements end with a dot (.).
- GX is a case sensitive language.
- There is only one data type: digit(0-9).
- There is only one way to name variables: char(a-z & A-Z) . So in total you can have 52 variables.
- There is two built-in functions: print(var or const) and scan(var)
- An equal sign (=) is used to assign, arithmetic operators ( + - \* / ) is used to compute values to variables. Computed variables can’t go further from 9.
- There is no declaration of variables, therefore implicitly specifying each data type for variables is not needed too.
- If condition syntax (Which actually works):
  if(<expr>) then <stmt> {elseif <stmt>}\* {else <stmt>}?
- Inline if condition syntax (This one works too):
  (<expr> then <stmt> else <stmt>)
- While loop syntax:
  while(<expr>) start <stmt> end
- For loop syntax:
  for(<assignment>. <expr>. <assignment>) start <stmt> end
- Function syntax:
  <char>(<paremeters>) start <stmt> end
- Gx does not have a main function to start, it just starts to read from top to bottom, so it isn’t interpreted language.
- Single line comments starts with #, multi line comments starts with #_ and ends with _#.

Instructions to Operate

Makefile handles everything for you. Here are some of useful commands:

- make fullBuild
  Compiles lex and yacc and links them.
- make runExample
  Runs an example prepared by us.
- make clean
  Cleans all compiled binaries, headers etc.

BNF Form of Galaxy

<program> ::= <stmt_list>

<consts> ::= const <assignment> | <line_breaker>

<stmt_list> ::= empty
| <consts> <stmt_list>
| <function> <stmt_list>
| <statement> <stmt_list>
| <comment> <stmt_list>

<function> ::= <char> ( <parameters> ) start {<statement>}\* end

<line-breaker> ::= <..>

<parameters> ::= <expr>
| <parameters> , <expr>
| empty

<comment> ::= <SL_COMM>
| <ML_COMM_START>

<expr> → <expr> or <and-expression>
| <and-expression>
| <equality-expression>
| <relational-expression>
| <additive-expression>
| <multiplicative-expression>
| <expression-with-head>
| <expression-with-tail>

<and-expression> ::= <equality-expression>
| <and-expression> and <equality-expression>

<equality-expression> ::= <relational-expression>
| <equality-expression> == <relational-expression>
| <equality-expression> != <relational-expression>

<relational-expression> ::= <additive-expression>
| <relational-expression> < <additive-expression>
| <relational-expression> > <additive-expression>
| <relational-expression> <= <additive-expression>
| <relational-expression> >= <additive-expression>

<additive-expression> ::= <multiplicative-expression>
| <additive-expression> + <multiplicative-expression>
| <additive-expression> - <multiplicative-expression>

<multiplicative-expression> ::= <expression-with-head>
| <multiplicative-expression> \* <expression-with-head>
| <multiplicative-expression> / <expression-with-head>
| <multiplicative-expression> % <expression-with-head>

<expression-with-head> ::= <expression-with-tail>
| ++ <vars-and-consts>
| -- <vars-and-consts>

<expression-with-tail> ::= <expression_with_parenthesis>
| <expression-with-tail> ++
| <expression-with-tail> --

<expression-with-parenthesis> ::= not(<expr>)
| (<expr>)
| <vars-and-consts>

<vars-and-consts> ::= <char>
| <integer>
| ( <assignment> )

<conditional-expression> ::= (<expr> then <expr> else <expr>)

<expr_or_conditional_expression> ::= <expr>
| <onditional-expression>

<assignment> ::= <vars-and-consts> = <expr_or_conditional_expression>
| <vars-and-consts> \*= <conditional-expression>
| <vars-and-consts> /= <conditional-expression>
| <vars-and-consts> %= <conditional-expression>
| <vars-and-consts> += <conditional-expression>
| <vars-and-consts> -= <conditional-expression>

<statement> ::= <line-breaker>
| <assignment> <line-breaker>
| <condition>
| CONTINUE <line_breaker>
| BREAK <line_breaker>
| <lup>
| <expression_with_head> <line_breaker>
| PRINT (<vars_and_consts>) <line_breaker>
| SCAN (CHAR) <line_breaker>

<function_expr> :: = (<expr>) then

<function_else> :: = else

<expr_and_statement_zero_or_more>:
| ELSEIF expr_and_statement <expr_and_statement_zero_or_more>

<condition> : IF <function_expr> <statements> <expr_and_statement_zero_or_more> END
| IF <function_expr> <statements> < expr_and_statement_zero_or_more> <function_else> <statements> END

<for_assignment> : <expression_with_head> | <assignment>

<lup> ::= while ( <expr> ) start <statement> end
| for ( <assignment><line-breaker> <expr> <line-breaker> <for_assignment> ) start <statements> end

Contributors
Eray Orçunus
Gökmen Özçelik
Caner Türkmen
