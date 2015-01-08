# GenDepTracker
A generic dependency tracker system. It aims to be the generic version of 'gcc -M'. The future goal is that this can be put into a make-style build system. I'm first working on Windows. For Linux, hopefully the following prototype could be improved:
http://make.mad-scientist.net/papers/advanced-auto-dependency-generation/ 
http://www.hep.phy.cam.ac.uk/~lester/gendep/index.html)

Comments and suggestions are appreciated.

## Windows 

### Installation
This needs to be done once per system.
1. Install Procmon into "C:\Program Files (x86)\SysinternalsSuite". This folder must be writable.
1. Open Task Scheduler and import the three Procmon tasks. (This will allow Procmon to be run without requiring the UAC.)
1. Make sure you have Python (are 2 & 3 ok?) & Cygwin installed

### Per-project setup
This needs to be done once per project that you want to track.
1. Generate per-project config file. See the test/ folder.

### Usage
See the test/ folder.