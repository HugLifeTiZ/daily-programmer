import std.stdio, std.regex, std.conv, std.math,
 std.algorithm, std.array, std.range, std.format;

struct Point {
    double x, y;
    string toString () { return "(%.14f, %.14f)".format(x, y); }
    auto distanceFrom (Point that) {
        return sqrt((x - that.x) ^^ 2 + (y - that.y) ^^ 2);
    }
}

void main (string[] args) {
    auto reg = ctRegex!(`\((-?[\d]+\.[\d]+),\s*(-?[\d]+\.[\d]+)\)`);
    auto files = args[1..$].map!(a => File(a, "r")).array;
    if (!files.length) files = [stdin];
    auto points = files.map!"a.byLineCopy".join.map!(a => a.matchFirst(reg))
     .filter!(a => !a.empty).map!(a => Point(a[1].to!double, a[2].to!double))
     .array;
    
    auto shortest1 = Point(0,0), shortest2 = Point(0,0);
    auto shortest_dist = double.infinity;
    for (auto a = 0; a < points.length - 2; ++a) {
        for (auto b = (a + 1); b < points.length - 1; ++b) {
            auto dist = points[a].distanceFrom(points[b]);
            if (dist < shortest_dist) {
                shortest1 = points[a];
                shortest2 = points[b];
                shortest_dist = dist;
            }
        }
    }
    
    writeln(shortest1, " ", shortest2);
}
