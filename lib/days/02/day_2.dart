import 'package:aoc_2024/resolver.dart';

class Day2 with Resolver {
  @override
  String resolvePartOne() {
    var safeCount = 0;
    for (final line in firstLines) {
      final levels = line.split(' ').map(int.parse).toList();

      num? lastLevel;
      var valid = true;
      final increasing = levels[0] < levels[1];
      for (final level in levels) {
        if (lastLevel == null) {
          lastLevel = level;
          continue;
        }
        if (level > lastLevel && (level - lastLevel <= 3) && increasing) {
          lastLevel = level;
          continue;
        }
        if (level < lastLevel && (lastLevel - level <= 3) && !increasing) {
          lastLevel = level;
          continue;
        } else {
          valid = false;
          break;
        }
      }
      if (valid) {
        safeCount++;
      }
    }

    return safeCount.toString();
  }

  @override
  String resolvePartTwo() {
    var safeCount = 0;
    for (final line in firstLines) {
      final valid = _processReport(line);
      if (valid) {
        safeCount++;
      }
    }
    return safeCount.toString();
  }

  bool _processReport(String line) {
    final levels = line.split(' ').map(int.parse).toList();

    var valid = false;
    for (final singleLevel in levels) {
      final validity = _processSingleLevel(singleLevel, levels);
      if (validity) {
        valid = true;
      }
    }
    return valid;
  }

  bool _processSingleLevel(int level, List<int> levels) {
    final actualLevels = List<int>.from(levels)..remove(level);
    num? lastLevel;
    final increasing = actualLevels[0] < actualLevels[1];
    var valid = true;
    for (final level in actualLevels) {
      if (lastLevel == null) {
        lastLevel = level;
        continue;
      }
      if (level > lastLevel && (level - lastLevel <= 3) && increasing) {
        lastLevel = level;
        continue;
      }
      if (level < lastLevel && (lastLevel - level <= 3) && !increasing) {
        lastLevel = level;
        continue;
      } else {
        valid = false;
        break;
      }
    }
    return valid;
  }
}
