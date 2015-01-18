#! /bin/bash
export binDir="/cygdrive/c/Program Files (x86)/SysinternalsSuite/"

if [ ! -e "config.pmc" ];
then
	gen-config.py "`cygpath -w "$PWD"`"
	if [ -n "$GENDEP_DEBUG" ]; then echo "Remade config file"; fi
fi

dep_tracker_pre.sh
if [ ! $? -eq 0 ]; then exit $?; fi

$@
rc=$?

if [ -n "$GENDEP_DEBUG" ]; then echo "Finished work. rc=$rc"; fi

dep_tracker_post.sh $rc
exit $?