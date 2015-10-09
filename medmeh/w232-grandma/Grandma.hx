import Math.*;

class Grandma {
    static var pointReg = ~/^\((-?[\d]+\.[\d]+),\s?(-?[\d]+\.[\d]+)\)$/;
    
    static function main () {
        var file = sys.io.File.read(Sys.args()[0]);
        
        var points = [];
        try while (true) {
            if (pointReg.match(file.readLine())) {
                points.push(new Point(
                 Std.parseFloat(pointReg.matched(1)),
                 Std.parseFloat(pointReg.matched(2))));
            }
        } catch (_:haxe.io.Eof) { }
        
        if (points.length < 1) {
            Sys.println("No points given.");
            Sys.exit(1);
        }
        
        var shortest1 = null;
        var shortest2 = null;
        var shortest_dist = POSITIVE_INFINITY;
        for (a in 0...(points.length - 1)) {
            for (b in (a + 1)...points.length) {
                var dist = points[a].distanceFrom(points[b]);
                if (dist < shortest_dist) {
                    shortest1 = points[a];
                    shortest2 = points[b];
                    shortest_dist = dist;
                }
            }
        }
        
        Sys.println('$shortest1 $shortest2');
    }
}

@:tink class Point {
    public var x (default, null): Float = _;
    public var y (default, null): Float = _;
    
    public function distanceFrom (that: Point)
        return sqrt(pow(this.x - that.x, 2) + pow(this.y - that.y, 2));
    
    public function toString () return '(${this.x}, ${this.y})';
}
