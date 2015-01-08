#! /bin/bash

origWD=$PWD
origWWD=`cygpath -w "$PWD"`
cd ../Windows/config
./gen-config.py "$origWWD"
mv config.pmc ../../test
cd $origWD
