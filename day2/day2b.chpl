use IO;

var input = open("day2.input", iomode.r);
var channel = input.reader();

var depth: int = 0;
var position: int = 0;
var aim: int = 0;

var command: string;
var distance: int;

while(channel.read(command, distance)) {
    if (command == "forward") {
        position += distance;
        depth += aim * distance;
    } else if (command == "down") {
        aim += distance;
    } else if (command == "up") {
        aim -= distance;
        if (aim < 0) {
            writeln("broaching");
        }
    }
}

writeln(position * depth);
