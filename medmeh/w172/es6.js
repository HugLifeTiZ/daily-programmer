require("sugar"); Object.extend();
const {readFileSync} = require("fs");
const gm = require("gm");

if (process.argv.length < 4) {
    console.log("Need input filename followed by output filename.");
    process.exit(1);
} else {
    const src = readFileSync(process.argv[2]).toString().lines().slice(2)
     .filter(line => !line.isBlank()).map(row => row.chars()
     .map(col => col == 1 ? true : false))
    var dest = gm(src[0].length, src.length, "#fff").stroke("#000", 1);
    src.each((row, y) => row.each((col, x) => { 
        if (src[y][x]) dest.drawPoint(x, y);
    }));
    dest.scale(400, null, "%").blur(1, 1).write(process.argv[3], 
     err => err ? console.log(err.toString()) : null);
}
