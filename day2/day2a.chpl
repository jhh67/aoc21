use IO;

var input = open("day2.input", iomode.r);
var channel = input.reader();

var depth: int = 0;
var position: int = 0;

var command: string;
var distance: int;

while(channel.read(command, distance)) {
    if (command == "forward") {
        position += distance;
    } else if (command == "down") {
        depth += distance;
    } else if (command == "up") {
        depth -= distance;
        if (depth < 0) {
            writeln("broaching");
        }
    }
}

writeln(position * depth);
