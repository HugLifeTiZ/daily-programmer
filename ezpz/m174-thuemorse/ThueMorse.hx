class ThueMorse {
    static function main () {
        var iters = Std.parseInt(Sys.args()[0]);
        var silent = Sys.args()[1] == "silent";
        Sys.println('Calculating sequence to iteration $iters.');
        var seq = [0], currentLength = 1;
        for (reps in 0...iters) {
            for (idx in 0...currentLength) {
                seq.push(seq[idx] == 1 ? 0 : 1);
            }
            currentLength *= 2;
        }
        Sys.println(silent ? "Done." : seq.join(""));
    }
}
