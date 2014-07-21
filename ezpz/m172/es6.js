require("sugar"); Object.extend();
const {readFileSync, writeFileSync} = require("fs");

if (process.argv.length < 3) {
    console.log("Requires an output filename and then some words.");
    process.exit(1);
} else if (process.argv.length < 4) {
    // Display mode. Does this look familiar?
    console.log("Display mode.");
    console.log("You should use imagemagick display instead or pipe to less.");
    readFileSync(process.argv[2]).toString().lines().slice(2).map(row =>
        row.chars()
         .reduce((prev, current) => prev + (current == 1 ? "█" : "░"), ""))
         .each(row => console.log(row));
} else {
    // Write mode.
    var font = {};
    readFileSync("font.txt").toString().lines().add([
     " ",
     "0 0 0 0 0",
     "0 0 0 0 0",
     "0 0 0 0 0",
     "0 0 0 0 0",
     "0 0 0 0 0",
     "0 0 0 0 0",
     "0 0 0 0 0"
     ]).inGroupsOf(8).each(group => font[group[0]] = group
      .slice(1).map(row => row.remove(/[ ]/g)));
    var word = process.argv.slice(3).join(" ").toUpperCase().remove(/[^A-Z ]/g)
     .chars().map(letter => font[letter]);
    word = word[0].map((_, index) => word.map(letter => letter[index])
     .join("0"));
    var pix = ["P1", word[0].length + " " + word.length];
    pix.add(word);
    writeFileSync(process.argv[2], pix.join("\n"));
    console.log("Wrote PBM to %s.", process.argv[2]);
}
