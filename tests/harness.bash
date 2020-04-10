#!/usr/bin/env bash

check() {
    output=`sh -c "echo '$1' | xargs ./arith"`
    echo $output
    echo "$1 = $2, your code outputs $output"
    [ "$output" = "$2" ]
}
