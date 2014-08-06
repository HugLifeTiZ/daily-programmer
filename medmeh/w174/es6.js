require("sugar");
const gm = require("gm");

if (process.argv.length < 3) {
    console.log("Need username to avatarify.");
    process.exit(1);
}

const bgColors = [
    "#333", "#633", "#363", "#336", "#663", "#636", "#366", "#666"
], fgColors = [
    "#aaa", "#daa", "#ada", "#aad", "#dda", "#dad", "#add", "#ddd"
]

// The username is the seed for the "RNG".
var seed = process.argv[2].codes().reduce((prev, cur) => prev + cur, 0);
function rand(max) {  // Magic random numbers used here.
    seed = (seed * 9301 + 49297) % 233280;
    return (seed / 233280 * max).round();
}

const pixels = rand((2).pow(32) - 1).toString(2).padLeft(32, 0).chars(),
 bgColor = bgColors[rand(7)], fgColor = fgColors[rand(7)];

var canvas = gm(8, 8, bgColor).fill(fgColor);
pixels.each((bit, index) => {
    if (bit == 1) {
        let y = (index / 4).floor(), x1 = index % 8, x2 = 7 - x1; 
        canvas.drawPoint(x1, y);
        canvas.drawPoint(x2, y);
    }
});
canvas.scale(800, "%").write(process.argv[2] + ".png",
 err => err ? console.log(err.toString()) : null);
