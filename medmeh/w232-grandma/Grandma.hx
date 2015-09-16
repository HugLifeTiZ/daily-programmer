import haxe.io.Eof;
import sys.io.File;
import Math.*;
import Sys.*;
import Std.*;

class Grandma {
    static var pointReg = ~/^\((-?[\d]+\.[\d]+),\s?(-?[\d]+\.[\d]+)\)$/;
    
    static function main () {
        var file = File.read(args()[0]);
        
        var points = [];
        try {
            while (true) {
                if (pointReg.match(file.readLine())) {
                    points.push(new Point(
                     parseFloat(pointReg.matched(1)),
                     parseFloat(pointReg.matched(2))));
                }
            }
        } catch (e:Eof) { }
        
        if (points.length < 1) {
            println("No points given.");
            exit(1);
        }
        
        var shortest = { p1: null, p2: null, dist: POSITIVE_INFINITY };
        for (a in 0...(points.length - 1)) {
            for (b in (a + 1)...points.length) {
                var dist = points[a].distanceFrom(points[b]);
                if (dist < shortest.dist) {
                    shortest.p1 = points[a];
                    shortest.p2 = points[b];
                    shortest.dist = dist;
                }
            }
        }
        
        println('${shortest.p1} ${shortest.p2}');
    }
}

class Point {
    public var x (default, null): Float;
    public var y (default, null): Float;
    
    public function new (x, y) {
        this.x = x; this.y = y;
    }
    
    public function distanceFrom (that: Point) {
        return sqrt(pow(this.x - that.x, 2) + pow(this.y - that.y, 2));
    }
    
    public function toString () {
        return '(${this.x},${this.y})';
    }
}
