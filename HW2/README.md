Language Used for HW1: Java <br/>
Language Used for HW2: Python 

I worked independently for 14 hours on this assignment.

The code already contains the executable while.py file. To execute the program, program arguments have to be given in double quotes. <br/> 
For example: ./while.py "x := 1"

My while interpreter implementation can handle:
1. Arithmetic operations: add, subtract, multiply, divide and mod
2. Relational operations: less-than, less-than-equal, greater-than, greater-than-equal, equal, not, not-equal, or, and
3. Commands : while, if-else, if, multiple commands, skip 

Added features : divide, subtract, mod and not-equal

Also, the I had to make a minor change in tests/harness.bash file to run the tests on my system. Earlier code was:

    run sh -c "echo '$1' | ./while"
    echo "$1 = $2, your code outputs $output"
    [ "$output" = "$2" ]
    
Changes I made:

    output=`sh -c "echo \"'$1'\" | xargs ./while.py"`
    echo "$1 = $2, your code outputs $output"
    [ "$output" = "$2" ]
    
Created mytests.bats file in tests folder to run my tests. <br/>
Code Link: https://github.com/nmittal29/CSE210a/tree/master/HW2
