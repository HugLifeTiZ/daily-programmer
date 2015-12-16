import std.stdio, std.algorithm, std.array, std.regex;

struct Box { ulong x1, y1, x2, y2, layer; }

auto layers = [' ', '#', '=', '-', '.'];
char[][] grid;

void main (string[] args) {
    grid = stdin.byLine.map!"a.idup"
     .filter!(a => a.matchFirst(ctRegex!(`^[\|\+\- ]+$`))).map!"a.dup".array;
    paintBox(0, 0, grid[0].length, grid.length, 0);
    foreach (char[] line; grid) writeln(line);
}

void paintBox (ulong x1, ulong y1, ulong x2, ulong y2, ulong layer) {
    Box[] boxes = [];
    for (auto y = y1; y < y2; ++y) {
        for (auto x = x1; x < x2; ++x) {
            if (!boxes.any!(a => a.inBox(x, y))) {
                final switch (grid[y][x]) {
                case '+':
                    auto tx = x + 1, ty = y + 1;
                    while (grid[y][tx] != '+') ++tx;
                    while (grid[ty][x] != '+') ++ty;
                    boxes ~= Box(x, y, tx, ty, layer + 1);
                    break;
                case ' ':
                    grid[y][x] = layer < 5 ? layers[layer] : ' ';
                    break;
    }   }   }   }
    foreach (Box box; boxes)
        paintBox(box.x1 + 1, box.y1 + 1, box.x2, box.y2, box.layer);
}

pure bool inBox (Box box, ulong x, ulong y) {
    return box.x1 <= x && x <= box.x2 && box.y1 <= y && y <= box.y2;
}
