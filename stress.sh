#/bin/bash


function execute { #file, stdin, stdout, TL, returns 0 - ok, 1 - re, 2 - tl
	if [ "$4" = "" ]; then
		./$1 < $2 > $3
	else
		timeout "$4s" ./$1 < $2 > $3
	fi
	exit_code=$?
	if [ "$exit_code" = "124" ]; then
		return 2
	fi
	if [ "$exit_code" = "0" ]; then
		return 0
	fi
	return 1
}

function runTest { #test, returns 0 - ok, 1 - wa, 2 - re, 3 - tl, 4 - fl
	test=$1
	execute $TESTING "$test.in" "$test.out" $TESTING_TL
	execute_code=$?
	if [ "$execute_code" = 1 ]; then
		return 2
	fi
	if [ "execute_code" = 2 ]; then
		return 3
	fi
	if [ ! -f "$test.ans" ]; then 
		if [ ! "$REFERENCE" = "" ]; then
			execute $REFERENCE "$test.in" "$test.ans" $REFERENCE_TL
			if [ "$?" -ne "0" ]; then
				rm "$test.ans"
				return 4
			fi
		fi
	fi
	if [ -f "$test.ans" ]; then
		check_code=""
		if [ ! "$CHECKER" = "" ]; then
			./$CHECKER "$test.in" "$test.ans" "$test.out"
			check_code="$?"
		else
			diff "$test.ans" "$test.out" > /dev/null
			check_code="$?"
		fi
		if [ "$check_code" -ne "0" ]; then
			return 1
		fi
	fi
	rm "$test.out"
	return 0
}

if [ ! -f .config ]; then
	echo "No .config file! Run config first."
	exit 1;
fi

source .config

if [ ! "$GENERATOR" = "" ]; then
	make $GENERATOR
fi
make $REFERENCE
make $TESTING
if [ ! "$CHECKER" = "" ]; then
	make $CHECKER
fi

samples_ok="1"
for i in $(ls -1 | grep .in$);
do
		runTest ${i%???}
		result=$?
		if [ "$result" = "0" ]; then
			echo "$i OK"
		fi
		if [ ! "$result" = "0" ]; then
			samples_ok="0"
		fi
		if [ "$result" = "1" ]; then
			echo "$i WA"
		fi
		if [ "$result" = "2" ]; then
			echo "$i RE"
		fi
		if [ "$result" = "3" ]; then
			echo "$i TL"
		fi
		if [ "$result" = "4" ]; then
			echo "$i FL"
		fi	
done

if [ ! "$samples_ok" = "" ]; then
	exit 1
fi

if [ ! "$GENERATOR" = "" ]; then
	while :
	do
		./gen > test.in
		runTest test
		result=$?
		if [ ! "$result" = "0" ]; then
			exit 1
		fi
	done
fi
