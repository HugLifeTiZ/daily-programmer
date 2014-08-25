require("sugar"); Object.extend();
process.argv
 .slice(2)
 .map(item => parseInt("0x1" + item)
  .toString(2)
  .chars()
  .slice(1)
  .reduce((prev, current) => prev + (current == 1 ? "█" : "░"), ""))
 .each(row => console.log(row));
