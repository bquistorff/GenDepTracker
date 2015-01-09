#! /bin/bash
binDir="/cygdrive/c/Program Files (x86)/SysinternalsSuite/"

if [ $(ps -W | grep -c 'Procmon') -gt 0 ]
then
	echo "Currently can only work if no existing Procmon instances are running"
	exit
fi

# Starts up the logging.
cp config.pmc "$binDir"
#./Procmon.exe /backingfile log.pml /AcceptEula /LoadConfig config.pmc /Minimized /Quiet &
schtasks /run /TN "Procmon1 elevated" > /dev/null

#./Procmon.exe /waitforidle
schtasks /run /TN "Procmon2 elevated" > /dev/null
#shctasks doesn't run the task interactively so wait for finish of second one.
#procmon starts and then creates a second instance in C:\Users\<username>\AppData\Local\Temp\
while ! [ $(ps -W | grep -v 'AppData' | grep -c 'Procmon') -eq 1 ]
do
	sleep 1s
done
echo "Finished Procmon startup"

