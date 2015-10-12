using Thx;
class RandomBag {
    static var bag = [];
    static var max = 50;
    static function main () {
        if (Sys.args().length > 0 && Sys.args()[0].canParse())
            max = Sys.args()[0].toInt();
        if (Sys.args().length == 0 || Sys.args()[0].canParse()) {
            for (i in 0 ... max) {
                refillBag();
                Sys.print(bag.pop() + (i == max - 1 ? "\n" : ""));
            }
        } else {
            for (seq in Sys.args()) {
                var valid = seq.toArray().reduce(function (valid, char) {
                    refillBag();
                    return valid && bag.remove(char);
                }, true);
                Sys.println(seq + (valid ? " VALID" : " INVALID"));
            }
        }
    }
    static function refillBag ()
        if (bag.length == 0) bag = ["O","I","S","Z","L","J","T"].shuffle();
}
