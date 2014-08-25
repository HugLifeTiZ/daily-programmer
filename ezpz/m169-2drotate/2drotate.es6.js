require("sugar"); Object.extend();

var grid = require("fs").readFileSync(process.argv[2])
 .toString().lines().filter(x => x != "").map(y => y.words());

for (deg of [0, 90, 180, 270]) {
    console.log(deg + "° cw rotation:");
    console.log(grid.map(row => row.join(" ")).join("\n"));
    grid = grid.reverse();
    grid = grid[0].map((_, c) => grid.map(r => r[c]));
}

for (deg of [0, 90, 180, 270]) {
    console.log(deg + "° ccw rotation:");
    console.log(grid.map(row => row.join(" ")).join("\n"));
    grid = grid.map(r => r.reverse());
    grid = grid[0].map((_, c) => grid.map(r => r[c]));
}
