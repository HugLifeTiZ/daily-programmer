#!/usr/bin/env node
process.argv
 .slice(2)
 .map(function (item) { 
    console.log(parseInt("1" + item, 16)
     .toString(2)
     .split("")
     .slice(1)
     .reduce(function (prev, current) {
        return prev + (current == 1 ? "█" : "░")
     }, ""));
});
