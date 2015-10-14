class Fibonaccish {
    static function main () {
        var target = Std.parseInt(Sys.args()[0]);
        for (i in 1 ... target) {
            var seq = [0, i];
            while (seq[seq.length - 1] < target)
                seq.push(seq[seq.length - 1] + seq[seq.length - 2]);
            if (seq[seq.length - 1] == target) {
                Sys.println('Target reached with f(1) = $i.');
                Sys.println(seq.join(" "));
                break;
            }
        }
    }
}
