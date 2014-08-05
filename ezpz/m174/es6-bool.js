require("sugar");
const n = parseInt(process.argv[2]);
console.log("Calculating sequence to iteration %s.", n);
var seq = [false];
n.times(() => seq.add(seq.map(item => !item)));
console.log(seq.map(item => item ? 1 : 0).join(""));
