NCV = ncverilog
SRC = hw4_2_test.v hw4_2.v f_adder.v
FLAG = +access+r

all: sim

sim: $(SRC)
	$(NCV) $(SRC) $(FLAG)

clean:
	rm -rf *.log *.fsdb INCA_libs
