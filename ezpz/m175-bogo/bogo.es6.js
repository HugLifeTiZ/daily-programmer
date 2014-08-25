require("sugar");
var iters = 0, [mess, target] = process.argv.slice(2);
for (; mess != target; iters++) mess = mess.chars().randomize().join("");
console.log("%s ITERS, THIS IS STUPID", iters);
