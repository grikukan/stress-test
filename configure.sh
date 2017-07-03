#!/bin/bash

#sl

echo "Welcome to stress test configureation"

echo "Type name of reference solution (without .cpp) or leave this field empty if you want to check only TL followed by [ENTER]:"
read reference

referencetl=""

if [ ! "$reference" = "" ]; then
	echo "Type TL for reference solution or leave empty for infinite TL and press [ENTER]:"
	read referencetl
fi

echo "Type name of testing soltion (without .cpp), followed by [ENTER]:"
read testing

echo "Type TL for testing solution or leave empty for infinite TL and press [ENTER]:"
read tesingtl

echo "Type name of generator name (without .cpp), or leave this field empty if you don't want stress followed by [ENTER]:"
read generator

echo "Type name of checker name (without .cpp) or leave this field empty to use diff followed by [ENTER]:"
read checker

if [ -f .config ]; then
	rm .config
fi

echo "REFERENCE=$reference" >> .config
echo "REFERENCE_TL=$referencetl" >> .config
echo "TESTING=$testing" >> .config
echo "TESTING_TL=$testingtl" >> .config
echo "GENERATOR=$generator" >> .config
echo "CHECKER=$checker" >> .config




