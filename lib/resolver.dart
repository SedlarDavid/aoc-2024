import 'dart:mirrors';
import 'dart:io';

mixin Resolver {
  String get firstInput => _first;
  String get secondInput => _second;
  String _first = '';
  String _second = '';

  Future<void> init(int part) async {
    final padded = part > 9 ? part.toString() : '0$part';
    _first = await File(Directory.current.path + '/lib/parts/$padded/01')
        .readAsString();
    _second = await File(Directory.current.path + '/lib/parts/$padded/02')
        .readAsString();
  }

  String resolvePartOne();
  String resolvePartTwo();
}

Future<Resolver?> createResolver(int part) async {
  String libraryName = 'Part$part';

  MirrorSystem mirrorSystem = currentMirrorSystem();

  final parts = mirrorSystem.libraries.values
      .where((lib) => lib.qualifiedName == Symbol('parts'))
      .firstOrNull;

  if (parts == null) return null;

  for (var dependency in parts.libraryDependencies) {
    final library = await dependency.loadLibrary();
    var classMirror = library.declarations[Symbol(libraryName)] as ClassMirror?;

    if (classMirror != null) {
      return classMirror.newInstance(Symbol(''), []).reflectee as Resolver;
    }

    return null;
  }

  return null;
}
