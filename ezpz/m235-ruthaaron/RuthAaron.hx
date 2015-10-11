using Thx;

class RuthAaron {
    static var regex = ~/\(([\d]+),\s*([\d]+)\)/;
    
    static function main () {
        var file = sys.io.File.read(Sys.args()[0]);
        for (line in sys.io.File.getContent(Sys.args()[0]).toLines()) {
            if (regex.match(line)) {
                Sys.println(regex.matched(0) + " " +
                 (regex.matched(1).toInt() + 1 == regex.matched(2).toInt() &&
                  primeFacSum(regex.matched(1).toInt()) ==
                  primeFacSum(regex.matched(2).toInt()) ?
                  "VALID" : "INVALID"));
            }
        }
    }
    
    static inline function primeFacSum (x: Int) {
        var sum = 0, n = 2;
        while (n <= x) {
            if (x % n == 0) {
                sum += n;
                while (x % n == 0) x = Std.int(x / n);
            }
            n++;
        }
        return sum;
    }
}
