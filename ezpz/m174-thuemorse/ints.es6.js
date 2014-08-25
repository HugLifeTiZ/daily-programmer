require("sugar");
const n = parseInt(process.argv[2]);
console.log("Calculating sequence to iteration %s.", n);
var seq = [0];
n.times(() => seq.add(seq.map(item => item === 1 ? 0 : 1)));
console.log(seq.join(""));
