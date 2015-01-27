require("sugar");
console.log(process.argv[2].remove(/-/g).chars()
 .map(char => char.toUpperCase() == "X" ? 10 : Number(char))
 .reduce((res, cur, idx) =>  res + cur * (10 - idx)) % 11 == 0 ?
 "Valid ISBN" : "Invalid ISBN");
