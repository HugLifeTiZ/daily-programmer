using Thx;

class Txt2Pbm {
    static function main () {
        switch (Sys.args().length) {
        case 0:
            Sys.println("Requires an output filename and then some words.");
            Sys.exit(1);
        case 1:
            Sys.println("Display mode. Too long? Use imagemagick's display.");
            for (row in sys.io.File.getContent(Sys.args()[0]).toLines()
             .slice(2).map.fn(row => row.split("").reduce.fn([prev, cur] => 
              prev + (cur == "1" ? "█" : "░"), ""))) Sys.println(row);
        default:
            var font = new Map<String, Array<String>>();
            for (c in sys.io.File.getContent("font.txt").toLines().groupsOf(8))
                if (c.compact().length == 8)
                    font[c[0].ifEmpty(" ")] = c.rest().map.fn(_.remove(" "));
            var word = Sys.args().rest().join(" ").toArray().filter.fn(
             font.keys().toArray().indexOf(_) >= 0).map.fn(font[_]);
            var out = word[0].mapi.fn([foo, idx] => word.map.fn(
             letter => letter[idx]).join("0"));
            var pix = ["P1", out[0].length + " " + out.length].concat(out);
            var file = sys.io.File.write(Sys.args()[0]);
            file.writeString(pix.join("\n"));
            file.close();
            Sys.println('Wrote PBM to ${Sys.args()[0]}');
        }
    }
}
