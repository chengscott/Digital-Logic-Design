NCV = ncverilog
SRC = hw5_2_test.v hw5_2.v 
FLAG = +access+r

all: sim

sim: $(SRC)
	$(NCV) $(SRC) $(FLAG)

clean:
	rm -rf *.log *.fsdb INCA_libs
