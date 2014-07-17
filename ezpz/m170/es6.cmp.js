require("traceur");
var _ = require("underscore-contrib");
_.str = require("underscore.string");
_.mixin(_.str.exports());
var values = {
  "A": 11,
  "J": 10,
  "Q": 10,
  "K": 10
},
    ranks = {
      "ace": "A",
      "two": 2,
      "three": 3,
      "four": 4,
      "five": 5,
      "six": 6,
      "seven": 7,
      "eight": 8,
      "nine": 9,
      "ten": 10,
      "jack": "J",
      "queen": "Q",
      "king": "K"
    };
var Card = function Card(str) {
  "use strict";
  this.rank = ranks[$traceurRuntime.toProperty(_(str.toLowerCase()).words()[0])];
};
($traceurRuntime.createClass)(Card, {get value() {
    "use strict";
    return values[$traceurRuntime.toProperty(this.rank)] || this.rank;
  }}, {});
var Player = function Player(str) {
  "use strict";
  var split = str.split(": ");
  this.name = split[0];
  this.cards = _(split[1].split(", ")).map((function(c) {
    return new Card(c);
  }));
};
($traceurRuntime.createClass)(Player, {get value() {
    "use strict";
    var aces = _(this.cards).filter((function(c) {
      return c.rank == "A";
    })).length;
    var retval = _(this.cards).reduce((function(p, c) {
      return p += c.value;
    }), 0);
    for (; aces > 0 && retval > 21; aces--) {
      retval -= 10;
    }
    return retval > 21 ? 0 : (this.cards.length > 4 ? 99 : retval);
  }}, {});
var res = _.chain(require("fs").readFileSync(process.argv[2]).toString()).lines().rest(1).filter((function(line) {
  return _.strContains(line, ":");
})).each((function(line) {
  return console.log(line);
})).map((function(line) {
  return new Player(line);
})).sortBy((function(player) {
  return -player.value;
})).value();
if (!res[0].value) {
  console.log("Everyone busted. Good job.");
} else if (res.length > 2 && _.eq(res[0].value, res[1].value, res[2].value)) {
  console.log("A bunch of people tied.");
} else if (res[0].value == res[1].value) {
  console.log(_("%s and %s tied.").sprintf(res[0].name, res[1].name));
} else if (res[0].value == 99) {
  console.log(_("%s wins with a five-card trick!").sprintf(res[0].name));
} else if (res[0].value == 21) {
  console.log(_("%s wins with Blackjack!").sprintf(res[0].name));
} else {
  console.log(_("%s wins with %s.").sprintf(res[0].name, res[0].value));
}
