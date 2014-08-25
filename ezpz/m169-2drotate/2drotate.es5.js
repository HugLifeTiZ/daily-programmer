var _ = require("underscore-contrib");
var grid = _.map(
    _.filter(
        require("fs").readFileSync(process.argv[2]).toString().split("\n"),
        function (x) { return x != ""; }
    ),
    function (y) { return y.split(" "); }
);

_.each([0, 90, 180, 270], function (deg) {
    console.log(deg + "° rotation:");
    console.log(_.map(grid, function (row) { return row.join(" "); }).join("\n"));
    grid = _.zip.apply(null, grid.reverse());
});
