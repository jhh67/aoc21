use IO;
use Map;
use Set;

config var input: string;

if (input.isEmpty()) {
    writeln("You must specify an input file via --input");
    exit(1);
}
var fp = open(input, iomode.r);
var channel = fp.reader();

var inputs: string;
var outputs: string;
var buffer: string;
var sep: string;
var output: string;
var total = 0;

var grid: [0..101, 0..101] int;
grid = 9;

var rows:int;
var cols:int;

var row = 1;
while (channel.read(buffer)) {
    for (col, value) in zip(1..buffer.size, buffer.items()) {
        grid[row,col] = value:int;
    }
    row += 1;
    cols = buffer.size;
}
rows = row-1;

for row in 1..rows {
    for col in 1..cols {
        var value = grid[row, col];
        if ((value < grid[row, col-1]) && (value < grid[row, col+1]) &&
           (value < grid[row-1, col]) && (value < grid[row+1, col])) {
            total += value + 1;
        }
    }
}
writeln("Risk: ", total);
