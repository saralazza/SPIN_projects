
MODEL     = readers_writers.pml
PAN_SRC   = pan.c
PAN_EXE   = pan
PAN_CFLAGS = -DNCLAIMS=3 -DNFAIR=3

# Default: generate verifier, compile it, run safety check
all: verify

# 1. Generate pan.c from the Promela model
$(PAN_SRC): $(MODEL)
	@echo "spin -a $(MODEL)"
	spin -a $(MODEL)

# 2. Compile the verifier with enough claim slots
$(PAN_EXE): $(PAN_SRC)
	@echo "gcc $(PAN_CFLAGS) -O2 -o $(PAN_EXE) $(PAN_SRC)"
	gcc $(PAN_CFLAGS) -O2 -o $(PAN_EXE) $(PAN_SRC)

# 3. Run the verifier to check mutual exclusion (never claim)
verify: $(PAN_EXE)
	@echo "./$(PAN_EXE) -a"
	./$(PAN_EXE) -a

# 4. (Optional) Produce a human-readable counterexample trace
trace:
	@echo "spin -t -p -g -l $(MODEL)"
	spin -t -p -g -l $(MODEL)

.PHONY: all verify trace clean

clean:
	@echo "Cleaning up SPIN artifacts"
	rm -f $(PAN_EXE) $(PAN_SRC) pan.h pan.m pan.p pan.t _spin_nvr.tmp
