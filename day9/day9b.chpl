use IO;
use List;
use Heap;

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

// make a grid with boundary columns and rows
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

var lows: list((int, int));

for row in 1..rows {
    for col in 1..cols {
        var value = grid[row, col];
        if ((value < grid[row, col-1]) && (value < grid[row, col+1]) &&
           (value < grid[row-1, col]) && (value < grid[row+1, col])) {
            lows.append((row, col));
        }
    }
}

proc explore(row:int, col:int):int {
    var size = 0;
    var value = grid[row, col];
    grid[row, col] = 9;
    if (value != 9) {
        size = 1;
        // explore our neighbors
        size += explore(row, col-1);
        size += explore(row, col+1);
        size += explore(row-1, col);
        size += explore(row+1, col);
    }
    return size;
}

var largest = new heap(int, comparator=reverseComparator); // the three largest basins
largest.push(1);
largest.push(1);
largest.push(1);
for low in lows {
    writeln(low(0), ",", low(1));
    var size = explore(low(0), low(1));
    if (size > largest.top()) {
        largest.pop();
        largest.push(size);
    }
}
writeln("Total: ", * reduce largest);
