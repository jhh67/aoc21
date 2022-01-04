use IO;

var input = open("day1.input", iomode.r);

var channel = input.reader();

var depths: [0..2] int;

var i: int = 0;

var sum: int;

var count: int = 0;

var last: int = -1;

var increases: int = 0;

while(channel.read(depths[i])) {
    count += 1;
    if (count >= 3) {
        sum = + reduce depths;
        if ((last != -1) && (sum > last)) {
            increases += 1;
        }
        last = sum;
    }
    i = (i + 1) % 3;
}

writeln(increases);