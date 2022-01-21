use IO;
import ys;

config var input: string;

if (input.isEmpty()) {
    writeln("You must specify an input file via --input");
    sys.exit(1);
}
var fp = open(input, iomode.r);
var channel = fp.reader();


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
    if (count > numbers - count) {
        gamma |= 1;
    }
}
writeln(gamma);
epsilon = ~gamma & ((1 << n) - 1);
writeln(epsilon);
writeln(gamma * epsilon);