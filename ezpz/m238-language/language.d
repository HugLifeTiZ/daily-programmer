import std.stdio, std.algorithm, std.string, std.random, std.range;

void main (string[] args) {
    writeln(args[1..$].join(" ").map!getChar);
}

dchar getChar (dchar chr) {
    auto vowels = "aeiou", consonants = "bcdfghjklmnpqrstvwxyz";
    switch (chr) {
    case 'v': return vowels[uniform(1, $)]; break;
    case 'V': return vowels[uniform(1, $)].toUpper; break;
    case 'c': return consonants[uniform(1, $)]; break;
    case 'C': return consonants[uniform(1, $)].toUpper; break;
    case ' ': return ' '; break;
    default:
        throw new Exception(
         "%s doesn't match consonant/vowel pattern.".format(chr));
        return ' '; break;
    }
}
