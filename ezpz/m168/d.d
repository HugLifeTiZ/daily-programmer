import std.file, std.stdio, std.conv, std.random, std.string;

auto load_names (string filename) {
    string[] retval;
    foreach (line; File(filename).byLine()) {
        retval[] = line.idup;
    }
    return retval;
}

auto generate_name (string[][] names) {
    return format("%s, %s",
     names[uniform(0, names[0].length)][0],
     names[uniform(0, names[1].length)][1]);
}

auto generate_grade () {
    return 50 + uniform(0, 50);
}

auto generate_result () {
    return format("%d %d %d %d %d", generate_grade(), generate_grade(),
     generate_grade(), generate_grade(), generate_grade());
}

auto generate_result_set (string[][] names, int count) {
    string[string] retval;
    for (int i = 0; i < count; i++) {
        auto name = generate_name(names);
        while (name in retval) {
            name = generate_name(names);
        }
        retval[name] = generate_result();
    }
    return retval;
}

void print_result_set (string[string] results) {
    foreach (string key, string value; results) {
        writefln("%s %s", key, value);
    }
}

void main (string[] args) {
    string[][2]     names;
    string[string]  results;
    int             count;
    
    names[0] = load_names("last.txt");
    names[1] = load_names("first.txt");
    assert(names[0].length > 0 && names[1].length > 0);
    
    try {
        count = to!int(args[1]);
    } catch {
        count = 10;
    }
    
    results = generate_result_set(names, count);
    print_result_set(results);
}
