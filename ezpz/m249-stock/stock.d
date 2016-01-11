import std.stdio, std.algorithm, std.conv;

void main (string[] args) {
    auto nums = args[1..$].map!(to!float);
    auto lowest = 0.0f, highest = 0.0f, diff = 0.0f;
    for (auto a = 0; a < nums.length - 3; a++) {
        for (auto b = a + 2; b < nums.length - 1; b++) {
            if (nums[b] - nums[a] > diff) {
                lowest = nums[a];
                highest = nums[b];
                diff = highest - lowest;
            }
        }
    }
    writeln(lowest, " ", highest);
}
