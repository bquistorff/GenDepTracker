#! /bin/bash
export binDir="/cygdrive/c/Program Files (x86)/SysinternalsSuite/"

dep_tracker_pre.sh
$@
if [ -n "$GENDEP_DEBUG" ]; then echo "Finished work"; fi
dep_tracker_post.sh
