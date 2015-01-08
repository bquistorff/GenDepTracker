# GenDepTracker
A generic dependency tracker system. 

## Windows Installation

1. Install Procmon into "C:\Program Files (x86)\SysinternalsSuite"
1. Copy GenDepTracker\Windows\config.pmc to "C:\Program Files (x86)\SysinternalsSuite"
1. Open Task Scheduler and import the three Procmon tasks. (This will allow Procmon to be run without requiring the UAC.)
1. Make sure you have Python (are 2 & 3 ok?) & cygwin installed

## Windows Usage
See the test/ folder.