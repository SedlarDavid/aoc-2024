import 'dart:io';

import 'package:aoc_2024/resolver.dart';
import 'package:args/args.dart';
// ignore: unused_import
import 'package:aoc_2024/days/days.dart' as days;

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption(
      'day',
      defaultsTo: '0',
    );

  final day = int.tryParse(parser.parse(args).option('day') ?? '');

  if (day == null) {
    throw ArgumentError('Invalid part argument');
  }

  if (day == 0) {
    final days = getCompletedDays();
    for (var i = 1; i <= days; i++) {
      stdout.writeln('Day $i');
      await _resolveDay(i);
    }
  } else {
    await _resolveDay(day);
  }
}

Future<void> _resolveDay(int day) async {
  final resolver = await createResolver(day);
  if (resolver == null) {
    throw Exception('Resolver could not be created');
  }
  await resolver.init(day);

  stdout
    ..writeln(
      'Part one: ${resolver.resolvePartOne()}',
    )
    ..writeln(
      'Part two: ${resolver.resolvePartTwo()}',
    );
}
