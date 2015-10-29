using Thx;
class Hacking {
    static function main () {
        var diff = getDiff();
        var count = [5, 8, 10, 12, 15][diff],
         length = [4, 7, 9, 12, 15][diff];
        var words = sys.io.File.getContent("enable1.txt").toLines()
         .filter.fn(_.length == length).sample(count);
        var target = words.sampleOne().toArray();
        for (w in words) Sys.println(w.toUpperCase());
        var matches = 0, tries = 5;
        while (tries-- > 0 && length > (matches = getMatches(target)))
            Sys.println('You got $matches/$length. $tries tries remain.');
        Sys.println(length == matches ? "Access granted." : "ACCESS DENIED.");
    }
    
    static function getMatches (target: Array<String>) {
        Sys.print("Make a guess: ");
        var guess = Sys.stdin().readLine().toArray(), matches = 0;
        for (i in 0 ... Std.int(Math.min(target.length, guess.length)))
            if (target[i].toUpperCase() == guess[i].toUpperCase()) matches++;
        return matches;
    }
    
    static function getDiff () {
        var diff = -1;
        while (diff < 0 || diff > 4) {
            Sys.print("Select difficulty, 1-5: ");
            diff = Sys.stdin().readLine().toInt() - 1;
        }
        return diff;
    }
}
