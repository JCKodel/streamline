## 1.0.0

* Initial release

## 1.0.0+1

* Fix minor offense to pub.dev static analysis (I want that 160 points \O/)

## 1.0.1

* Fix bug in QueryBuilder without event observers (never trust Dart analysis recommendations)

## 1.0.1+1

* Add test badge to README.md

## 1.0.2

* Fix bug in QueryBuilder where the response would be invalid if it was a list

## 1.1.0

* Add cache capabilities to QueryBuilder (which defaults to true when there is an event observer attached)

## 1.1.0+1

* Added architecture diagram to README.md

## 1.1.1

* Fix bug in cache logic of QueryBuilder

## 1.1.2

* Fix bug in cache logic of QueryBuilder
* Update dependencies

## 1.1.3

* Fix bug in cache logic of QueryBuilder
* Update dependencies

## 1.1.3+1

* Fix bug in EventDispatcher that was not executing any pipeline behaviours

## 1.2.0

* Bump dependencies
* Added `skipIfSameAsLastEmitted` option to `$emit` to prevent or allow the same event to be emitted if the last emiited event is the same as the new one (defaults to true)

## 1.3.0

* Changed the behavior of `MediatorConfig.onInitialize` to be a Future<void> instead of a void Function(). It also now runs on a `Future<void>` instead of running in the next frame
* Added `onInitializeWaitingBuilder` to MediatorConfig to allow for a custom widget to be shown while `onInitialize` is running

## 1.4.0

* Added global event observers to QueryBuilder and AggregatorBuilder (useful for refreshing the UI when a data sync occurs or when a database table changes)

## 1.4.0+2

* Better README.md (I hope)

## 1.4.1

* Added globalEventObservers to MediatorConfig (it is applied to both QueryBuilder and AggregatorBuilder)
