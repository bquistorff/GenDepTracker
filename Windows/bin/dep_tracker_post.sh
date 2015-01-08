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
./Procmon.exe /openlog log.pml /SaveAs log.csv
mv -f log.pml log.csv $origDir
cd $origDir
# Procmon doesn't use all the filters for some reason, so the following.
# Could put this filtering python, but here helps with human readability of csv.
cat log.csv | grep -v 'NT AUTHORITY\\SYSTEM' | grep -v "PATH NOT FOUND" | grep -v "NAME NOT FOUND" > log.csv
echo "Finished log conversion. WPID=$WPID"


output_dependencies.py $WPID log.csv $WPWD
