import 'package:aoc_2024/resolver.dart';
import 'package:args/args.dart';
import 'package:aoc_2024/parts/parts.dart' as parts;

Future<void> main(List<String> args) async {
  final parser = ArgParser()
    ..addOption(
      'part',
      abbr: 'p',
      defaultsTo: '1',
    );

  final part = int.tryParse(parser.parse(args).option('part') ?? '');

  if (part == null) {
    throw ArgumentError('Invalid part argument');
  }

  var resolver = await createResolver(part);
  if (resolver == null) {
    throw Exception('Resolver could not be created');
  }
  await resolver.init(part);

  print(
    'Part one: ' + resolver.resolvePartOne(),
  );
  print(
    'Part two: ' + resolver.resolvePartTwo(),
  );
}
