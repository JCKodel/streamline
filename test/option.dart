part of 'functional_test.dart';

void _optionTests() {
  test("Some is returned", () {
    const option = Option.some("Hello");

    expect(option is Some, true);
    expect(option is Some<String>, true);
    expect(option is None, false);
    expect((option as Some<String>).value, "Hello");
  });

  test("None is returned", () {
    const option = Option<String>.none();

    expect(option is Some, false);
    expect(option is None, true);
    expect(option is None<String>, true);
  });

  test("Map some", () {
    const some = Option.some("Hello");
    const none = Option<String>.none();

    expect(some.map(onSome: (v) => v * 2, onNone: () => false), "HelloHello");
    expect(none.map(onSome: (v) => v * 2, onNone: () => false), false);
  });

  test("On...", () {
    const some = Option.some("Hello");
    const none = Option<String>.none();
    var onSome = false;
    var onNone = false;

    some.onSome((value) => onSome = value == "Hello");
    none.onNone(() => onNone = true);

    expect(onSome, true);
    expect(onNone, true);
  });

  test("Equality", () {
    final a = String.fromCharCode(65);
    final b = String.fromCharCode(66);
    final aa = String.fromCharCode(64 + 1);
    final bb = String.fromCharCode(64 + 2);
    final someA = Option.some("${a}${b}");
    final someB = Option.some("${aa}${bb}");

    expect(true, (someA as Some).value == (someB as Some).value);
    expect(true, someA == someB);
    expect(true, someA.hashCode == someB.hashCode);

    // ignore: prefer_const_constructors
    final noneA = Option<String>.none();
    // ignore: prefer_const_constructors
    final noneB = Option<String>.none();
    const noneC = Option<String>.none();
    const noneD = Option<int>.none();

    expect(true, noneA == noneB);
    expect(true, noneA == noneC);
    // ignore: unrelated_type_equality_checks
    expect(false, noneA == noneD);
    expect(true, noneA.hashCode == noneB.hashCode);
    expect(true, noneA.hashCode == noneC.hashCode);
    expect(false, noneA.hashCode == noneD.hashCode);
  });

  test("String representation", () {
    const someString = Option.some("Hello");
    const noneString = Option<String>.none();

    expect(someString.toString(), "Some<String>(Hello)");
    expect(noneString.toString(), "None<String>()");

    const someInt = Option.some(42);
    const noneInt = Option<int>.none();

    expect(someInt.toString(), "Some<int>(42)");
    expect(noneInt.toString(), "None<int>()");
  });
}
