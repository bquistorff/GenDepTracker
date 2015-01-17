#! /bin/bash

origWD=$PWD
origWWD=`cygpath -w "$PWD"`
cd ../config
./gen-config.py "$origWWD"
mv config.pmc ../test
cd $origWD
