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

while (channel.readline(buffer)) {
    var startBuf: string;
    var sep: string;
    var endBuf: string;
    var xstr: string;
    var ystr: string;
    var x: [0..<2] int;
    var y: [0..<2] int;

    (startBuf, sep, endBuf) = buffer.partition("->");

    (xstr, sep, ystr) = startBuf.partition(",");
    x[START] = xstr:int;
    y[START] = ystr:int; 

    (xstr, sep, ystr) = endBuf.partition(",");
    x[END] = xstr:int;
    y[END] = ystr:int; 

    //writeln("start: ", x[START], ",", y[START]);
    //writeln("end: ", x[END], ",", y[END]);

    if (x[START] == x[END]) {
        if (y[END] < y[START]) {
            y[START] <=> y[END];
        }
        for y in y[START]..y[END] {
            //writef("filling %i,%i\n", x[START], y);
            grid[x[START], y] += 1;
        }
    } else if (y[START] == y[END]) {
        if (x[END] < x[START]) {
            x[START] <=> x[END];
        }
        for x in x[START]..x[END]  {
            //writef("filling %i,%i\n", x, y[START]);
            grid[x, y[START]] += 1;
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
