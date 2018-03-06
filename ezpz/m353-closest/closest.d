import std.stdio, std.algorithm, std.array, std.math;

// Hamming distance.
uint distance (string a, string b) {
    uint retval = 0;
    for (uint i = 0; i < min(a.length, b.length); i++)
        if (a[i] != b[i]) retval++;
    return retval;
}

void main (string[] args) {
    File[] files = args[1..$].map!(a => File(a, "r")).array;
    if (!files.length) files = [stdin];
    foreach (File file; files) {
        string center; uint shortest = uint.max;
        uint distances;
        // We don't need the number at the start.
        string[] lines = file.byLineCopy.array[1..$];
        if (lines.length == 0) continue;
        foreach (string line; lines) {
            distances = lines.map!(a => line.distance(a)).sum;
            if (distances < shortest) {
                center = line;
                shortest = distances;
            }
        }
        writeln(center);
    }
}
