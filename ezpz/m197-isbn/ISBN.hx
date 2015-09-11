using StringTools;
using Lambda;

class ISBN {
    static function main () {
        var idx = 0;
        Sys.println(Sys.args()[0]
         .replace("-", "")
         .toUpperCase()
         .split("")
         .map(function (char) {
            return char == "X" ? 10 : Std.parseInt(char);
         })
         .fold(function (res, cur) {
            return res + cur * (10 - idx);
         }, 0) % 11 == 0 ? "Valid ISBN" : "Invalid ISBN");
    }
}
