use IO;
use IO.FormattedIO;

config var input: string;

if (input.isEmpty()) {
    writeln("You must specify an input file via --input");
    exit(1);
}
var fp = open(input, iomode.r);
var channel = fp.reader();

var n: int = 0; // # of bits in the values

class Node {
    var count: int = 0; // # of nodes in the subtree
    var left: shared Node? = nil;
    var right: shared Node? = nil;
}

var root: shared Node? = new Node();

var bits: string;

// Construct the tree of values.

var current: shared Node?;

while(channel.read(bits)) {
    if (n == 0) {
        n = bits.size;
    }
    current = root;
    for b in bits {
        if (b == "1") {
            if (current!.left == nil) {
                current!.left = new shared Node();
            }
            current = current!.left;
        } else {
            if (current!.right == nil) {
                current!.right = new shared Node();
            }
            current = current!.right;
        }
        current!.count += 1;
    }
}

// for debugging
proc Walk(node: borrowed Node, prefix: string) {
    if (node.left != nil) {
        Walk(node.left!, prefix + "1");
    } 
    if (node.right != nil) {
        Walk(node.right!, prefix + "0");
    }
    if (node.left == nil && node.right == nil) {
        for i in 1..node.count {
            writeln(prefix);
        }
    }
}

proc OGR(node: borrowed Node, in ogr: int) : int {
    if (node.left == nil && node.right == nil) {
        return ogr;
    }
    ogr <<= 1;
    if ((node.right == nil) || ((node.left != nil) && (node.left!.count >= node.right!.count))) {
        ogr |= 1;
        return OGR(node.left!, ogr);
    } else {
        return OGR(node.right!, ogr);
    }
}

proc CSR(node: borrowed Node, in csr: int) : int {
    if (node.left == nil && node.right == nil) {
        return csr;
    }
    csr <<= 1;
    if ((node.right == nil) || ((node.left != nil) && (node.left!.count < node.right!.count))) {
        csr |= 1;
        return CSR(node.left!, csr);
    } else {
        return CSR(node.right!, csr);
    }
}

// Dump the tree

//Walk(root!, "");

var ogr = OGR(root!, 0);

var csr = CSR(root!, 0);

writeln(ogr * csr);
