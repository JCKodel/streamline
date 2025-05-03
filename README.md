# Streamline - Mediator Pattern for Flutter

![Test Badge](https://github.com/JCKodel/streamline/actions/workflows/dart.yml/badge.svg)
[![pub package](https://img.shields.io/pub/v/streamline.svg)](https://pub.dev/packages/your_package_name)


A simple yet powerful library to implement the Mediator pattern in your Flutter applications, promoting clean architecture and separation of concerns.

![Streamline](https://raw.githubusercontent.com/JCKodel/streamline/refs/heads/main/diagram.png?raw=true)

---

## The Problem: Tangled Code

As Flutter applications grow, managing the flow of data and actions can become complex. Views might directly call data sources, business logic gets mixed into UI code, and components become tightly coupled. This makes the app:

*   **Hard to understand:** Where does data come from? What happens when I click this button?

*   **Difficult to test:** How do you test business logic without involving the UI or real network calls?

*   **Brittle to change:** Modifying one part often breaks another unexpectedly.

## The Solution: Separation and Mediation

A robust approach is to separate your application into distinct layers:

1.  **Views (UI):** What the user sees and interacts with (Your Flutter Widgets). Responsible *only* for displaying data and capturing user input.

2.  **Business Logic:** The core rules, processes, and decisions of your application. This is where the real work happens, in the form of queries, commands and events:

  - **Questions** your app needs to answer
  - **Commands** your app needs to execute
  - **Events** that happen in your app

3.  **I/O (Data & Services):** How your application interacts with the outside world (Databases, APIs, Device Sensors, etc.).

This library helps you manage the **Business Logic** layer and the communication *between* different parts of your app using the **Mediator pattern**.

## Core Concepts

### 1. Questions (Queries)

These are requests for information your app needs. For example:
- "Who is the currently logged-in user?"
- "What items are in the shopping cart?"
- "What is the total order amount?"

### 2. Commands

These are actions your app needs to perform. For example:

- "Sign in with Google"
- "Add product to cart"
- "Place order"

### 3. Domain Events

These are notifications about important things that happened in your app. For example:

- "User signed in"
- "Product added to cart"
- "Order placed"

### 4. Messages

Messages are simpler events that you can use to communcate between different parts of your application, without the need to use events, pipeline behaviours, etc. They differ from events in that they don't have handlers, observers, pipelines and they always trigger the handlers, no matter if the previous message is the same. Also, events are retriggered when new subscribers are added and you can get the last emitted event. Messages are volatile and are not stored anywhere (so new listeners do not receive previous messages).

Messages are useful for communicating between different widgets, for example, when you have an `AppBar` in a parent widget and you want to relay the button taps to a child widget (or vice-versa).

## How does it work?

Instead of components calling each other directly, they communicate through a central **Mediator**. You structure your business logic around three core concepts:

1.  **Queries:** Asking for information.
    *   Think of them as specific questions your UI (or other parts of your logic) might ask.

    *   Examples: `GetCurrentUserQuery`, `GetTodosQuery`, `GetProductByIdQuery(productId: 123)`

    *   Queries return data.

2.  **Commands:** Telling the system to do something.
    *   Think of them as specific instructions or actions to perform.

    *   Examples: `SignInWithGoogleCommand`, `AddTodoCommand(title: "Buy milk")`, `AddItemToCartCommand(productId: 456, quantity: 2)`

    *   Commands trigger actions and might change the application's state. They may or may not return a direct result.

3.  **Domain Events:** Announcing that something significant happened.
    *   After a Command successfully executes, it might publish an Event.

    *   Other parts of your application can listen for these events and react accordingly, without knowing *who* originally caused the event. This creates loose coupling.

    *   Examples: `UserSignedInEvent(userId: 'abc')`, `TodoAddedEvent(todoId: 1)`, `ProductPurchasedEvent(orderId: 'xyz')`

    * Especially for Streamline, those events are the triggers for UI rebuild (you use `QueryBuilder<IQuery>` to ask a question and render some UI with the response and you can listen to some event (with filters, if you need) to determine when that question will be asked again and the UI rebuilt).

## The Mediator's Role

The Mediator receives Queries and Commands, finds the appropriate **Handler** (the piece of code responsible for processing that specific Query or Command), executes it, and returns the result (for Queries) or manages the flow (for Commands, potentially publishing Events).

Usually, your handlers are always the same, having no code other than the business logic. Anything that you need to use, such as databases, APIs, etc. can be injected in the handler constructor as dependencies, using interfaces. This makes it easy to test your handlers in isolation, without having to mock or stub any external dependencies.

## Why Use This Library?

*   **Clear Separation:** Enforces a clean separation between UI, business logic, and data fetching/persistence.

*   **Improved Testability:** Handlers are typically small, focused classes that can be easily unit tested in isolation without needing Flutter widgets or external services.

*   **Enhanced Maintainability:** Logic for specific features is encapsulated within specific Handlers. Adding or changing features often involves adding/modifying specific Handlers, reducing side effects.

*   **Scalability:** Easier to manage growing complexity as new features often mean adding new Queries, Commands, and Handlers without drastically altering existing ones.

*   **Decoupling:** Components communicate via the Mediator and Events, reducing direct dependencies. Your UI doesn't need to know *how* user data is fetched, only that it needs to ask a question `AvailableProductsQuery`.

## Getting Started

1.  **Add Dependency:** Add the library to your `pubspec.yaml`:

```yaml
dependencies:
  streamline: ^latest_version # check the latest version on pub.dev
```

2.  **Configure Mediator:** 

```dart
runApp(
  // The mediator config is where you bind all your commands, queries,
  // aggregators and event handlers with the appropriate handlers.
  //
  // Notice that you can do that manually, using, for instance the
  // [Mediator.$queryHandler] method or any other method in [Mediator].
  MediatorConfig(
    // This method will be called after all handlers are registered
    onInitialize: () async => debugPrint("Mediator initialized!"),
    // If this is null, a [SizedBox.shrink] is used:
    onInitializeWaitingBuilder: (context) => const Text("Initializing..."),
    // Here we register all our request handlers. Notice that we are creating
    // our ToDo repository and passing it here (so, basically, this is a
    // singleton dependency being injected to whomever needs it). If you wish,
    // you can use a dependency injection library like GetIt for this purpose.
    queryHandlers: {
      GetToDosQuery: () => GetToDosQueryHandler(repository: repo),
    },
    // Here we register all our command handlers.
    commandHandlers: {
      SaveToDoCommand: () => SaveToDoCommandHandler(repository: repo),
      DeleteToDoCommand: () => DeleteToDoCommandHandler(repository: repo),
    },
    // From here on, you can use any Streamline widgets
    child: const ToDoApp(),
  ),
);
```

3.  **Start asking questions:** 

```dart
/// This class represents a message of type *Query*. It express the desire
/// to get something, in this case, a list of to-dos. That's why it
/// implements the [IQuery<TResponse>] interface, where the expected
/// response is a [List<ToDo>].
@MappableClass()
final class GetToDosQuery
    with GetToDosQueryMappable
    implements IQuery<GetToDosResponse> {
  const GetToDosQuery({required this.showOnlyCompleted});

  /// If true, only completed to-dos are returned
  final bool showOnlyCompleted;

  static const fromMap = GetToDosQueryMapper.fromMap;
  static const fromJson = GetToDosQueryMapper.fromJson;
}

/// This is the code that will actually be executed when a [GetToDosQuery]
/// query is requested. You can use depedency injection here if you wish, so
/// the code that actually accesses a database or a remote API returns the list
/// of to-dos.
///
/// Another approach you can take is: all the common
/// code that does not touch any external dependency, I/O or package, we write
/// in an abstract class with the methods that requires those dependencies as
/// an abstract method that must be implemented by the concrete class. Then,
/// in the registration, we choose the concrete class as the handler of this
/// type of request.
///
/// The advantage of this approach is that you can have code here that is
/// testable (such as validations, business rules, etc.), that doesn't need to
/// be reimplemented by the concrete class and that class can have anything you
/// have available here, without the need to know anything else about your
/// application. Is the approach where you implement the least possible code
/// and boilerplate, gives you the most flexibility and testability and allows
/// you to use this library as intended: a lego library where you can plugin
/// packages (or mocks for testing) with the least amount of code possible.
///
/// The [IQueryHandler<TQuery, TResponse>] interface means a class that can
/// handle the query TQuery which returns TResponse. Only one query handler
/// can exist in the app (if you need more than one, then you must use the
/// [IAggregator<TResponse>] pattern instead).
final class GetToDosQueryHandler
    implements IQueryHandler<GetToDosQuery, GetToDosResponse> {
  const GetToDosQueryHandler({required IToDosRepository repository})
      : _repository = repository;

  /// We will inject this data repository here
  final IToDosRepository _repository;

  /// Whenever someone requests a [GetToDosQuery] query, this method will be
  /// called.
  @override
  Future<GetToDosResponse> handle(GetToDosQuery query) async {
    // The only business logic here is to translate whatever our repository
    // returns. It could be a single-liner, as this example, and this is fine,
    // as, sometimes, you don't actually need any kind of business logic.
    //
    // Since this is a safe class, no exceptions are allowed here (meaning:
    // the [fetchToDos] implementation will be considered unsafe and you must
    // use a try/catch block there to ensure it returns a valid response always,
    // even if it is a [ExceptionGetToDosResponse])
    return await _repository.getToDos(query.showOnlyCompleted);
  }
}
```

## Usage Examples

**1. Define a Query and its Handler:**

```dart
// Define the Query (the question)
class GetTodosQuery extends Query<List<Todo>> {
  // Optional: Add parameters if needed, e.g., filter criteria
}

// Define the Handler (the logic to answer the question)
class GetTodosQueryHandler extends QueryHandler<GetTodosQuery, List<Todo>> {
  final ITodoRepository _repository; // Inject dependencies

  GetTodosQueryHandler(this._repository);

  @override
  Future<List<Todo>> handle(GetTodosQuery query) async {
    // Logic to fetch todos from the repository
    return await _repository.getAllTodos();
  }
}
```

# Check the example To Do App

Available here: https://github.com/JCKodel/streamline/tree/main/example

# ⚠️ Important

This library *requires" queries, commands and events to use https://pub.dev/packages/dart_mappable. Dart Mappable will add value equality to your classes (required to check, for instance, if an event is the same as the previous one, so no changes are rebuilt). Dart Mappable was chosen because on top of it you'll get a `copyWith` method, serialization/deserialization and a nice `toString()` method. Also, it's not unflexible like freezed and does not require a list of properties that you might forget, like equatable.

Other than that, the only other dependency is `rxdart`, which is used to manage streams and events.

# License 
This package is licensed under the GNU AGPL v3 license.

## Important licensing notes:

- 👉 You can freely use this package in your applications (commercial or non-commercial) without having to license your entire application under AGPL 👈

- The AGPL license only applies if you modify THIS package's source code

- If you modify this package's source code and distribute it (either directly or as part of a network service), you must make your modifications available under AGPL v3