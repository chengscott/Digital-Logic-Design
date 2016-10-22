VLOG = ncverilog
SRC = hw7_1_test.v	\
	  hw7_1.v
VLOGARG = +access+r

TMPFILE =	*.log \
			ncverilog.key \
			INCA_libs \
			novas.conf \
			novas.rc 

DBFILE = hw7_1.fsdb *.vcd

BAKFILE = *.bak .*.un~

all :: sim

sim :
	$(VLOG) $(SRC) $(VLOGARG)

clean :
	rm -rf $(DBFILE)
	rm -rf $(TMPFILE)

veryclean :
	rm -rf $(DBFILE)
	rm -rf $(TMPFILE)
	rm -rf $(BAKFILE)
