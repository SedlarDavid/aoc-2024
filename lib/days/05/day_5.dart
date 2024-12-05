import 'package:aoc_2024/resolver.dart';

class Day5 with Resolver {
  @override
  String resolvePartOne() {
    final rules = _prepareRules();
    final updates = _prepareUpdates();

    final correctUpdates = _process(updates, rules);

    final count = _countFromUpdates(correctUpdates);
    return count.toString();
  }

  @override
  String resolvePartTwo() {
    return 'Not implemented yet!';
  }

  Map<int, List<int>> _prepareRules() {
    final rules = <int, List<int>>{};
    for (final line in firstLines) {
      if (!line.contains('|')) continue;

      final parts = line.split('|').map(int.tryParse).nonNulls.toList();

      if (!rules.containsKey(parts[0])) {
        rules[parts[0]] = [];
      }

      rules[parts[0]]?.add(parts[1]);
    }
    return rules;
  }

  List<List<int>> _prepareUpdates() {
    final updates = <List<int>>[];
    for (final line in firstLines) {
      if (!line.contains(',')) continue;

      updates.addAll(
        [
          line.split(',').map(int.tryParse).nonNulls.toList(),
        ],
      );
    }
    return updates;
  }

  List<List<int>> _process(List<List<int>> updates, Map<int, List<int>> rules) {
    final correctUpdates = <List<int>>[];

    for (final update in updates) {
      final indexMap = <int, bool>{};
      for (var i = 0; i < update.length; i++) {
        final rule = rules[update[i]];
        final before = <int>[];

        if (i - 1 >= 0) {
          for (var index = i - 1; index >= 0; index--) {
            before.add(update[index]);
          }
        }

        final inter = before.toSet().intersection(rule?.toSet() ?? {});

        indexMap[i] = inter.isEmpty;
      }
      if (indexMap.values.every((element) => element)) {
        correctUpdates.add(update);
      }
    }
    return correctUpdates;
  }

  int _countFromUpdates(List<List<int>> updates) {
    var count = 0;
    for (final update in updates) {
      if (update.length % 2 != 1) {
        continue;
      }
      final middle = (update.length / 2).ceil();
      count += update[middle - 1];
    }

    return count;
  }
}
