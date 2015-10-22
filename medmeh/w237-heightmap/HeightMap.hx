using Thx;

typedef Box = { x1: Int, y1: Int, x2: Int, y2: Int, layer: Int };

class HeightMap {
    static var layers = ["#", "=", "-", "."];
    static var map: Array<Array<String>>;
    
    static function main () {
        map = sys.io.File.getContent(Sys.args()[0]).toLines()
         .filter.fn(~/^[\|\+\- ]+$/.match(_)).map.fn(_.toArray());
        paintBox(0, 0, map[0].length - 1, map.length - 1, 0);
        for (line in map)
            Sys.println(line.join(""));
    }
    
    static function paintBox (x1:Int, y1:Int, x2:Int, y2:Int, layer:Int) {
        var boxes: Array<Box> = [];
        for (y in (y1 + 1) ... y2)
            for (x in (x1 + 1) ... x2)
                if (!boxes.any.fn(inBox(x, y, _)))
                    switch (map[y][x]) {
                    case "+":
                        var tx = x + 1, ty = y + 1;
                        while (map[y][tx] != "+") tx++;
                        while (map[ty][x] != "+") ty++;
                        boxes.push({x1: x, y1: y, x2: tx, y2: ty,
                         layer: layer + 1});
                    case " ":
                        map[y][x] = layer < 4 ? layers[layer] : " ";
                    }
        for (box in boxes)
            paintBox(box.x1, box.y1, box.x2, box.y2, box.layer);
    }
    
    inline static function inBox (x, y, box)
        return box.x1 <= x && x <= box.x2 && box.y1 <= y && y <= box.y2;
}
