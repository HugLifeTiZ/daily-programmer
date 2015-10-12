using Thx;
class RandomBag {
    static var bag = [];
    static function main () {
        switch (Sys.args().length) {
        case 0:
            for (i in 0 ... 50) {
                if (bag.length == 0)
                    bag = ["O", "I", "S", "Z", "L", "J", "T"].shuffle();
                Sys.print(bag.pop() + (i == 49 ? "\n" : ""));
            }
        default:
            for (seq in Sys.args()) {
                var valid = seq.toArray().reduce(function (valid, char) {
                    if (bag.length == 0)
                        bag = ["O", "I", "S", "Z", "L", "J", "T"];
                    return valid && bag.remove(char);
                }, true);
                Sys.println(seq + (valid ? " VALID" : " INVALID"));
            }
        }
    }
}
