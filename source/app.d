import std.stdio;

void main() {
	int height = 5;

	write("\033[32m");

	for (int treeHeight = 0; treeHeight <= height; ++treeHeight) {
		for (int indx = 0; indx < treeHeight; ++indx) {
			if (indx == 0) {
				for (int i = (height - treeHeight); i > 0; --i) {
					write(" ");
				}
			}

			write("*");
			write("*");
		}
		writeln();
	}
}
