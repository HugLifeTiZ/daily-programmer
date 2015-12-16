import std.stdio, std.regex, std.conv, std.math;

struct Point {
    public double x;
    public double y;
    public string toString () {
        return "(" ~ x.to!string ~ ", " ~ y.to!string ~ ")";
    }
    public double distanceFrom (Point that) {
        return sqrt((x - that.x) ^^ 2 + (y - that.y) ^^ 2);
    }
}

void main () {
    auto pointReg = ctRegex!(`\((-?[\d]+\.[\d]+),\s*(-?[\d]+\.[\d]+)\)`);
    Point[] points;
    foreach (line; stdin.byLine) {
        auto match = line.matchFirst(pointReg);
        if (!match.empty) {
            points ~= Point(match[1].to!double, match[2].to!double);
        }
    }
    
    Point shortest1 = Point(0,0), shortest2 = Point(0,0);
    auto shortest_dist = double.infinity;
    for (auto a = 0; a < points.length - 1; ++a) {
        for (auto b = (a + 1); b < points.length - 2; ++b) {
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
