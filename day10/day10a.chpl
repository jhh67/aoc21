use IO;

var stack: [0..100] string;
var top = -1;

var openings : domain(string) = ["(", "[", "{", "<"]; 
var closings : [openings] string;
for (o,c) in zip("({[<", ")}]>") {
    closings[o] = c;
}

var values = [")" => 3, "]" => 57, "}" => 1197, ">" => 25137];

var total = 0;
var buffer: string;
while (stdin.read(buffer)) {
    top = -1;
    for c in buffer {
        if (openings.contains(c)) {
            top +=1;
            stack[top] = c;
        } else if (c == closings[stack[top]]) {
            top -= 1;
        } else {
            top = -1;
            total += values[c];
            break;
        }
    }
    if (top != -1) {
        continue;
    }
}

writeln("Total: ", total);

