use IO;

var input = open("day2.input", iomode.r);
var channel = input.reader();

var depth: int = 0;
var position: int = 0;

var command: string;
var distance: int;

while(channel.read(command, distance)) {
    select command {
        when "forward" {
            position += distance;
        }
        when "down" {
            depth += distance;
        }
        when "up" {
            depth -= distance;
            if (depth < 0) {
                writeln("broaching");
            }
        }
    }
}

writeln(position * depth);
