import std.stdio;
import std.algorithm: canFind;
import std.math.algebraic;
import std.random;

class Cell {
	int x;
	int y;
	char content;

	static Cell create(int x, int y, char content) {
		Cell cell = new Cell();
		cell.x = x;
		cell.y = y;
		cell.content = content;

		return cell;
	}
}

class CellUtils {
	private static Cell[] drawLineX(Cell from, Cell to) {
		Cell[] cells;

		int x = from.x;
		int y = from.y;

		int differenceX = to.x - x;
		int differenceY = to.y - y;

		int xi = 1;

		if (differenceX <= 0) {
			differenceX = -differenceX;
			xi = -1;
		}

		int p = 2 * differenceX - differenceY;

		while (y <= to.y) {
			cells ~= Cell.create(x, y, '*');
			y++;

			if (p < 0) {
				p += 2 * differenceX;
			} else {
				p = p + 2 * differenceX - 2 * differenceY;
				x += xi;
			}
		}

		return cells;
	}

	private static Cell[] drawLineY(Cell from, Cell to) {
		Cell[] cells;

		int x = from.x;
		int y = from.y;

		int differenceX = to.x - x;
		int differenceY = to.y - y;

		int yi = 1;
		int xi = 1;

		if (differenceY < 0) {
			differenceY = -differenceY;
			yi = -1;
		}

		int p = 2 * differenceY - differenceX;

		while (x <= to.x) {
			cells ~= Cell.create(x, y, '*');
			x++;

			if (p < 0) {
				p += 2 * differenceY;
				if (differenceY > differenceX) {
					x += xi;
				}
			} else {
				p = p + 2 * differenceY - 2 * differenceX;
				y += yi;
			}
		}

		return cells;
	}

	static Cell[] drawLine(Cell from, Cell to) {
		int differenceX = to.x - from.x;
		int differenceY = to.y - from.y;

		Cell[] cells;

		if (differenceY <= differenceX) {
			if (abs(differenceY) > differenceX) {
				cells ~= drawLineX(to, from);
			} else {
				cells ~= drawLineY(from, to);
			}
		} else {
			if (abs(differenceX) > differenceY) {
				cells ~= drawLineY(to, from);
			} else {
				cells ~= drawLineY(from, to);
			}
		}

		return cells;
	}
}

class Canvas {
	private int width;
	private int height;

	static Canvas create(int width, int height) {
		Canvas canvas = new Canvas();
		canvas.width = width;
		canvas.height = height;

		return canvas;
	}

	void draw(Cell[] cells) {
		Cell[] cellsDrawn;

		for (int y = 0; y < height; ++y) {
			for (int x = 0; x < width; ++x) {
				bool cellFound = false;

				foreach (cell; cells) {
					if (cell.x == x && cell.y == y && !(cellsDrawn.canFind!(cell => cell.x == x && cell.y == y))) {
						write("*");
						cellsDrawn ~= cell;
						cellFound = true;
					}
				}

				if (!cellFound) {
					write(" ");
				}
			}

			writeln();
		}
	}
}

void main() {
	Cell[] cells;

	int treeWidth = 90;
	int treeHeight = 25;

	cells ~= CellUtils.drawLine(Cell.create(0, treeHeight, '*'), Cell.create(treeWidth, treeHeight, '*'));
	cells ~= CellUtils.drawLine(Cell.create(treeWidth, treeHeight, '*'), Cell.create(treeWidth / 2, 0, '*'));
	cells ~= CellUtils.drawLine(Cell.create(0, treeHeight, '*'), Cell.create(treeWidth / 2, 0, '*'));

	foreach (cell; CellUtils.drawLine(Cell.create(0, treeHeight, '*'), Cell.create(treeWidth / 2, 0, '*'))) {
		cells ~= CellUtils.drawLine(cell, Cell.create((treeWidth / 2) + (treeWidth / 2 - cell.x), cell.y, '*'));
	}

	int branchWidth = 10;
	int branchHeight = 5;

	for (int i = (treeWidth / 2) - (branchWidth / 2); i <= (treeWidth / 2) + (branchWidth / 2); ++i) {
		for (int y = treeHeight + 1; y <= (treeHeight + 1) + branchHeight; ++y) {
			cells ~= Cell.create(i, y, '*');
		}
	}

	Canvas canvas = Canvas.create(treeWidth, treeHeight + branchHeight);

	write("\033[32m");
	canvas.draw(cells);
}
