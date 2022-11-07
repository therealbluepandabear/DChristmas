import std.stdio;

void main() {
	int max = 30;

	for (int treeHeight = 0; treeHeight <= max; ++treeHeight) {
		for (int indx = 0; indx < treeHeight; ++indx) {
			if (indx == 0) {
				for (int i = (max - treeHeight); i > 0; --i) {
					write(" ");
				}
			}

			write("*");
			write("*");
		}
		writeln();
	}
}
