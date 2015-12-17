import std.stdio, std.algorithm, std.range, std.conv, std.random, std.string;

void main () {
    auto diff = getDiff();
    auto count = [5, 8, 10, 12, 15][diff], len = [4, 7, 9, 12, 15][diff];
    auto words = File("enable1.txt", "r").byLineCopy.map!chomp
     .filter!(a => a.length == len).array.randomSample(count).map!toUpper.array;
    words.each!writeln;
    auto target = words.randomSample(1).front;
    auto matches = 0, tries = 5;
    while (tries-- > 0 && len > (matches = getMatches(target)))
        writeln("You got %s/%s. %s tries remain.".format(matches, len, tries));
    writeln(len == matches ? "Access granted." : "ACCESS DENIED");
}

auto getMatches (string target) {
    write("Make a guess: ");
    auto guess = stdin.readln.chomp.toUpper, matches = 0;
    for (auto i = 0; i < min(target.length, guess.length); ++i)
        if (target[i] == guess[i]) ++matches;
    return matches;
}

auto getDiff () {
    auto diff = -1;
    while (diff < 0 || diff > 4) {
        write("Select difficulty, 1-5: ");
        diff = stdin.readln.chomp.to!int - 1;
    }
    return diff;
}
