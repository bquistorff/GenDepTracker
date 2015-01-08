#! /bin/bash
# Need to have STATABATCH resolve (bin +platform specific batch option)
PATH=../Windows/bin:$PATH
dep_tracker_pre.sh

$STATABATCH do stata_test.do
echo "Finished work"

dep_tracker_post.sh

rm stata_test.txt stata.est stata_internal_log.smcl stata_test.log stata_mata.dat Graph.gph auto_loc.dta Graph.eps
