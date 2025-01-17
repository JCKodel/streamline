part of 'mediator_test.dart';

@MappableClass()
final class QueryA with QueryAMappable implements IQuery<String> {
  const QueryA(this.parameter);

  final String parameter;

  static const fromMap = QueryAMapper.fromMap;
  static const fromJson = QueryAMapper.fromJson;
}

final class QueryAHandler implements IQueryHandler<QueryA, String> {
  const QueryAHandler();

  @override
  Future<String> handle(QueryA query) {
    return Future.value(query.parameter * 2);
  }
}

void _queriesTest() {
  test(
    "Queries are dispatched",
    () async {
      const query = QueryA("Hello");

      $queryHandler(QueryAHandler.new);

      final result = await $request(
        query,
      );

      expect(result, "HelloHello");
    },
  );

  test("Pipeline", () async {
    const query = QueryA("Hello");

    $queryHandler(QueryAHandler.new);

    var pointer = 0;
    var preHandler = "";

    $registerGenericQueryBehaviour((action, next) {
      final query = action as QueryA;

      ++pointer;
      preHandler += query.parameter * 2;

      return next(query);
    });

    $registerQueryBehaviour((
      QueryA action,
      Future<String> Function(QueryA nextAction) next,
    ) {
      ++pointer;
      preHandler += action.parameter * 2;

      return next(query);
    });

    final result = await $request(query);

    expect(result, "HelloHello");
    expect(preHandler, "HelloHelloHelloHello");
    expect(pointer, 2);
  });
}
