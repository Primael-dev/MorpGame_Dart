class Cell {
  int _row;
  int _col;
  String _value;

  Cell(this._row, this._col) : _value = '';

  int getRow() => _row;
  int getCol() => _col;
  String getValue() => _value;

  bool isEmpty() => _value == '';

  void setValue(String value) {
    _value = value;
  }

  void clear() {
    _value = '';
  }

  @override
  String toString() => _value.isEmpty ? ' ' : _value;
}

class Board {
  late List<List<Cell>> _cells;

  Board() {
    initializeBoard();
  }

  void initializeBoard() {
    _cells = List.generate(
      3,
      (row) => List.generate(3, (col) => Cell(row, col)),
    );
  }

  void reset() {
    for (var row in _cells) {
      for (var cell in row) {
        cell.clear();
      }
    }
  }

  bool isCellEmpty(int row, int col) {
    if (!isValidPosition(row, col)) return false;
    return _cells[row][col].isEmpty();
  }

  bool makeMove(int row, int col, String symbol) {
    if (!isValidPosition(row, col)) return false;
    if (!isCellEmpty(row, col)) return false;
    _cells[row][col].setValue(symbol);
    return true;
  }

  Cell getCell(int row, int col) => _cells[row][col];

  bool isFull() {
    for (var row in _cells) {
      for (var cell in row) {
        if (cell.isEmpty()) return false;
      }
    }
    return true;
  }

  bool isValidPosition(int row, int col) {
    return row >= 0 && row < 3 && col >= 0 && col < 3;
  }

  void displayBoard() {
    print('\n  0   1   2');
    for (int i = 0; i < 3; i++) {
      print('$i ${_cells[i][0]} | ${_cells[i][1]} | ${_cells[i][2]}');
      if (i < 2) print('  ---------');
    }
    print('');
  }

  @override
  String toString() {
    String result = '';
    for (var row in _cells) {
      result += row.map((cell) => cell.toString()).join('|');
      result += '\n';
    }
    return result;
  }
}