#!/usr/bin/env python3
from math import sqrt, pow
import re, fileinput

class Point:
    def __init__ (self, x, y):
        self.x = float(x)
        self.y = float(y)
    
    def __str__ (self):
        return "({}, {})".format(self.x, self.y)
    
    def distance_from (self, that):
        return sqrt(pow(self.x - that.x, 2) + pow(self.y - that.y, 2))

pointReg = re.compile(r"\((-?[\d]+\.[\d]+),\s*(-?[\d]+\.[\d]+)\)")
points = []
for line in fileinput.input():
    match = pointReg.match(line)
    if match: points.append(Point(*match.group(1, 2)))

if len(points) < 1:
    print("No points given.")
    exit()

shortest = (None, None, float("inf"))
for a in range(0, len(points) - 1):
    for b in range(a + 1, len(points)):
        dist = points[a].distance_from(points[b])
        if dist < shortest[2]: shortest = (points[a], points[b], dist)

print("{} {}".format(shortest[0], shortest[1]))
