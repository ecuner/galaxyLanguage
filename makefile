lex:
	lex galaxy.l

yacc:
	yacc -d galaxy.y

link:
	gcc lex.yy.c y.tab.c -o galaxy 

fullBuild:
	lex galaxy.l
	yacc -d galaxy.y
	gcc lex.yy.c y.tab.c -o galaxy 

clean:
	rm galaxy
	rm lex.yy.c
	rm y.tab.c
	rm y.tab.h

runExample:
	chmod +x ./galaxy
	./galaxy < example.gx
