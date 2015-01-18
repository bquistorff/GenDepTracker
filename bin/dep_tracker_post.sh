#! /bin/bash
# Shuts down the logging. Processes the logging file.

origDir=$PWD
#get the windows ID of this bash process
WPID=$(ps | awk '{print $1,$4}' | grep $PPID | awk '{print $2}')
WPWD=`cygpath -w "$PWD"`

#./Procmon.exe /Terminate
schtasks /run /TN "Procmon3 elevated" > /dev/null
while ! [ $(ps -W | grep -v 'AppData' | grep -c 'Procmon') -eq 0 ]
do
	sleep 1s
done
if [ -n "$GENDEP_DEBUG" ]; then echo "Finished Procmon shutdown"; fi

if ! [ $1 -eq 0 ]; then exit $1; fi

cd "$binDir"

# Procmon doesn't use all the filters initially:
#http://forum.sysinternals.com/please-make-drop-filtered-events-a-little-smarte_topic30938.html
# So filer again when exporting
./Procmon.exe /LoadConfig config.pmc /openlog log.pml /SaveApplyFilter /SaveAs log.csv
mv -f log.pml log.csv $origDir
cd $origDir
if [ -n "$GENDEP_DEBUG" ]; then echo "Finished log conversion. WPID=$WPID"; fi

output_dependencies.py $WPID log.csv $WPWD $GENDEP_TARGET

if [ -z "$GENDEP_DEBUG" ]; then 
	rm log.pml log.csv
fi
