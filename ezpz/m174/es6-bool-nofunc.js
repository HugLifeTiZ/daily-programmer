require("sugar");
const n = parseInt(process.argv[2]), silent = process.argv[3] == "silent";
console.log("Calculating sequence to iteration %s.", n);
var seq = [false], currentLength = 1;
for (var reps = 0; reps < n; reps++) {
    for (var idx = 0; idx < currentLength; idx++) {
        seq.add(!seq[idx]);
    }
    currentLength *= 2;
}
console.log(silent ? "Done." : seq.map(item => item ? 1 : 0).join(""));
