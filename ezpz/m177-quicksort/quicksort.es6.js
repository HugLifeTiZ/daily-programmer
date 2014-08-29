require("sugar");
function quickSort (list) {
    if (list.length <= 1) {
        return list;
    } else if (list.length == 2) {
        return list[1] >= list[0] ? list : [list[1], list[0]];
    }
    const pivot = list.sample();
    var smaller = [], bigger = [];
    list.each(item => (item < pivot ? smaller : bigger).add(item));
    return quickSort(smaller).add(quickSort(bigger)).flatten();
}
console.log(quickSort(process.argv.slice(2).map(i => Number(i))).join(" "));
