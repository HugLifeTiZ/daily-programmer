require("traceur");
require("sugar");
Object.extend();
var readFileSync = $traceurRuntime.assertObject(require("fs")).readFileSync;
var $__0 = $traceurRuntime.assertObject(["first.txt", "last.txt"].map((function(file) {
  return readFileSync(file).toString().lines();
}))),
    firsts = $__0[0],
    lasts = $__0[1];
var grades = {};
parseInt(process.argv[2] || 10).times((function() {
  var name;
  while ($traceurRuntime.toProperty((name = lasts.randomize()[0] + ", " + firsts.randomize()[0])) in grades) {
    null;
  }
  $traceurRuntime.setProperty(grades, name, [1, 2, 3, 4, 5].map((function() {
    return Number.random(70, 100);
  })).join(" "));
  console.log(name + ": " + grades[$traceurRuntime.toProperty(name)]);
}));
