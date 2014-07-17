var _ = require("underscore");
var {readFileSync} = require("fs");
var grid = readFileSync(process.argv[2]).toString().split("\n").filter(
 (x) => { return x != ""; }).map((y) => { return y.split(" "); });

for (deg of [0, 90, 180, 270]) {
    console.log(deg + "° rotation:");
    console.log(grid.map((row) => { return row.join(" "); }).join("\n"));
    grid = _.zip.apply(null, grid.reverse());
}
