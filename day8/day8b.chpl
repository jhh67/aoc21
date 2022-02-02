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


//var done: set(set(string));

var encodings: [0..9] set(string);

while (channel.readline(buffer)) {
    // convert the inputs into an array of sets of characters
    var tmp: string;
    (tmp, sep, outputs) = buffer.partition("|");
    var items = tmp.split();
    var inputs:[0..<items.size] set(string);
    var i = 0;
    for item in items {
        inputs[i] = new set(string, item);
        i += 1;
    }
    // 1, 4, 7, 8
    for input in inputs {
        var digit = -1;
        select input.size {
            when 2 { digit = 1; }
            when 3 { digit = 7; }            
            when 4 { digit = 4; }            
            when 7 { digit = 8; }            
        }
        if (digit != -1) {
            encodings[digit] = input;
            input.clear();
        }
    }
    // 3 has a '1' in it
    for (i, input) in zip(inputs.domain, inputs) {
        if input.size == 5 {
            if ((input & encodings[1]) == encodings[1]) {
                encodings[3] = input;
                input.clear();
            }
        }
    }
    // 6 is the only six-segment digit without '1' in it
    for input in inputs {
        if input.size == 6 {
            if (input & encodings[1]) != encodings[1] {
                encodings[6] = input;
                input.clear();
            }
        }
    }
    // 5 is 6 minus one segment otherwise it's a 2
    for input in inputs {
        if input.size == 5 {
            var i = input & encodings[6];
            if (i == input) {
                encodings[5] = input;
                input.clear();
            } else {
                encodings[2] = input;
                input.clear();
            }
        }
    }
    // 9 is 5 plus one segment otherwise it's a 0
    for input in inputs {
        if input.size == 6 {
            var i = input & encodings[5];
            if (i.size == 5) {
                encodings[9] = input;
                input.clear();
            } else {
                encodings[0] = input;
                input.clear();
            }
        }
    }
    var value = 0;
    for output in outputs.split() {
        var tmp = new set(string, output);
        for i in encodings.domain {
            if (encodings[i] == tmp) {
                value = value * 10 + i;
            }
        }
    }
    total += value;
}
writeln("Total: ", total);
