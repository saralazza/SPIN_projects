MODEL = dining_phil
PAN = pan

all: compile

compile: ${MODEL}.pml
	spin -a ${MODEL}.pml

build: compile
	gcc -o ${PAN} pan.c

verify: build
	./${PAN} -a -m20000

clean:
	rm -f ${PAN} pan.[chmt] pan.b pan.p pan.*.trail pan.dot pan.html pan.log pan.inp pan.out pan.core trail core* *.trail _spin_nvr.tmp

check: clean verify

.PHONY: all compile build verify clean check