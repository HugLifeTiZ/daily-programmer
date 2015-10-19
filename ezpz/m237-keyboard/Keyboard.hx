using Thx;
class Keyboard {
    static function main () {
        var words = sys.io.File.getContent(sys.FileSystem.exists("enable1.txt")
         ? "enable1.txt" : "/usr/share/dict/words").toLines();
        for (line in sys.io.File.getContent(Sys.args()[0]).toLines()) {
            if (~/^[a-z]+$/.match(line)) {
                var reg = new EReg("^[" + line + "]+$", "");
                var longest = words.filter.fn(reg.match(_))
                 .order.fn([a,b] => a.length - b.length).last();
                Sys.println('$line = $longest');
            }
        }
    }
}
