using Thx;

class Grandma {
    static var pointReg = ~/^\((-?[\d]+\.[\d]+),\s?(-?[\d]+\.[\d]+)\)$/;
    
    static function main () {
        var points = [];
        for (line in sys.io.File.getContent(Sys.args()[0]).toLines()) {
            if (pointReg.match(line)) {
                points.push(new Point(
                 pointReg.matched(1).toFloat(),
                 pointReg.matched(2).toFloat()));
            }
        }
        
        if (points.length < 1) {
            Sys.println("No points given.");
            Sys.exit(1);
        }
        
        var shortest1 = null, shortest2 = null, 
         shortest_dist = Math.POSITIVE_INFINITY;
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
        return ((this.x - that.x).pow(2) + (this.y - that.y).pow(2)).sqrt();
    
    public function toString () return '(${this.x}, ${this.y})';
}
