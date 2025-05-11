MODEL = ABP.pml
EXEC  = pan

all: $(EXEC)

$(EXEC): pan.c
	gcc -O2 -o $(EXEC) pan.c

pan.c: $(MODEL)
	spin -a $(MODEL)

run: $(EXEC)
	./$(EXEC)

simulate:
	spin -u100 $(MODEL)

clean:
	@echo "Cleaning generated files..."
	rm -f pan pan.* _spin_nvr.tmp

.PHONY: all run clean simulate
