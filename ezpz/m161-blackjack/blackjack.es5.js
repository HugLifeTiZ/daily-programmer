#!/usr/bin/env node
const decks = parseInt(process.argv[2]) || 1;
const attempts = parseInt(process.argv[3]) || decks * 26;
const suits = ["♥", "♦", "♠", "♣"];
const cards = ["A", "2", "3", "4", "5", "6",
 "7", "8", "9", "10", "J", "Q", "K"];
const values = {"A": 11, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6,
 "7": 7, "8": 8, "9": 9, "10": 10, "J": 10, "Q": 10, "K": 10};
var deck = [];
Array.apply(null, Array(decks)).forEach(function () {
    suits.forEach(function (s) {
        cards.forEach(function (c) {
            deck.push([c, s]);
        });
    });
});
deck = deck.sort(function () { return 0.5 - Math.random(); });
var rate = 0;
for (var count = 0; count < attempts && deck.length > 1; count++) {
    var hand = [deck.pop(), deck.pop()];
    var res;
    while ((res = hand.reduce(function (p, c) {
        return p + values[c[0]];
    }, 0)) < 11 && deck.length > 0) {
        hand.push(deck.pop());
    }
    rate += (res == 21 ? 1 : 0);
    console.log(hand.reduce(function (p, c) {
        return p + c[1] + c[0] + " ";
    }, "") + "= " + res + (res == 21 ? "; Blackjack!" : ""));
};
console.log("Success rate with " + decks + " deck(s) after " + attempts +
 " attempts: " + rate / attempts * 100 + "%");
