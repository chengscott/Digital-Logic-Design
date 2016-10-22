NCV = ncverilog
SRC = hw5_3_test.v hw5_3.v hw5_2.v 
DEP = hw5_3_test.v hw5_3.v 
FLAG = +access+r

all: sim

sim: $(DEP)
	@echo "Copying hw5_2.v to this folder to run simulation" 
	cp ../part2/hw5_2.v . 
	$(NCV) $(SRC) $(FLAG)

clean:
	rm -rf *.log *.fsdb INCA_libs
