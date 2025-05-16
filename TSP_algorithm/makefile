MODEL = traveling_salesman.pml
PAN_SRC = pan.c
PAN_EXE = pan

verify: $(PAN_EXE)
	@echo ">> Verifica in corso..."
	./$(PAN_EXE) -a
	@echo ">> Traccia leggibile:"
	spin -t -p -g -l $(MODEL)

$(PAN_SRC): $(MODEL)
	spin -a $(MODEL)

$(PAN_EXE): $(PAN_SRC)
	gcc -o $(PAN_EXE) $(PAN_SRC)

.PHONY: verify clean

clean:
	@echo "Cleaning temporary artifacts from verifier generation"
	rm -f pan pan.b pan.c pan.h pan.m pan.p pan.t _spin_nvr.tmp 
