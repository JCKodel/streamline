# Streamline ![Test Badge](https://github.com/JCKodel/streamline/actions/workflows/dart.yml/badge.svg)

# Flutter Mediator Pattern Library

A Flutter library that helps you write cleaner, more maintainable apps by separating business logic from UI and data layers using the Mediator pattern.

![Streamline](https://raw.githubusercontent.com/JCKodel/streamline/refs/heads/main/diagram.png?raw=true)

## Why Use This Library?

When building Flutter apps, it's easy to end up with messy code where business logic, UI, and data access are all mixed together. This library helps you organize your code better by thinking in terms of:

- **Questions** your app needs to answer
- **Commands** your app needs to execute
- **Events** that happen in your app

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

## Getting Started

### 1. Installation
Add this to your pubspec.yaml:

```yaml
dependencies:
  streamline: any
```

### 2. How state is managed

All UI state is managed by queries (for example: get the list of available products). You'll use `QueryBuilder` for that, especifying the query you want to call and the builder will run with the query result. This widget will re-ask the query whenever one of its event observers catch a new event (for example: when some part of your app creates a new product, it will emit a `ProductAdded` event. The `QueryBuilder` that shows the list of products can listen to that event (with filters, if you need) and re-run the query, rebuilding the UI if something has changed.

### 3. Example App

Check out the example folder for a complete Todo app implementation that demonstrates:

- How to structure your app using this pattern
- How to handle user interactions
- How to manage state
- How to respond to domain events

# Benefits

## Clean Separation of Concerns

- UI layer only handles display and user input
- Business logic is isolated in handlers
- Data access is separated from business rules

## Easy to Test

- Business logic can be tested without UI
- Clear inputs (Commands/Queries) and outputs
- Better Maintainability
- Each piece of functionality has a clear place
- Easy to understand what your app can do
- Simple to add new features

## Learn More

For more detailed information:

- Check out the API Documentation: https://pub.dev/documentation/streamline/latest/
- Look at the Example App: https://github.com/JCKodel/streamline/tree/main/example
- Read about the Mediator Pattern: https://en.wikipedia.org/wiki/Mediator_pattern

