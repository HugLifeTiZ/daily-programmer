using Thx;
class RandomBag {
    static function main () {
        var bag = [];
        for (i in 0 ... 50) {
            if (bag.length == 0)
                bag = ["O", "I", "S", "Z", "L", "J", "T"].shuffle();
            Sys.print(bag.pop() + (i == 49 ? "\n" : ""));
        }
    }
}
