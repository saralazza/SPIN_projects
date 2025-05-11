
verify: pan
	./pan -a -N mutex
	./pan -a -N progress_A
	./pan -a -N progress_B


pan.c:
	spin -a mutual_exc.pml

pan: pan.c
	gcc -O2 -o pan pan.c

.PHONY: verify

clean:
	@echo "Cleaning temporary artifacts from verifier generation"
	rm -f pan pan.b pan.c pan.h pan.m pan.p pan.t _spin_nvr.tmp
