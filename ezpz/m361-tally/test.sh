#!/bin/sh

args='abcde dbbaCEDbdAacCEAadcB EbAAdbBEaBaaBBdAccbeebaec'

output='
a: 1, b: 1, c: 1, d: 1, e: 1
b: 2, d: 2, a: 1, c: 0, e: -2
c: 3, d: 2, a: 1, e: 1, b: 0
'

. ../../test.sh
