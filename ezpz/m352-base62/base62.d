import std.stdio, std.range, std.conv;

static string base62 =
 "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

void main (string[] args) {
    ulong num;
    // $0 is part of args in D.
    foreach (string arg; args.dropOne) {
        try {
            num = arg.to!ulong(10);
        } catch (ConvException) {
            writefln("%s is not a positive integer.", arg);
            continue;
        }
        do {
            write(base62[num % 62]);
        } while (num /= 62);
        writeln();
    }
}
