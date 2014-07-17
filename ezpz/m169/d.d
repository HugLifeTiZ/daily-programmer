string[][] rotate (string[][] grid) {
}

void main (string args[]) {
    auto grid = args[1].File.byLine.filter(r => r != "").map(r => split(s));
    for (deg in [0, 90, 180, 270]) {
        writeln(deg ~ "° rotation:");
        writeln(grid.map(r => join(r, " ")).map(r => join(r, "\n")));
        grid = rotate(grid);
    }
}
