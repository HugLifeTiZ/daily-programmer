using Thx;

class HexBitmap {
    static function main () {
        for (line in Sys.args()
         .map.fn(item => ("0x1" + item).toInt().toBase(2).toArray().rest()
          .reduce.fn([prev, cur] => prev + (cur == "1" ? "█" : "░"), ""))
         ) Sys.println(line);
    }
}
