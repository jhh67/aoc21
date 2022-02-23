use IO;
use List;
use Set;

var path: [0..100] string;
var top = -1;

var rooms: domain(string);
var adjacent: [rooms] set(string);

/*
if (! rooms.contains("foo")) {
    rooms += "foo";
    //adjacent["foo"] = list(string);
}
adjacent["foo"].append("bar");
writeln(adjacent);
writeln(adjacent["foo"]);
*/

proc add(from:string, to:string) {
    if (! rooms.contains(from)) {
        rooms += from;
    }
    adjacent[from].add(to);
}

var count = 0;
var buffer: string;
var from: string;
var sep: string;
var to: string;
while (stdin.read(buffer)) {
    (from, sep, to) = buffer.partition("-");
    add(from, to);
    add(to, from);
}

/*
for r in rooms {
    writeln(r, ": ", adjacent[r]);
}
*/

proc visit(room: string) {
    if (room.isLower()) {
        for tmp in path[0..top] {
            if (room == tmp) {
                return;
            }
        }
    }
    top += 1;
    path[top] = room;
    if (room == "end") {
        count += 1;
        writeln(",".join(path[0..top]));
    } else {
        for neighbor in adjacent[room] {
            visit(neighbor);
        }
    }
    top -= 1;
}

visit("start");
writeln("Paths: ", count);