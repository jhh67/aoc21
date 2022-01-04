use IO;

var input = open("day3.input", iomode.r);
var channel = input.reader();


var counts: [0..15] int; // assume no more than 16-bit numbers, counts # bits set

var n: int = 0; // number of bits in the numbers

var numbers: int = 0;

var bits: string;

while(channel.read(bits)) {
    var i: int = 0;
    numbers += 1;
    for b in bits {
        if (b == "1") {
            counts[i] += 1;
        }
        i += 1;
    }
    n = i;
}

var gamma: uint = 0;
var epsilon: uint = 0;

for count in counts[0..n-1] {
    gamma <<= 1;
    epsilon <<= 1;
    if (count > numbers - count) {
        gamma |= 1;
    } else {
        epsilon |= 1;
    }
}
writeln(gamma * epsilon);