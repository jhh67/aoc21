use IO;

config var days: int = 0;
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

var count: int;

var targets = [0,0,1,1,1,0,0,1];

while (channel.readline(buffer)) {
    (inputs, sep, outputs) = buffer.partition("|");
    for output in outputs.split() {
        if targets[output.size] {
            writeln(output);
            count += 1;
        }
    }
}
writeln(count);
