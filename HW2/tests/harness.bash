#!/usr/bin/env bash

check() {
    output=`sh -c "echo \"'$1'\" | xargs ./while.py"`
    echo "$1 = $2, your code outputs $output"
    [ "$output" = "$2" ]
}

checkOr() {
    output=`sh -c "echo \"'$1'\" | xargs ./while.py"`
    echo "$1 = $2 or $3, your code outputs $output"
    [ "$output" = "$2" ] || [ "$output" = "$3" ]
}
