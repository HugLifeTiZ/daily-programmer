import std.stdio, std.algorithm, std.array, std.regex;

struct Box {
    ulong x1, y1, x2, y2, layer;
    bool contains (ulong x, ulong y) {
        return x1 <= x && x <= x2 && y1 <= y && y <= y2;
    }
}

void main (string[] args) {
    auto reg = ctRegex!(`^[\|\+\- ]+$`);
    auto files = args[1..$].map!(a => File(a, "r")).array;
    if (!files.length) files = [stdin];
    foreach (File f; files) {
        auto grid = f.byLineCopy.filter!(a => a.matchFirst(reg)).map!dup.array;
        grid.paintBox(Box(0, 0, grid[0].length, grid.length, 0));
        grid.each!writeln;
    }
}

void paintBox (char[][] grid, Box box) {
    Box[] boxes = [];
    for (auto y = box.y1; y < box.y2; ++y) {
        for (auto x = box.x1; x < box.x2; ++x) {
            if (!boxes.any!(a => a.contains(x, y))) {
                switch (grid[y][x]) {
                case '+':
                    auto tx = x + 1, ty = y + 1;
                    while (grid[y][tx] != '+') ++tx;
                    while (grid[ty][x] != '+') ++ty;
                    boxes ~= Box(x, y, tx, ty, box.layer + 1);
                    break;
                case ' ':
                    grid[y][x] = box.layer < 5 ? " #=-.".dup[box.layer] : ' ';
                    break;
                default: break;
    }   }   }   }
    boxes.each!(a => grid.paintBox(Box(++a.x1, ++a.y1, a.x2, a.y2, a.layer)));
}
