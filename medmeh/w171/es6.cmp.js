require("traceur");
require("sugar");
var data = Symbol();
var Image = function Image(input) {
  "use strict";
  input = input.words();
  $traceurRuntime.setProperty(this, data, input.map((function(row) {
    return parseInt("0x1" + row).toString(2).chars().slice(1).map((function(col) {
      return col === "1";
    }));
  })));
};
($traceurRuntime.createClass)(Image, {
  toString: function() {
    "use strict";
    return this[$traceurRuntime.toProperty(data)].map((function(row) {
      return row.reduce((function(prev, current) {
        return prev + (current ? "█" : "░");
      }), "");
    })).join("\n");
  },
  print: function() {
    "use strict";
    console.log(this.toString());
  },
  invert: function() {
    "use strict";
    $traceurRuntime.setProperty(this, data, this[$traceurRuntime.toProperty(data)].map((function(row) {
      return row.map((function(col) {
        return !col;
      }));
    })));
  },
  rotate: function(left) {
    "use strict";
    var $__0 = this;
    $traceurRuntime.setProperty(this, data, left ? this[$traceurRuntime.toProperty(data)].map((function(row) {
      return row.reverse();
    })) : this[$traceurRuntime.toProperty(data)].reverse());
    $traceurRuntime.setProperty(this, data, this[$traceurRuntime.toProperty(data)][0].map((function(_, col) {
      return $__0[$traceurRuntime.toProperty(data)].map((function(row) {
        return row[$traceurRuntime.toProperty(col)];
      }));
    })));
  },
  rotateRight: function() {
    "use strict";
    this.rotate();
  },
  rotateLeft: function() {
    "use strict";
    this.rotate(true);
  },
  zoomIn: function() {
    "use strict";
    $traceurRuntime.setProperty(this, data, this[$traceurRuntime.toProperty(data)].map((function(row) {
      return [row.map((function(col) {
        return [col, col];
      })).flatten(1), row.map((function(col) {
        return [col, col];
      })).flatten(1)];
    })).flatten(1));
  },
  zoomOut: function() {
    "use strict";
    $traceurRuntime.setProperty(this, data, this[$traceurRuntime.toProperty(data)].map((function(row, rIdx) {
      return rIdx % 2 ? row.map((function(col, cIdx) {
        return cIdx % 2 ? col : null;
      })).compact() : null;
    })).compact());
  },
  getOp: function(op) {
    "use strict";
    var ops = {
      "invert": this.invert,
      "inv": this.invert,
      "rotateright": this.rotateRight,
      "rotater": this.rotateRight,
      "rotatecw": this.rotateRight,
      "rotcw": this.rotateRight,
      "rotateleft": this.rotateLeft,
      "rotatel": this.rotateLeft,
      "rotateccw": this.rotateLeft,
      "rotccw": this.rotateLeft,
      "rotr": this.rotateRight,
      "rotl": this.rotateLeft,
      "zoomin": this.zoomIn,
      "zoomout": this.zoomOut,
      "zoom": this.zoomIn,
      "unzoom": this.zoomOut
    };
    return ops[$traceurRuntime.toProperty(op)];
  }
}, {});
var image = new Image(process.argv[2]);
var ops = process.argv.slice(3).map((function(o) {
  return o.toLowerCase();
}));
console.log("original:");
image.print();
for (var $__2 = ops[$traceurRuntime.toProperty(Symbol.iterator)](),
    $__3; !($__3 = $__2.next()).done; ) {
  op = $__3.value;
  {
    try {
      throw undefined;
    } catch (opFunc) {
      {
        opFunc = image.getOp(op);
        if (opFunc) {
          console.log(op + ":");
          opFunc.apply(image);
          image.print();
        } else {
          console.log("unknown operation " + op + "; skipping.");
        }
      }
    }
  }
}
