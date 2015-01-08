#! /bin/bash
# Need to have STATABATCH resolve (bin +platform specific batch option)
PATH=../Windows/bin:$PATH
dep_tracker_pre.sh

$STATABATCH di 4
echo "Finished work"

dep_tracker_post.sh
