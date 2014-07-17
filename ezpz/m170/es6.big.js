require("traceur"); require("sugar");

const suits = ["♥", "♦", "♠", "♣"],
 ranks = ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K"],
 values = {"A": 11, "J": 10, "Q": 10, "K": 10},
 suitStrings = {"hearts": 0, "diamonds": 1, "spades": 2, "clubs": 3},
 rankStrings = {"ace": "A", "two": 2, "three": 3, "four": 4,
    "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9,
    "ten": 10, "jack": "J", "queen": "Q", "king": "K"};

class Card {
    static parse (str) {
        str = str.toLowerCase().words();
        return new Card(rankStrings[str[0]], suitStrings[str[2]]);
    }
    constructor (rank, suit)  { this.rank = rank; this.suit = suit; }
    get value ()  { return values[this.rank] || this.rank; }
}

class Player {
    static parse (str) {
        var split = str.split(": ");
        return new Player(split[0],
         ...split[1].split(", ").map(c => Card.parse(c)));
    }
    constructor (name, ...cards) { this.name = name; this.cards = cards; }
    get value () {
        var aces = 0;
        var retval = this.cards.reduce((p, c) => {
            aces += (c.rank == "A") ? 1 : 0;
            return p += c.value;
        }, 0);
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
 .map(Player.parse)
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
