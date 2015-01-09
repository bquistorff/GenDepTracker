# GenDepTracker
A generic dependency tracker system. It aims to be the generic version of 'gcc -M'. The future goal is that this can be put into a make-style build system. I'm first working on Windows. For Linux, hopefully the following prototype could be improved:
http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/ 
http://www.hep.phy.cam.ac.uk/~lester/gendep/index.html)

Comments and suggestions are appreciated.

## Windows 

To log the files read and written by a work task, it opens up a Procmon instance that logs (a) all new processes start and (b) all file reads and writes in the project folder (so currently the project must be well contained). After the work is finished, the logs are read to construct the work task's process tree and then I/O events are filtered by this set to identify all files that are (a) initially read, and (b) ever written. A .d file (similar to that made by 'gcc -M') can optionally be written.

### Installation
This needs to be done once per system.
1. Install Procmon into "C:\Program Files (x86)\SysinternalsSuite" available from [here](http://technet.microsoft.com/en-us/sysinternals/bb842062). If you install it somewhere else you will need to edit the Task Scheduler tasks xml files and the dep_tracker_*.sh files. The Procmon folder must be writable.
1. Open Task Scheduler and import the three Procmon tasks in the installation folder. (This will allow Procmon to be run without requiring the UAC.)
1. Make sure you have Python (2 works, not sure about 3) & Cygwin installed

### Per-project setup
This needs to be done once per project-folder in which you want to track work tasks.
1. Generate per-project Procmon config file. See the test/ folder.

### Usage
See the test/ folder.
