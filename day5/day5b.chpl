use IO;
use List;

config var input: string;

if (input.isEmpty()) {
    writeln("You must specify an input file via --input");
    exit(1);
}
var fp = open(input, iomode.r);
var channel = fp.reader();

var grid: [0..999, 0..999] int;

var buffer: string;

const START = 0;
const END = 1;

proc Normalize(ref point0: [0..1] int, ref point1: [0..1] int) {
    if (point0[START] > point0[END]) {
        point0[START] <=> point0[END];
        point1[START] <=> point1[END];
    }
}

var x: [0..<2] int;
var y: [0..<2] int;

while (channel.readf("%i,%i -> %i,%i", x[START], y[START], x[END], y[END])) {


    if (x[START] == x[END]) {
        Normalize(y, x);
        for y1 in y[START]..y[END] {
            grid[x[START], y1] += 1;
        }
    } else if (y[START] == y[END]) {
        Normalize(x, y);
        for x1 in x[START]..x[END]  {
            grid[x1, y[START]] += 1;
        }
    } else {
        Normalize(x,y);
        var slope = if y[START] < y[END] then 1 else -1;
        var y1 = y[START];
        for x1 in x[START]..x[END]  {
            grid(x1, y1) += 1;
            y1 += slope;
        }
    }
}

/*
for y in 0..9 {
    for x in 0..9 {
        writef("%2i", grid[x,y]);
    }
    writeln();
}
*/

var overlaps: int;
for v in grid {
    if (v > 1) {
        overlaps += 1;
    }
}
writeln("Overlaps: ", overlaps);
