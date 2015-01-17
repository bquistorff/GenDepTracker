#! /bin/bash
# Need to have STATABATCH resolve (bin +platform specific batch option)

export PATH := $(shell pwd)/../bin:$(PATH)

test-stata:
	-rm stata_test.dep
	GENDEP_TARGET=stata_test GENDEP_DEBUG=1 \
		dep_tracker.sh $$STATABATCH do stata_test.do
	rm stata_test.txt stata.est stata_internal_log.smcl stata_test.log stata_mata.dat Graph.gph auto_loc.dta Graph.eps
	cat stata_test.dep