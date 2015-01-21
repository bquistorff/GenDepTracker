# WinGenDep
A generic dependency tracker system for Windows. It aims to be the generic version of 'gcc -M'. The goal is that this can be put into a make-style build system. Idea came from the linux '[gendep](http://www.hep.phy.cam.ac.uk/~lester/gendep/index.html)', which I have also started developing [here](https://github.com/bquistorff/gendep).

The code is definitely new, but works for my use cases. Comments and suggestions are appreciated.

## Design 

To log the files read and written by a work task, it opens up a Procmon instance that logs (a) all new processes start and (b) all file reads and writes in the project folder (so currently the project must be well contained). After the work is finished, the logs are read to construct the work task's process tree and then I/O events are filtered by this set to identify all files that are (a) initially read, and (b) ever written. A .dep file (similar to that made by 'gcc -M') is written.

## Installation
This needs to be done once per system.

1. Install Procmon into "C:\Program Files (x86)\SysinternalsSuite" available from [here](http://technet.microsoft.com/en-us/sysinternals/bb842062). If you install it somewhere else you will need to edit the Task Scheduler tasks xml files and the dep_tracker_*.sh files. The Procmon folder must be writable.

1. Open Task Scheduler and import the three Procmon tasks in the installation folder. (This will allow Procmon to be run without requiring the UAC.)

1. Make sure you have Python (2 works, not sure about 3) & Cygwin installed

## Usage
A Procmon config file needs to be made that filters the filesystem events logged (we don't want to log everything going on for the system). This can be done once-per project, or at run time with GENDEP_PROJDIR. See the test/ folder.
