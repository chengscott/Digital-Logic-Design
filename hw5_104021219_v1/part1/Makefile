NCV = ncverilog
SRC = hw5_1_test.v hw5_1.v decoder.v
FLAG = +access+r

all: sim

sim: 
	$(NCV) $(SRC) $(FLAG)

clean:
	rm -rf *.log *.fsdb INCA_libs
