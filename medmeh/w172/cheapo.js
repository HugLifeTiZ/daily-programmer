if (process.argv.length < 4) {
    console.log("Need input filename followed by output filename.");
    process.exit(1);
} else {  // lol graphicsmagick
    require("gm")(process.argv[2]).scale(400, null, "%").blur(1, 1)
     .write(process.argv[3], err => err ? console.log(err.toString()) : null);
}
