require("traceur");
var decks = parseInt(process.argv[2]) || 1;
var attempts = parseInt(process.argv[3]) || decks * 26;
var suits = ["♥", "♦", "♠", "♣"];
var cards = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"];
var values = {
  "A": 11,
  "2": 2,
  "3": 3,
  "4": 4,
  "5": 5,
  "6": 6,
  "7": 7,
  "8": 8,
  "9": 9,
  "10": 10,
  "J": 10,
  "Q": 10,
  "K": 10
};
var deck = (function() {
  var $__0 = 0,
      $__1 = [];
  for (var $__6 = Array(decks)[$traceurRuntime.toProperty(Symbol.iterator)](),
      $__7; !($__7 = $__6.next()).done; ) {
    try {
      throw undefined;
    } catch (d) {
      {
        d = $__7.value;
        for (var $__4 = suits[$traceurRuntime.toProperty(Symbol.iterator)](),
            $__5; !($__5 = $__4.next()).done; ) {
          try {
            throw undefined;
          } catch (s) {
            {
              s = $__5.value;
              for (var $__2 = cards[$traceurRuntime.toProperty(Symbol.iterator)](),
                  $__3; !($__3 = $__2.next()).done; ) {
                try {
                  throw undefined;
                } catch (c) {
                  {
                    c = $__3.value;
                    $traceurRuntime.setProperty($__1, $__0++, [c, s]);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return $__1;
}()).sort((function() {
  return 0.5 - Math.random();
}));
var rate = 0;
for (var count = 0; count < attempts && deck.length > 1; count++) {
  var hand = [deck.pop(), deck.pop()];
  var res;
  while ((res = hand.reduce((function(p, c) {
    return p + values[$traceurRuntime.toProperty(c[0])];
  }), 0)) < 11 && deck.length > 0) {
    hand.push(deck.pop());
  }
  rate += (res == 21 ? 1 : 0);
  console.log(hand.reduce((function(p, c) {
    return p + c[1] + c[0] + " ";
  }), "") + "= " + res + (res == 21 ? "; Blackjack!" : ""));
}
;
console.log("Success rate with " + decks + " deck(s) after " + attempts + " attempts: " + rate / attempts * 100 + "%");
