require("traceur"); require("sugar");

const values = {"A": 11, "J": 10, "Q": 10, "K": 10},
 ranks = {"ace": "A", "two": 2, "three": 3, "four": 4, "five": 5,
    "six": 6, "seven": 7, "eight": 8, "nine": 9, "ten": 10,
    "jack": "J", "queen": "Q", "king": "K"};

class Card {
    constructor (str)  { this.rank = ranks[str.toLowerCase().words()[0]]; }
    get value ()  { return values[this.rank] || this.rank; }
}

class Player {
    constructor (str) {
        const split = str.split(": ");
        this.name = split[0];
        this.cards = split[1].split(", ").map(c => new Card(c));
    }
    get value () {
        var aces = this.cards.filter(c => c.rank == "A").length;
        var retval = this.cards.reduce((p, c) => p += c.value, 0);
        for (; aces > 0 && retval > 21; aces--) {
            retval -= 10;
        }
        return retval > 21 ? 0 : (this.cards.length > 4 ? 99 : retval);
    }
}

var res = require("fs").readFileSync(process.argv[2])
 .toString()
 .lines()
 .slice(1)
 .filter(line => line.has(":"))
 .each(line => console.log(line))
 .map(line => new Player(line))
 .sortBy("value")
 .reverse();
if (!res[0].value) {
    console.log("Everyone busted. Good job.");
} else if (res.length > 2 && res[0].value == res[1].value && res[1].value ==
 res[2].value) {
    console.log("A bunch of people tied.");
} else if (res[0].value == res[1].value) {
    console.log("{1} and {2} tied.".assign(res[0].name, res[1].name));
} else if (res[0].value == 99) {
    console.log("{1} wins with a five-card trick!".assign(res[0].name));
} else if (res[0].value == 21) {
    console.log("{1} wins with Blackjack!".assign(res[0].name));
} else {
    console.log("{1} wins with {2}.".assign(res[0].name, res[0].value));
}
