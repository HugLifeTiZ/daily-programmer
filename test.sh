#!/bin/bash
# Define inputs and output and then source this script in exercise's test.sh.
# Will compile appropriately, ensure tests passed and measure the program speed.

header () {
    echo -e "$(tput bold; tput setaf 6)=> $(tput setaf 7)$*$(tput sgr0)"
}
success () {
    echo -e "$(tput bold; tput setaf 2)+++ $(tput setaf 7)$*$(tput sgr0)"
}
failure () {
    echo -e "$(tput bold; tput setaf 1)!!! $(tput setaf 7)$*$(tput sgr0)"
}

run_tests () {
    dirname=$(basename "$PWD")
    exercise=${1:-${dirname##*-}}
    output=$(tail -n +2 <<< "$output")
    
    if [[ ! "$quiet" ]]; then
        header Testing "$exercise"
        header Input arguments are:
        echo "${inputs[@]}"
        header Expected result is:
        cat <<< "$output"
    fi
    
    for file in $exercise.*; do
    case "${file##*.}" in
        cr) if [[ ! "$lang" || "$lang" == "cr" || "$lang" == "crystal" ]]; then
            header Building Crystal program
            crystal build -o "crystal.bin" "$file"
            header Testing Crystal program
            do_test "./crystal.bin"
            fi ;;
        d) if [[ ! "$lang" || "$lang" == "d" ]]; then
            header Building D program
            ldc2 -of "ldc2.bin" "$file"
            header Testing D program
            do_test "./ldc2.bin"
            fi ;;
        rb) if [[ ! "$lang" || "$lang" == "rb" || "$lang" == "ruby" ]]; then
            header Testing Ruby program
            do_test ruby "$file"
            fi ;;
    esac
    done
}

passed_test () {
    if [[ "$exact_match" ]]; then
        [[ "$result" == "$output" ]]
    else
        # Make sure all the lines in the output are there.
        retval=0
        while read -r line; do
            if ! grep -Eq -e "$line" <<< "$result"; then retval=1; fi
        done <<< "$output"
        return "$retval"
    fi
}

do_test () {
    start=$(date +%s.%N)
    result=$("$@" "${inputs[@]}")
    cat <<< "$result"
    end=$(date +%s.%N)
    runtime=$(bc -l <<< "$end - $start")
    if passed_test; then
        success "Program passed test in ${runtime}s"
    else
        failure "Program FAILED test in ${runtime}s"
    fi
}

while getopts ql: OPT; do case "$OPT" in
    q) export quiet=1 ;;
    l) export lang="$OPTARG" ;;
esac; done; shift $((OPTIND - 1))

run_tests "$@"
