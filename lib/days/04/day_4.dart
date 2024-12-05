import 'package:aoc_2024/resolver.dart';

class Day4 with Resolver {
  static const pattern = 'XMAS';
  @override
  String resolvePartOne() {
    final matrix = <List<String>>[];

    for (final line in firstLines) {
      matrix.add(line.split(''));
    }

// For each row
    var count = 0;
    for (var r = 0; r < matrix.length; r++) {
      final row = matrix[r];
      // Process each character
      for (var c = 0; c < row.length; c++) {
        if (r - pattern.length >= 0) {
          //Process up
          count += _tryFindUp(
            matrix,
            c,
            r,
          );
        }
        if (r + pattern.length < matrix.length) {
          // Process down
          count += _tryFindDown(
            matrix,
            c,
            r,
          );
        }
        if (c - pattern.length >= 0) {
          // Process left
          count += _tryFindLeft(
            row,
            c,
          );
        }
        if (c + pattern.length < row.length) {
          // Process right
          count += _tryFindRight(
            row,
            c,
          );
        }

        count += _tryFindDiagonal();
      }
    }

    return count.toString();
  }

  @override
  String resolvePartTwo() {
    return 'Not implemented yet!';
  }

  int _tryFindRight(List<String> row, int processingIndex) {
    final neededIndex = processingIndex + pattern.length;
    if (neededIndex > row.length) return 0;
    final rest = row.join().substring(
          processingIndex,
          neededIndex,
        );
    return rest == pattern ? 1 : 0;
  }

  int _tryFindLeft(List<String> row, int processingIndex) {
    final neededIndex = processingIndex - pattern.length;
    if (neededIndex < 0) return 0;
    final rest = row.join().substring(
          neededIndex,
          processingIndex,
        );
    final reverse = rest.split('').reversed.join();
    return reverse == pattern ? 1 : 0;
  }

  int _tryFindDown(
    List<List<String>> matrix,
    int characterIndex,
    int rowIndex,
  ) {
    try {
      final neededIndex = rowIndex + pattern.length;

      if (neededIndex > matrix.length) return 0;
      final buffer = StringBuffer();

      for (var pi = rowIndex; pi < neededIndex; pi++) {
        buffer.write(matrix[pi][characterIndex]);
      }

      return buffer.toString() == pattern ? 1 : 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  int _tryFindUp(
    List<List<String>> matrix,
    int characterIndex,
    int rowIndex,
  ) {
    try {
      final neededIndex = rowIndex - pattern.length;

      if (neededIndex < 0) return 0;
      final buffer = StringBuffer();

      for (var pi = rowIndex; pi > neededIndex; pi--) {
        buffer.write(matrix[pi][characterIndex]);
      }

      return buffer.toString() == pattern ? 1 : 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  int _tryFindDiagonal() {
    return 0;
  }
}
