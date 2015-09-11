class Dottie {
    static function main () {
        var argv = Sys.args();
        fixedPoint(Std.parseFloat(argv[0]), Math.cos);
    }
    
    static function fixedPoint (x:Float, op:Float->Float):Void {
        var iters = 0;
        while (true) {
            iters++;
            var y = op(x);
            if (x == y || iters == 999) break; else x = y;
        }
        Sys.println('Reached fixed point $x in $iters iters.');
    }
}
