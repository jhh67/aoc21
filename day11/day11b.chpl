use IO;

config var limit:int = 10;

var octopuses: [0..<limit, 0..<limit] int;
var flashed: [0..<limit, 0..<limit] bool;

var row = 0;
var col = 0;
var flashes = 0;
var buffer: string;
while (stdin.read(buffer)) {
    col = 0;
    for n in buffer {
        octopuses[row, col] = n:int;
        col += 1;
    }
    row += 1;
}
writeln(octopuses);
writeln();

proc visit(row:int, col:int, incr:bool = false) {
    if (row < 0 || row >= limit || col < 0 || col >= limit) {
        return;
    }
    if (incr) {
        octopuses[row, col] += 1;
    }
    if (octopuses[row, col] > 9 && flashed[row, col] == false) {
        //writef("flash %i,%i\n", row, col);
        flashes += 1;
        flashed[row, col] = true;
        // flash, do our neighbors
        for r in [-1,0,1] {
            for c in [-1,0,1] {
                if (r != 0 || c != 0) {
                    visit(row + r, col + c, true);
                }
            }
        }
        //writef("flashed %i,%i\n", row, col);
        //writeln(octopuses);
        //writeln();
    }
}

var step = 1;
while (true) {
    writeln("Step ", step);
    octopuses += 1;
    flashed = false;
    for row in 0..<limit {
        for col in 0..<limit {
            if (octopuses[row, col] > 9 && flashed[row, col] == false) {
                visit(row, col, false);
            }
        }
    }
    for row in 0..<limit {
        for col in 0..<limit {
            if (octopuses[row, col] > 9) {
                octopuses[row, col] = 0;
            }
        }
    }
    writeln(octopuses);
    writeln();
    var tmp = + reduce octopuses;
    // if (octopuses == 0) { doesn't work
    if (tmp == 0) {
        writeln("Synchronized: ", step);
        break;
    }
    step += 1;
}
