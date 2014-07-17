#!/usr/bin/env node

function parse (image) {
    image = image.split(" ");
    return image.map(function (row) { 
        return parseInt("0x1" + row).toString(2).split("").slice(1)
         .map(function (col) { return col === "1"; });
    });
}

function print (image) {
    console.log(image.map(function (row) {
        return row.reduce(function (prev, current) {
            return prev + (current ? "█" : "░")
        }, "");
    }).join("\n"));
}

function invert (image) {
    return image.map(function (row) {
        return row.map(function (col) {
           return !col;
        });
    });
}

function rotateRight (image) {
    var retval = image[0].map(function () { return Array(image.length); });
    for (y in image) {
        for (x in image[y]) {
            retval[x][retval[x].length - y - 1] = image[y][x];
        }
    }
    return retval;
}

function rotateLeft (image) {
    var retval = Array(image[0].length);
    for (i in image[0])  { retval[i] = Array(image.length); }
    for (y in image) {
        for (x in image[y]) {
            retval[retval.length - x - 1][y] = image[y][x];
        }
    }
    return retval;
}

function zoomIn (image) {
    return image.reduce(function (prevRow, row) {
        row = row.reduce(function (prevCol, col) {
            prevCol.push(col, col);
            return prevCol;
        }, []);
        prevRow.push(row, row);
        return prevRow;
    }, []);
}

function zoomOut (image) {
    return image.reduce(function (prevRow, row, rowIdx) {
        if (rowIdx % 2) {
            prevRow.push(row.reduce(function (prevCol, col, colIdx) {
                if (colIdx % 2) {
                    prevCol.push(col);
                }
                return prevCol;
            }, []));
        }
        return prevRow;
    }, []);
}

const opsMap = {
    "invert" : invert, "inv" : invert,
    "rotateright" : rotateRight, "rotater" : rotateRight,
    "rotatecw" : rotateRight, "rotcw" : rotateRight,
    "rotateleft" : rotateLeft, "rotatel" : rotateLeft,
    "rotateccw" : rotateLeft, "rotccw" : rotateLeft,
    "zoomin" : zoomIn, "zoomout" : zoomOut
}

var image = parse(process.argv[2]);
var ops = process.argv.slice(3).map(function (o) { return o.toLowerCase(); });
console.log("original:");
print(image);
for (i in ops) {
    if (opsMap[ops[i]]) {
        console.log(ops[i] + ":");
        image = opsMap[ops[i]](image);
        print(image);
    } else {
        console.log("unknown operation " + ops[i] + "; skipping.");
    }
}
