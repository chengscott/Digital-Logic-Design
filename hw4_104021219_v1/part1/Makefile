NCV = ncverilog
SRC = hw4_1_test.v hw4_1.v
FLAG = +access+r

all: sim

sim: $(SRC)
	$(NCV) $(SRC) $(FLAG)

clean:
	rm -rf *.log *.fsdb INCA_libs
