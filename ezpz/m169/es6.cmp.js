var _ = require("underscore");
var readFileSync = $traceurRuntime.assertObject(require("fs")).readFileSync;
var grid = readFileSync(process.argv[2]).toString().split("\n").filter((function(x) {
  return x != "";
})).map((function(y) {
  return y.split(" ");
}));
for (var $__0 = [0, 90, 180, 270][Symbol.iterator](),
    $__1; !($__1 = $__0.next()).done; ) {
  deg = $__1.value;
  {
    console.log(deg + "° rotation:");
    console.log(grid.map((function(row) {
      return row.join(" ");
    })).join("\n"));
    grid = _.zip.apply(null, grid.reverse());
  }
}
