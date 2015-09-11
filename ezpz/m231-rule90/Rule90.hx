using Lambda;

class Rule90 {
    static function main () {
        var line = Sys.args()[0].split("").map(function(i) {return i == "1";});
        for (_ in 0...25) {
            Sys.println(line.map(function(i) {return i ? "x" : " ";}).join(""));
            var i = 0;
            line = line.map(function (_) {
                return (i == 0 ? false : line[i - 1]) !=
                 (i == line.length - 1 ? false : line[++i]);
            });
        }
    }
}
