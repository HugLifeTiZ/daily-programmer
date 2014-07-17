require("traceur");
const _ = require("underscore-contrib");
_.str = require("underscore.string");
_.mixin(_.str.exports());

const values = {"A": 11, "J": 10, "Q": 10, "K": 10},
 ranks = {"ace": "A", "two": 2, "three": 3, "four": 4, "five": 5,
    "six": 6, "seven": 7, "eight": 8, "nine": 9, "ten": 10,
    "jack": "J", "queen": "Q", "king": "K"};

class Card {
    constructor (str)  { this.rank = ranks[_(str.toLowerCase()).words()[0]]; }
    get value ()  { return values[this.rank] || this.rank; }
}

class Player {
    constructor (str) {
        const split = str.split(": ");
        this.name = split[0];
        this.cards = _(split[1].split(", ")).map(c => new Card(c));
    }
    get value () {
        var aces = _(this.cards).filter(c => c.rank == "A").length;
        var retval = _(this.cards).reduce((p, c) => p += c.value, 0);
        for (; aces > 0 && retval > 21; aces--) {
            retval -= 10;
        }
        return retval > 21 ? 0 : (this.cards.length > 4 ? 99 : retval);
    }
}

var res = _.chain(require("fs").readFileSync(process.argv[2]).toString())
 .lines()
 .rest(1)
 .filter(line => _.strContains(line, ":"))
 .each(line => console.log(line))
 .map(line => new Player(line))
 .sortBy(player => -player.value)
 .value();
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
