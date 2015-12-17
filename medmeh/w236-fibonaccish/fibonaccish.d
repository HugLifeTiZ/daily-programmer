import std.stdio, std.conv, std.algorithm, std.string;

void main (string[] args) {
    auto target = args[1].to!int;
    for (auto i = 1; i < target; ++i) {
        auto seq = [0, i];
        while (seq[$ - 1] < target) {
            seq ~= seq[$ - 1] + seq[$ - 2];
        }
        if (seq[$ - 1] == target) {
            writeln("Target reached with f(1) = ", i, ".");
            writeln(seq.map!(to!string).join(" "));
            break;
        }
    }
}
