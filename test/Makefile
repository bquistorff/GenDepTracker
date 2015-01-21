#! /bin/bash
# Need to have STATABATCH resolve (bin +platform specific batch option)
#GENDEP_DEBUG=1
export PATH := $(shell pwd)/../bin:$(PATH)
export GENDEP_PROJDIR := $(CURDIR)

test-stata:
	-rm stata_test.dep
	GENDEP_TARGET=stata_test  \
		dep_tracker.sh $$STATABATCH do stata_test.do
	cat stata_test.dep
	
clean:
	rm -f stata_test.txt stata.est stata_internal_log.smcl stata_test.log stata_mata.dat Graph.gph auto_loc.dta Graph.eps
	rm -f stata_test.dep