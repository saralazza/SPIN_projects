MODEL = go_back_n
PAN = pan

all: compile

compile: ${MODEL}.pml
	spin -a ${MODEL}.pml

build: compile
	gcc -DCOLLAPSE -o ${PAN} pan.c

verify: build
	./${PAN} -a -m20000

render: automaton.pdf

automaton.pdf : automaton.dot
	@dot -Tps automaton.dot -o automaton.ps
	@echo "Rendering postscript to PDF, ensure that ghostscript is installed"
	@ps2pdf automaton.ps automaton.pdf
	@rm -f automaton.ps

automaton.dot : build
	@./pan -D > automaton.dot

clean:
	rm -f ${PAN} pan.[chmt] pan.b pan.p pan.*.trail pan.dot pan.html pan.log pan.inp pan.out pan.core trail core* *.trail _spin_nvr.tmp automaton.dot automaton.ps dot.*

check: clean verify

.PHONY: all compile build verify clean check render