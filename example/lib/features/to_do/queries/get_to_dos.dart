import 'package:dart_mappable/dart_mappable.dart';

import 'package:streamline/streamline.dart';

import '../contracts/i_to_dos_repository.dart';
import '../entities/to_do.dart';

part 'get_to_dos.mapper.dart';

/// This query represents the desire to get a list of to-dos, so, it implements
/// the [IQuery<TResponse>] interface (which means: a question that will
/// return a TResponse). We could make TResponse a [List<ToDo>], and consider
/// an empty list as no to-dos available, but the implementation for fetching
/// that data also can lead to an exception, so we create a sealed class (
/// union type) to represent all possible responses for this query: we got
/// a list of to-dos, we got no to-dos because there are none (or they are all
/// filtered or we get an exception. In this case, it doesn't make sense to
/// pass the exception to our view (the view should not know implementation
/// details, such as an HttpException, so, in the implementation, we can catch
/// those specific domain errors and create an appropriated high-level
/// message in response, for example: NoInternetAvailableResponse)) This makes
/// the use of try/catch blocks necessary only in the implementation, making
/// the code far more readable and safe.
///
/// As a thumb rule, make all your views, queries, mutations, etc. safe (no
/// exceptions triggered or catched) and consider your implementation (the code
/// that actually access a database or a remote API or a GPS sensor, or
/// shared_preferences, etc. as unsafe and *always* handling exceptions
/// using try/catch).
sealed class GetToDosResponse {
  const GetToDosResponse();
}

/// This is the response for a successful query with a list of to-dos.
final class SuccessGetToDosResponse extends GetToDosResponse {
  const SuccessGetToDosResponse(this.toDos);

  final List<ToDo> toDos;
}

/// This is the response when no to-dos are available.
final class EmptyGetToDosResponse extends GetToDosResponse {
  const EmptyGetToDosResponse({required this.totalToDosAvailable});

  /// We will use this information to show in the UI if there are to-dos
  /// available in the data source, but filtered by some criteria in a text
  /// like "We returned 0 to-do from 4 to-dos availble".
  ///
  /// This is the magic of union types for response: every response has a
  /// semantic meaning and properties that makes sense for that meaning.
  ///
  /// No need for null properties because they exist in a type that has no
  /// information for them in one context or another.
  final int totalToDosAvailable;
}

/// Since this is an example, we will use a catch-all approach if any errors
/// occur. In a real app, you should have distinct response for known errors,
/// such as internet not available, user not authenticated, etc. This, in
/// Flutter, are called [Error]. They are things that happen outside the scope
/// or control of your app and are user-actionable (such as "you are trying to
/// save something remote but your internet is down right now"). Exceptions are
/// errors made by the developer or errors that cannot be recovered by the
/// end-user (such as corrupted database, parsing errors, etc.). If it make
/// sense to show a message to your user saying "Oops! Something that I don't
/// know what it is has happened", then, catch the unknown exception using a
/// catch-all response like this.
///
/// Usually you want to Errors to blow up your app, so things like
/// Firebase Crashlytics can catch them (and you'll have a debug context
/// available in the development stage). Don't swallow exceptions! (meaning:
/// you either show them to the user and/or you let them crash your app, logging
/// this occurence to some analytics system such as Sentry or Crashlytics).
final class ExceptionGetToDosResponse extends GetToDosResponse {
  const ExceptionGetToDosResponse(this.exception, this.stackTrace);

  final Exception exception;
  final StackTrace stackTrace;
}

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
