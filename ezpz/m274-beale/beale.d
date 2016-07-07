import std.stdio, std.algorithm, std.file, std.string, std.array, std.conv;

// I'd like to be able to define letters as static, but ldc2 can't do it.
void main (string[] args) {
    assert(exists("doi.txt"));
    const string letters = readText("doi.txt")
     .split  // Split each word by whitespace.
     .map!(a => a[0])  // Discard the rest of each word.
     .array;  // Force evaluation of the range.
    const wrap = letters.length;
    stdin.byLineCopy.join(" ")  // Join each line into a single string.
     .filter!(a => a.inPattern("0-9 "))  // Filter out commas.
     .array.split  // Force evaluation and split it by whitespace.
     .map!(a => letters[a.to!int - 1 % wrap]) // Look up letter and wrap around.
     .writeln;  // Write to stdout.
}
