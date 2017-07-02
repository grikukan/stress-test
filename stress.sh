#/bin/bash

function runTest {
	./reference < "$1.in" > "$1.a"
	./solution < "$1.in" > "$1.out"
	if [[ $? != 0 ]]; then
		echo "Runtime error on test $1"
		exit 0;
	fi
	./check "$1.in" "$1.a" "$1.out"
	code=$?
	if [[ $code == 2 ]]; then
		echo "FAIL on test $1"
		exit 0;
	fi
	if [[ $code == 1 ]]; then
		echo "Wrong answer on test $1"
		exit 0;
	fi	
}

make gen
make reference
make solution
make check

for i in $(ls -1 | grep .in$);
do
		echo $i
		runTest ${i%???}
done
	
while :
do
	./gen 10 -10 10 > test.in
	runTest test
done
