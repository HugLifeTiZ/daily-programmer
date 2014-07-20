require("traceur"); require("sugar"); Object.extend();
const {readFileSync} = require("fs");

const [firsts, lasts] = ["first.txt", "last.txt"].map(file =>
 readFileSync(file).toString().lines());
var grades = {};

parseInt(process.argv[2] || 10).times(() => {
    var name;
    while ((name = lasts.randomize()[0] + ", " + firsts.randomize()[0])
     in grades) { null; }
    grades[name] = [1, 2, 3, 4, 5].map(() => Number.random(70, 100)).join(" ");
    console.log(name + ": " + grades[name]);
});
