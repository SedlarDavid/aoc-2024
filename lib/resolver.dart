import 'dart:mirrors';
import 'dart:io';

import 'package:collection/collection.dart';

mixin Resolver {
  String get firstAsLinesString => _firstLines.join('\n');
  String get firstAsString => _firstAsString;
  List<String> get firstLines => _firstLines;
  String get secondAsLinesString => _secondLines.join('\n');
  String get secondAsString => _secondAsString;
  List<String> get secondLines => _secondLines;
  List<String> _firstLines = [];
  String _firstAsString = '';
  List<String> _secondLines = [];
  String _secondAsString = '';

  Future<void> init(int day) async {
    final padded = day > 9 ? day.toString() : '0$day';
    try {
      _firstLines = await File('${Directory.current.path}/lib/days/$padded/01')
          .readAsLines();
      _firstAsString =
          await File('${Directory.current.path}/lib/days/$padded/01')
              .readAsString();
    } catch (_) {}
    try {
      _secondLines = await File('${Directory.current.path}/lib/days/$padded/02')
          .readAsLines();
      _secondAsString =
          await File('${Directory.current.path}/lib/days/$padded/02')
              .readAsString();
    } catch (_) {}
  }

  String resolvePartOne();
  String resolvePartTwo();
}

int getCompletedDays() {
  final mirrorSystem = currentMirrorSystem();
  final days = mirrorSystem.libraries.values
      .where((lib) => lib.qualifiedName == const Symbol('days'))
      .firstOrNull;
  return days?.libraryDependencies.length ?? 0;
}

Future<Resolver?> createResolver(int day) async {
  final libraryName = 'Day$day';

  final mirrorSystem = currentMirrorSystem();

  final days = mirrorSystem.libraries.values
      .where((lib) => lib.qualifiedName == const Symbol('days'))
      .firstOrNull;

  if (days == null) return null;

  final dependency = days.libraryDependencies[day - 1];
  final library = await dependency.loadLibrary();
  final classMirror = library.declarations[Symbol(libraryName)] as ClassMirror?;

  if (classMirror != null) {
    return classMirror.newInstance(Symbol.empty, []).reflectee as Resolver;
  }

  return null;
}
