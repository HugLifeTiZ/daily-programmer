using Lambda;

class Rule90 {
    static function main () {
        var line = Sys.args()[0].split("").map(Std.parseInt);
        for (_ in 0...25) {
            Sys.println([for (item in line) item > 0 ? "x" : " "].join(""));
            var i = 0;
            line = line.map(function (_) {
                return (i == 0 ? 0 : line[i - 1]) !=
                 (i == line.length - 1 ? 0 : line[++i]) ? 1 : 0;
            });
        }
    }
}
