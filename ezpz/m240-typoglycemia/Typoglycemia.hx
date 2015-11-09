using Thx;
class Typoglycemia {
    static function main () {
        Sys.println(~/\s/g.split(sys.io.File.getContent(Sys.args()[0])).map(
         function (word) {
            var arr = word.toArray();
            var len = arr.length - 1;
            while (len > 3 && !~/^[A-Za-z]$/.match(arr[len])) len--;
            if (len < 3) return word;
            return [[arr[0]], arr.slice(1, len).shuffle(), arr.slice(len)]
             .flatten().join("");
        }).compact().join(" "));
    }
}
