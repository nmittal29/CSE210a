Language Used for HW1: Java
The code already contains the executable arith file
To execute the program, program arguments have to be given but in shell script '\*' is considered as a wildcard so * symbol has to be given in double quotes. 
For example: ./arith 4 + 2 "\*" 8

My ARITH interpreter implementation can handle addition, subtraction, multiplication and division.

Also, the I had to make a minor change in tests/harness.bash file to run the tests on my system.
Earlier code was:
```check() {
    run sh -c "echo '$1' | ./arith"
    echo "$1 = $2, your code outputs $output"
    [ "$output" = "$2" ]
}
```

Changes I made:
```check() {
    output=`sh -c "echo '$1' | xargs ./arith"`
    echo "$1 = $2, your code outputs $output"
    [ "$output" = "$2" ]
}
```

Created mytests.bats file in tests folder to run my tests.
Code Link: https://github.com/nmittal29/CSE210a
