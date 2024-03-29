UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
  FORMAT=aout
else
ifeq ($(UNAME), Darwin)
  FORMAT=macho
else
  FORMAT=win
  TARGET=-target i686-pc-mingw32
endif
endif

PKGS=oUnit,extlib,unix
BUILD=ocamlbuild -r -use-ocamlfind

main: main.ml compile.ml runner.ml parser.mly lexer.mll
	$(BUILD) -package $(PKGS) main.native
	mv main.native main

test: compile.ml runner.ml test.ml myTests.ml parser.mly lexer.mll
	$(BUILD) -package $(PKGS) test.native
	mv test.native test

output/%.run: output/%.o main.c
	clang $(TARGET) -g -m32 -o $@ main.c $<

output/%.o: output/%.s
	nasm -f $(FORMAT) -o $@ $<

output/%.s: input/%.ana main
	./main $< > $@

clean:
	rm -rf output/*.o output/*.s output/*.dSYM output/*.run *.log
	rm -rf _build/
	rm -f main test
