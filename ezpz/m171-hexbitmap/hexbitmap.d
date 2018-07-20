import std.stdio, std.algorithm, std.conv;

void main (string[] args) {
    args[1..$].map!(
        a => ('1' ~ a)
         .to!int(16)
         .to!string(2)
         .map!`a == '1' ? '█' : '░'`
     ).each!writeln;
}
