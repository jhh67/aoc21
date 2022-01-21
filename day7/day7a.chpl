use IO;

config var days: int = 0;
config var input: string;

if (input.isEmpty()) {
    writeln("You must specify an input file via --input");
    exit(1);
}
var fp = open(input, iomode.r);
var channel = fp.reader();

var positions: string;
channel.readline(positions);

var costs: [0..<2000] int;

for p in positions.split(","): int {
    for d in costs.domain {
        costs[d] += abs(p - d);
    }
}

var m = min reduce costs;
writeln(m);