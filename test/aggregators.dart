part of 'mediator_test.dart';

@MappableClass()
final class AggregatorA with AggregatorAMappable implements IAggregator<int> {
  const AggregatorA(this.value);

  final int value;

  static const fromMap = AggregatorAMapper.fromMap;
  static const fromJson = AggregatorAMapper.fromJson;
}

final class AggregatorAHandlerA
    implements IAggregatorHandler<AggregatorA, int> {
  const AggregatorAHandlerA();

  @override
  Future<int> handle(AggregatorA aggregator) {
    return Future.value(aggregator.value + 1);
  }
}

final class AggregatorAHandlerB
    implements IAggregatorHandler<AggregatorA, int> {
  const AggregatorAHandlerB();

  @override
  Future<int> handle(AggregatorA aggregator) {
    return Future.value(aggregator.value * 2);
  }
}

void _aggregatorsTest() {
  test("Multiple results are returned", () async {
    const aggregator = AggregatorA(42);

    $aggregatorHandler(AggregatorAHandlerA.new);
    $aggregatorHandler(AggregatorAHandlerB.new);

    final results = await $aggregate(aggregator);

    expect(results.length, 2);
    expect(results.first, 43);
    expect(results.last, 84);
  });

  test("Pipeline", () async {
    const aggregator = AggregatorA(42);

    $aggregatorHandler(AggregatorAHandlerA.new);
    $aggregatorHandler(AggregatorAHandlerB.new);

    var pointer = 0;
    var preHandler1Pointer = 0;
    var preHandler2Pointer = 0;

    $registerGenericAggregatorBehaviour((action, next) {
      final aggregator = action as AggregatorA;

      preHandler1Pointer = aggregator.value + ++pointer;

      return next(action);
    });

    $registerAggregatorBehaviour((
      AggregatorA action,
      Future<int> Function(AggregatorA newAction) next,
    ) {
      preHandler2Pointer = action.value + ++pointer;

      return next(action);
    });

    final result = await $aggregate(aggregator);

    expect(result.length, 2);
    expect(result.first, 43);
    expect(result.last, 84);
    expect(pointer, 4);
    expect(preHandler1Pointer, 45);
    expect(preHandler2Pointer, 46);
  });
}
