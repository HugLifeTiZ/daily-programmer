using Thx;
class Language {
    static var vowels = "aeiou".toArray();
    static var consonants = "bcdfghjklmnpqrstvwxyz".toArray();
    static function main () {
        Sys.println(Sys.args().map.fn(w => w.toArray().map.fn(c => switch (c) {
            case "v": vowels.sampleOne();
            case "V": vowels.sampleOne().toUpperCase();
            case "c": consonants.sampleOne();
            case "C": consonants.sampleOne().toUpperCase();
            default:
                Sys.println('$w doesn\'t match consonant/vowel pattern.');
                Sys.exit(1); "";
        }).join("")).join(" "));
    }
}
