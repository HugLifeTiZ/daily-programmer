class Threes {
    static function main () {
        var num = Std.parseInt(Sys.args()[0]);
        while (num != 1)
            num = switch (num % 3) {
            case 1:  Sys.println('$num -1'); Std.int((num - 1) / 3);
            case 2:  Sys.println('$num +1'); Std.int((num + 1) / 3);
            default: Sys.println('$num 0'); Std.int(num / 3);
            }
        Sys.println("1");
    }
}
