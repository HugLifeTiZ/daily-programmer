import haxe.io.Eof;
import sys.FileSystem;
import sys.io.File;
using Lambda;

class Palindrome {
    static function main () {
        var file = File.read(Sys.args()[0]);
        
        var array = [];
        try {
            while (true) array.push(file.readLine());
        } catch (e:Eof) { }
        
        var str = array.join("").toLowerCase().split("").filter(
         function (item) { return ~/[a-z]/i.match(item); }).join("");
        if (str == "") {
            Sys.println("Empty input!");
            Sys.exit(1);
        }
        var rev = str.split("").copy();
        rev.reverse();  // Haxe's reverse modifies the array in place.
        Sys.println(str == rev.join("") ? "Palindrome" : "Not a palindrome");
    }
}
