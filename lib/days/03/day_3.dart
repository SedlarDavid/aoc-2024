import 'package:aoc_2024/resolver.dart';

class Day3 with Resolver {
  @override
  String resolvePartOne() {
    final regex = RegExp(r'(mul)\((\d{1,3},\d{1,3})\)');

    final matches = regex.allMatches(firstAsString);

    var sum = 0;
    for (final match in matches) {
      final parts = firstAsString
          .substring(match.start, match.end)
          .replaceAll('mul', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .split(',')
          .map(int.tryParse)
          .nonNulls
          .toList();
      if (parts.length != 2) {
        continue;
      }
      sum += parts[0] * parts[1];
    }

    return sum.toString();
  }

  @override
  String resolvePartTwo() {
    return 'Not implemented yet!';
  }
}
