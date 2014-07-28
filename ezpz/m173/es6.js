require("sugar");

const distRatios = [
    [1.0, 39.3701, 6.21371e-4, 32.4077929],
    [0.0254, 1.0, 1.57828e-5, 0.82315794],
    [1609.34, 63360, 1.0, 52155.287],
    [0.0308567758, 1.21483369, 1.91735116e-5, 1.0]
], massRatios = [
    [1.0, 2.20462, 35.274, 2.26912e-3],
    [0.453592, 1.0, 16, 1.02923e-3],
    [0.0283495, 0.0625, 1.0, 6.4328324e-5],
    [440.7, 971.6, 15545.2518, 1.0]
], distMaps = {
    "meters": 0, "metres": 0, "m": 0, "inches": 1, "in": 1,
    "miles": 2, "mi": 2, "attoparsecs": 3, "ap": 3
}, massMaps = {
    "kilograms": 0, "kilos": 0, "kg": 0, "pounds": 1, "lb": 1,
    "ounces": 2, "oz": 2, "hogsheads": 3, "hhd": 3
};

const [amount, fromUnit, toUnit] = process.argv.slice(2).exclude("to");
var converted;
if (fromUnit in distMaps && toUnit in distMaps) {
    converted = amount * distRatios[distMaps[fromUnit]][distMaps[toUnit]];
} else if (fromUnit in massMaps && toUnit in massMaps) {
    converted = amount * massRatios[massMaps[fromUnit]][massMaps[toUnit]];
} else {
    console.log("Can't convert %s to %s.", fromUnit, toUnit);
    process.exit(1);
}
console.log("%s %s = %s %s", amount, fromUnit, converted, toUnit);
