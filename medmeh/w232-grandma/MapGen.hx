class MapGen {
    static function main () {
        Sys.println(Sys.args()[0]);
        for (i in 0 ... Std.parseInt(Sys.args()[0]))
            Sys.println('(${Math.random() * 10}, ${Math.random() * 10})');
    }
}
