import 'package:aoc_2024/resolver.dart';
import 'package:collection/collection.dart';

class Part1 with Resolver {
  @override
  String resolvePartOne() {
    final cols = _processInput();
    final firstCol = cols.$1;
    final secondCol = cols.$2;

    firstCol.sort();
    secondCol.sort();

    final length = firstCol.length;

    final indexToDistance = <int, int>{};

    for (var i = 0; i < length; i++) {
      if (secondCol[i] > firstCol[i]) {
        indexToDistance[i] = secondCol[i] - firstCol[i];
      } else {
        indexToDistance[i] = firstCol[i] - secondCol[i];
      }
    }

    return indexToDistance.values
        .reduce((value, element) => value + element)
        .toString();
  }

  @override
  String resolvePartTwo() {
    final cols = _processInput();
    final firstCol = cols.$1;
    final secondCol = cols.$2;

    final mapped = secondCol.groupListsBy((element) => element);

    var sum = 0;
    for (var element in firstCol) {
      if (!mapped.containsKey(element)) continue;

      sum += element * mapped[element]!.length;
    }

    return sum.toString();
  }

  (List<int>, List<int>) _processInput() {
    final firstCol = <int>[];
    final secondCol = <int>[];
    for (var line in firstLines) {
      final parts = line.split('  ');
      firstCol.add(int.parse(parts[0]));
      secondCol.add(int.parse(parts[1]));
    }

    if (firstCol.length != secondCol.length) {
      throw Exception('Columns have different lengths');
    }

    return (firstCol, secondCol);
  }
}
