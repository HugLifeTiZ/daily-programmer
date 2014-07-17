require("traceur");
require("sugar");

const data = Symbol();
class Image {
    constructor (input) {
        input = input.words();
        this[data] = input.map(row => parseInt("0x1" + row).toString(2)
         .chars().slice(1).map(col => col === "1"));
    }
    
    toString () {
        return this[data].map(row => row.reduce(
            (prev, current) => prev + (current ? "█" : "░"), ""
        )).join("\n");
    }
    print ()  { console.log(this.toString()); }
    
    invert ()  { this[data] = this[data].map(row => row.map(col => !col)); }
    
    rotate (left) {
        this[data] = left ?
         this[data].map(r => r.reverse()) :
         this[data].reverse();
        this[data] = this[data][0].map((_, c) => this[data].map(r => r[c]));
    }
    rotateRight ()  { this.rotate(); }
    rotateLeft ()  { this.rotate(true); }
    
    zoomIn () {
        this[data] = this[data].reduce((prevRow, row) => {
            row = row.reduce((prevCol, col) => {
                prevCol.push(col, col);
                return prevCol;
            }, []);
            prevRow.push(row, row);
            return prevRow;
        }, []);
    }
    
    zoomOut () {
        this[data] = this[data].reduce((prevRow, row, rowIdx) => {
            if (rowIdx % 2) {
                prevRow.push(row.reduce((prevCol, col, colIdx) => {
                    if (colIdx % 2) {
                        prevCol.push(col);
                    }
                    return prevCol;
                }, []));
            }
            return prevRow;
        }, []);
    }
    
    getOp (op) {
        const ops = {
            "invert" : this.invert, "inv" : this.invert,
            "rotateright" : this.rotateRight, "rotater" : this.rotateRight,
            "rotatecw" : this.rotateRight, "rotcw" : this.rotateRight,
            "rotateleft" : this.rotateLeft, "rotatel" : this.rotateLeft,
            "rotateccw" : this.rotateLeft, "rotccw" : this.rotateLeft,
            "zoomin" : this.zoomIn, "zoomout" : this.zoomOut
        }
        return ops[op];
    }
}

var image = new Image(process.argv[2]);
var ops = process.argv.slice(3).map(o => o.toLowerCase());
console.log("original:")
image.print();
for (op of ops) {
    let opFunc = image.getOp(op);
    if (opFunc) {
        console.log(op + ":");
        opFunc.apply(image);
        image.print();
    } else {
        console.log("unknown operation " + op + "; skipping.");
    }
}
