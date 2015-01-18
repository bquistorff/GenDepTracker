#! /bin/bash
export binDir="/cygdrive/c/Program Files (x86)/SysinternalsSuite/"
export pdir="$PWD"
if [ -n "$GENDEP_PROJDIR" ]; then pdir="$GENDEP_PROJDIR"; fi

#If GENDEP_PROJDIR changes, delete the config file so that it's remade
if [ ! -e "config.pmc" ];
then
	gen-config.py "`cygpath -w "$pdir"`"
	if [ -n "$GENDEP_DEBUG" ]; then echo "Remade config file with base=$pdir"; fi
fi

dep_tracker_pre.sh
if [ ! $? -eq 0 ]; then exit $?; fi

$@
rc=$?

if [ -n "$GENDEP_DEBUG" ]; then echo "Finished work. rc=$rc"; fi

dep_tracker_post.sh $rc
exit $?