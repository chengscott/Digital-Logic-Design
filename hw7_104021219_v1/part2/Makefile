VLOG = ncverilog
SRC = gcd.v	\
	  gcd_t.v
VLOGARG = +access+r

TMPFILE =	*.log \
			ncverilog.key \
			INCA_libs \
			novas.conf \
			novas.rc 

DBFILE = gcd.fsdb *.vcd

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
