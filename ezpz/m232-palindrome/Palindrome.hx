using Lambda;
class Palindrome {
    static function main () {
        // We don't need a number of lines but it's in the spec
        // for the challenge so we just toss it.
        var string = Sys.args().slice(1).join("").toLowerCase().split("")
         .filter(function (item) { return ~/[a-z]/i.match(item); }).join("");
        var reverse = string.split("").copy();
        reverse.reverse();  // Haxe's reverse modifies the array in place.
        Sys.println(string == reverse.join("") ?
         "Palindrome" : "Not a palindrome");
    }
}
