#!/bin/sh
# Define inputs and output and then source this script in exercise's test.sh.
# Will compile appropriately, ensure tests passed and measure the program speed.
set -eu

puts () { printf %s\\n "$*"; }
header () {
    printf %s\\n "$(tput bold; tput setaf 6)=> $(tput setaf 7)$*$(tput sgr0)"
}
success () {
    printf %s\\n "$(tput bold; tput setaf 2)+++ $(tput setaf 7)$*$(tput sgr0)"
}
failure () {
    printf %s\\n "$(tput bold; tput setaf 1)!!! $(tput setaf 7)$*$(tput sgr0)"
}
check_lang () {
    if [ ! "${lang:-}" ]; then return 0; fi
    for val in "$@"; do if [ "${lang:-}" = "$val" ]; then return 0; fi; done
    return 1
}

run_tests () {
    dirname=$(basename "$PWD")
    exercise=${1:-${dirname##*-}}
    args=$(puts "$args" | sed '/./,$!d')
    output=$(puts "$output" | tac | sed '/./,$!d' | tac | sed '/./,$!d')
    
    if [ ! "${quiet:-}" ]; then
        header Testing "$exercise"
        header Input arguments are:
        puts "$args"
        header Expected result is:
        puts "$output"
    fi
    
    fails=""
    
    for file in "$exercise."*; do
    case "${file##*.}" in
        cr) if check_lang cr crystal; then
            header Building Crystal program
            crystal build -o "crystal.bin" "$file"
            do_test Crystal "./crystal.bin"
            fi ;;
        d) if check_lang d; then
            header Building D program
            ldc2 -of "ldc2.bin" "$file"
            do_test D "./ldc2.bin"
            fi ;;
        cs) if check_lang cs csharp; then
            header Building C\# program
            mcs -out:cs.exe "$file"
            do_test 'C#' mono "./cs.exe"
            fi ;;
        rb) if check_lang rb ruby; then
            do_test Ruby ruby "$file"
            fi ;;
    esac
    done
    
    if [ "$fails" ]; then
        failure The following langs failed: $fails
    else
        success All langs passed\!
    fi
}

passed_test () {
    if [ "${exact_match:-}" ]; then
        # shellcheck disable=SC2154
        [ "$result" = "$output" ]
    else
        # Make sure all the lines in the output are there.
        retval=0
        while read -r line; do
            if ! puts "$result" | grep -Eq -e "$line"; then retval=1; fi
        done << EOF
$output
EOF
        return "$retval"
    fi
}

exec_lines () {
    while read -r line; do
        eval '"$@" '"$line"
    done << EOF
$args
EOF
}

do_test () {
    current_lang="$1"; shift
    header Testing "$current_lang" program
    start=$(date +%s.%N)
    result=$(exec_lines "$@")
    #eval 'result=$("$@" '"$inputs"')'
    puts "$result"
    end=$(date +%s.%N)
    runtime=$(printf %s\\n "$end - $start" | bc -l)
    if passed_test; then
        success "Program passed test in ${runtime}s"
    else
        failure "Program FAILED test in ${runtime}s"
        fails="$fails $current_lang"
    fi
}


while getopts ql: OPT; do case "$OPT" in
    q) export quiet=1 ;;
    l) export lang="$OPTARG" ;;
    *) true ;;  # Just ignore nonsense options.
esac; done; shift $((OPTIND - 1))

run_tests "$@" 2>&1 | tee results.txt
