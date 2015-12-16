import std.stdio, std.algorithm, std.array, std.regex;

struct Box {
    ulong x1, y1, x2, y2, layer;
    bool contains (ulong x, ulong y) {
        return x1 <= x && x <= x2 && y1 <= y && y <= y2;
    }
}

void main (string[] args) {
    auto grid = stdin.byLine.map!"a.idup"
     .filter!(a => a.matchFirst(ctRegex!(`^[\|\+\- ]+$`))).map!"a.dup".array;
    grid.paintBox(Box(0, 0, grid[0].length, grid.length, 0));
    foreach (char[] line; grid) writeln(line);
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
    foreach (Box b; boxes)
        grid.paintBox(Box(b.x1 + 1, b.y1 + 1, b.x2, b.y2, b.layer));
}
