use IO;

config var days: int = 0;
config var input: string;

if (input.isEmpty()) {
    writeln("You must specify an input file via --input");
    exit(1);
}
var fp = open(input, iomode.r);
var channel = fp.reader();

var cohorts: [0..8] int;
var fishes: string;

channel.readline(fishes);

for fish in fishes.split(","): int {
    cohorts[fish] += 1;
}

proc offset(base, offset) {
    return (base + offset) % 9;
}

var base = 0;

for day in 1..days {
    cohorts[offset(base, 7)] += cohorts[base];
    base = offset(base, 1);
/*
    writeln("Day: ", day);
    for x in 0..8 {
        var y = offset(base, x);
        writef("%2i ", cohorts[y]);
    }
    writef("\n");
*/
}

writeln("Total: ", + reduce cohorts);