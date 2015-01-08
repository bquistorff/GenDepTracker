#! /bin/bash
# Shuts down the logging. Processes the logging file.

origDir=$PWD
binDir="/cygdrive/c/Program Files (x86)/SysinternalsSuite/"
#get the windows ID of this bash process
WPID=$(ps | awk '{print $1,$4}' | grep $PPID | awk '{print $2}')
WPWD=`cygpath -w "$PWD"`

#./Procmon.exe /Terminate
schtasks /run /TN "Procmon3 elevated" > /dev/null
while ! [ $(ps -W | grep -v 'AppData' | grep -c 'Procmon') -eq 0 ]
do
	sleep 1s
done
echo "Finished Procmon shutdown"


cd "$binDir"

# Procmon doesn't use all the filters initially:
#http://forum.sysinternals.com/please-make-drop-filtered-events-a-little-smarte_topic30938.html
# So filer again when exporting
./Procmon.exe /LoadConfig config.pmc /openlog log.pml /SaveApplyFilter /SaveAs log.csv
mv -f log.pml log.csv $origDir
cd $origDir
echo "Finished log conversion. WPID=$WPID"

output_dependencies.py $WPID log.csv $WPWD target.d
