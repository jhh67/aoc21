use IO;
use Sort;

var stack: [0..100] string;
var top = -1;

var scores: [0..100] int;
var numScores = 0;

var openings : domain(string) = ["(", "[", "{", "<"]; 
var closings : [openings] string;
for (o,c) in zip("({[<", ")}]>") {
    closings[o] = c;
}

var values = ["(" => 1, "[" => 2, "{" => 3, "<" => 4];

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
            // corrupted line
            top = -1;
            break;
        }
    }
    if (top != -1) {
        // incomplete line
        var score = 0;
        for i in 0..top by -1 {
            score = (score * 5) + values[stack[i]];
        }
        scores[numScores] = score;
        numScores += 1;
    }
}
sort(scores[0..<numScores]);
var median = numScores/2;
writeln(scores[median]);

