#!/usr/bin/env node
const _ = require("underscore-contrib");
_.str = require("underscore.string");
_.mixin(_.str.exports());

const values = {"A": 11, "J": 10, "Q": 10, "K": 10},
 ranks = {"ace": "A", "two": 2, "three": 3, "four": 4, "five": 5,
    "six": 6, "seven": 7, "eight": 8, "nine": 9, "ten": 10,
    "jack": "J", "queen": "Q", "king": "K"};

function parseCard (str)  { return ranks[_(str.toLowerCase()).words()[0]]; }
function cardValue (card)  { return values[card] || card; }
function parsePlayer (str) {
    const split = str.split(": ");
    return {"name": split[0], "cards": _(split[1].split(", ")).map(parseCard)};
}
function playerValue (player) {
    var aces = _(player.cards).filter(function (c) { return c == "A" }, 0)
     .length;
    var retval = _(player.cards)
     .reduce(function (p, c) { return p += cardValue(c); }, 0);
    for (; aces > 0 && retval > 21; aces --) {
        retval -= 10;
    }
    return retval > 21 ? 0 : (player.cards.length > 4 ? 99 : retval);
}

var res = _.chain(require("fs").readFileSync(process.argv[2]).toString())
 .lines()
 .rest(1)
 .filter(_(_.strContains).partial(_, ":"))
 .each(_.unary(console.log))
 .map(parsePlayer)
 .sortBy(playerValue)
 .reverse()
 .value();
if (!playerValue(res[0])) {
    console.log("Everyone busted. Good job.");
} else if (res.length > 2 &&
 _.eq(playerValue(res[0]), playerValue(res[1]), playerValue(res[2]))) {
    console.log("A bunch of people tied.");
} else if (playerValue(res[0]) == playerValue(res[1])) {
    console.log(_("%s and %s tied.").sprintf(res[0].name, res[1].name));
} else if (playerValue(res[0]) == 99) {
    console.log(_("%s wins with a five-card trick!").sprintf(res[0].name));
} else if (playerValue(res[0]) == 21) {
    console.log(_("%s wins with Blackjack!").sprintf(res[0].name));
} else {
    console.log(_("%s wins with %s.").sprintf(res[0].name,
     playerValue(res[0])));
}
