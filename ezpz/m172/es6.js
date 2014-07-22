require("sugar"); Object.extend();
const {readFileSync, writeFileSync} = require("fs");

if (process.argv.length < 3) {
    console.log("Requires an output filename and then some words.");
    process.exit(1);
} else if (process.argv.length < 4) {  // Does this look familiar?
    console.log("Display mode. If it's too long, use imagemagick's display.");
    readFileSync(process.argv[2]).toString().lines().slice(2).map(row =>
        row.chars().reduce((prev, current) => prev + (current == 1 ? "█" : "░"),
         "")).each(row => console.log(row));
} else {  // Write mode.
    const font = readFileSync("font.txt").toString().lines().add([
        " ",
        "0 0 0 0",
        "0 0 0 0",
        "0 0 0 0",
        "0 0 0 0",
        "0 0 0 0",
        "0 0 0 0",
        "0 0 0 0"
     ]).inGroupsOf(8).reduce((font, group) => {
        font[group[0]] = group.slice(1).map(row => row.remove(/[\s]/g));
        return font;
     }, {});
    var word = process.argv.slice(3).join(" ").chars()
     .filter(char => char in font).map(letter => font[letter]);
    word = word[0].map((_, idx) => word.map(letter => letter[idx]).join("0"));
    var pix = ["P1", word[0].length + " " + word.length].add(word);
    writeFileSync(process.argv[2], pix.join("\n"));
    console.log("Wrote PBM to %s.", process.argv[2]);
}
