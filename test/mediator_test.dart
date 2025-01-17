import 'dart:async';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:streamline/streamline.dart';

part 'commands.dart';
part 'queries.dart';
part 'events.dart';
part 'aggregators.dart';
part 'mediator_test.mapper.dart';

void main() {
  tearDown(Mediator.dispose);

  group("Aggregators", _aggregatorsTest);

  group("Commands", _commandsTest);

  group("Events", _eventsTest);

  group("Queries", _queriesTest);
}
