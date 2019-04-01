lex:
	lex galaxy.l
	gcc -o galaxy lex.yy.c -ll

clean:
	rm galaxy
	rm lex.yy.c

runExample:
	chmod +x ./galaxy
	./galaxy < example.gx
