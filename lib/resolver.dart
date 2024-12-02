import 'dart:mirrors';
import 'dart:io';

import 'package:collection/collection.dart';

mixin Resolver {
  String get firstInput => _first.join('\n');
  List<String> get firstLines => _first;
  String get secondInput => _second.join('\n');
  List<String> get secondLines => _second;
  List<String> _first = [];
  List<String> _second = [];

  Future<void> init(int day) async {
    final padded = day > 9 ? day.toString() : '0$day';
    try {
      _first = await File('${Directory.current.path}/lib/days/$padded/01')
          .readAsLines();
    } catch (_) {}
    try {
      _second = await File('${Directory.current.path}/lib/days/$padded/02')
          .readAsLines();
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
