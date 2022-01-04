use IO;

var input = open("day1.input", iomode.r);

var channel = input.reader();

var depth: int;

var last: int = -1;

var increases: int = 0;

while(channel.read(depth)) {
    if ((last != -1) && (depth > last)) {
        increases += 1;
    }
    last = depth;
}

writeln(increases);