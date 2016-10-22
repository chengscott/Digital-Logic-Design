VLOG = ncverilog
SRC4 = elevator4.v \
      elevator_controller.v \
      down_counter.v \
      priority_encoder.v
SRC128 = elevator128.v \
      elevator_controller.v \
      down_counter.v \
      priority_encoder.v
VLOGARG = +access+r

TMPFILE = *.log \
          ncverilog.key \
          INCA_libs \
          novas.conf \
          novas.rc 
DBFILE = *.fsdb *.vcd
BAKFILE = *.bak .*.un~

all :: sim

sim :
	$(VLOG) $(SRC4) $(VLOGARG)

4 :
	$(VLOG) $(SRC4) $(VLOGARG)

128 :
	$(VLOG) $(SRC128) $(VLOGARG)

Allpass :: 4 128

clean :
	rm -rf $(DBFILE)
	rm -rf $(TMPFILE)

veryclean :
	rm -rf $(DBFILE)
	rm -rf $(TMPFILE)
	rm -rf $(BAKFILE)
