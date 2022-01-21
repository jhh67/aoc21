use IO;
use List;

config var input: string;

if (input.isEmpty()) {
    writeln("You must specify an input file via --input");
    exit(1);
}
var fp = open(input, iomode.r);
var channel = fp.reader();


class Board {
    var id: int;
    var grid: [0..4, 0..4] int;
    var rows: [0..4] int;
    var cols: [0..4] int;
}

var numbers: string;

channel.readline(numbers);

var row: int = 0;
var col: int = 0;

var buffer: string;
var board: shared Board?;
var boards: list(shared Board?);

// read the boards

var id: int = 0;
while (channel.readline(buffer)) {
    if (buffer == "\n") {
        board = new Board();
        board!.id = id;
        id += 1;
        continue;
    }
    var col: int = 0;
    var value: int;
    for value in buffer.split():int {
        board!.grid[row, col] = value;
        col += 1;
    }
    for i in 0..4 {
        board!.rows[i] = 5;
        board!.cols[i] = 5;
    }
    if (row == 4) {
        boards.append(board);
    }
    row = (row + 1) % 5;
}

// play the game
for number in numbers.split(","):int {
    var winners: list(shared Board?);
    for board in boards {
        for row in 0..4 {
            for col in 0..4 {
                if (board!.grid[row, col] == number) {
                    if (number == 0) {
                        board!.grid[row, col] = -99;
                    } else {
                        board!.grid[row, col] = -number;
                    }
                    board!.rows[row] -= 1;
                    board!.cols[col] -= 1;
                    if ((board!.rows[row] == 0) || (board!.cols[col] == 0)) {
                        writeln("Bingo! Board ", board!.id);
                        winners.append(board);
                    }
                }
            }
        }
    }
    if (winners.size > 0) {
        for winner in winners {
            var n = boards.remove(winner);
            writef("removed %i boards\n", n);
        }
        if (boards.size == 0) {
            var winner = winners[0];
            var tmp = [x in winner!.grid] if x > 0 then x else 0;
            var sum = + reduce tmp;
            writeln("sum ", sum);
            writeln(sum * number);
            exit(0);
        }
    }
}