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
        this[data] = left ? this[data].map(row => row.reverse()) :
         this[data].reverse();
        this[data] = this[data][0].map((_, col) => this[data].map(
         row => row[col]));
    }
    rotateRight ()  { this.rotate(); }
    rotateLeft ()  { this.rotate(true); }
    
    zoomIn () {
        this[data] = this[data].map(row => [row.map(col => [col, col])
         .flatten(1), row.map(col => [col, col]).flatten(1)]).flatten(1);
    }
    
    zoomOut () {
        this[data] = this[data].map((row, rIdx) => rIdx % 2 ? row.map(
         (col, cIdx) => cIdx % 2 ? col : null).compact() : null).compact();
    }
    
    getOp (op) {
        const ops = {
            "invert" : this.invert, "inv" : this.invert,
            "rotateright" : this.rotateRight, "rotater" : this.rotateRight,
            "rotatecw" : this.rotateRight, "rotcw" : this.rotateRight,
            "rotateleft" : this.rotateLeft, "rotatel" : this.rotateLeft,
            "rotateccw" : this.rotateLeft, "rotccw" : this.rotateLeft,
            "rotr" : this.rotateRight, "rotl" : this.rotateLeft,
            "zoomin" : this.zoomIn, "zoomout" : this.zoomOut,
            "zoom" : this.zoomIn, "unzoom" : this.zoomOut
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
