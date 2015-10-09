using Thx;

class HexBitmap {
    static function main () {
        for (line in Sys.args()
         .map.fn(item => Ints.toString(Ints.parse("0x1" + item),2)
          .split("")
          .rest()
          .reduce.fn([prev, cur] => prev + (cur == "1" ? "█" : "░"), ""))
         ) Sys.println(line);
    }
}
