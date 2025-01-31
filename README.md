# Streamline ![Test Badge](https://github.com/JCKodel/streamline/actions/workflows/dart.yml/badge.svg)
### CQRS/Mediator Pattern for Flutter - The Simple Way! 🚀

Streamline is a lightweight library that brings enterprise-grade application architecture to Flutter, making it super easy to understand and implement - even if you're new to professional software development! Think of it as local micro-services for your Flutter app. 

![Streamline](https://raw.githubusercontent.com/JCKodel/streamline/refs/heads/main/diagram.png?raw=true)

## What's This All About? 🤔

Think of Streamline as a smart messenger for your app. Instead of components talking directly to each other (which can get messy), they send messages through a central hub. It's like having a super-organized assistant managing all communication in your app!

## Core Concepts Made Simple 📚

### Commands & Queries
- **Commands**: Actions that change things (like "CreateUser" or "UpdateProfile")
- **Queries**: Questions that just get information (like "GetUserProfile" or "GetTodoList")

### Events
- Think of these as announcements about things that happened
- Example: "UserSignedIn", "ProfileUpdated", "TodoCreated"
- Great for updating different parts of your app when something important happens

### Aggregators
- Special queries that collect information from multiple sources
- Perfect for features like calendars where you need to gather events from different parts of your app. "GetAllCalendarEvents" might collect meetings, tasks, and reminders to show them all on one calendar UI.

## Flutter Widgets That Make Life Easier 🎯

### QueryBuilder
```dart
// Simple usage
QueryBuilder<UserProfile>(
  query: GetUserProfileQuery(),
  builder: (context, profile) => Text(profile.name),
)

// With event observers to auto-refresh
QueryBuilder<UserProfile>(
  query: GetUserProfileQuery(),
  builder: (context, profile) => Text(profile.name),
  eventObservers: [
    // Refresh when user updates their profile
    Mediator.events.getStream<UserProfileUpdated>(),
    // Also refresh when user changes their settings
    Mediator.events.getStream<UserSettingsChanged>(),
  ],
  // Optional loading widget
  waiterBuilder: (context) => CircularProgressIndicator(),
  // Optional error handler
  errorBuilder: (context, error, stackTrace) => Text('Oops! $error'),
)
```

## Why Should You Use Streamline? ✨ 

**Keep Things Organized:** Each piece of your app has a clear job

**Easy to Test:** Commands and queries are isolated and simple to test

**Flexible:** Need to add new features? Just add new commands/queries!

**Flutter-Friendly:** Built specifically for Flutter developers

**Beginner-Friendly:** No PhD in software architecture required!

## Getting Started 🚀
Add to your pubspec.yaml:

```yaml
dependencies:
  streamline: ^1.0.0
```

Import and start using:

```dart
import 'package:streamline/streamline.dart';
```

### Examples 📱

Check the [examples folder](https://github.com/JCKodel/streamline/tree/main/example) for a ToDo list app using this architecture!

### Dependencies 📦

- [dart_mappable](https://pub.dev/packages/dart_mappable) Dart Mappable is a very good library that implements value equality, copyWith, pretty toString and JSON serialization for your models and messages.

> ⚠️⚠️⚠️ IMPORTANT: ⚠️⚠️⚠️: All your commands, queries, events and aggregators must use dart_mappable (we are requesting an specific interface (`IAction<TResult>`, with `toJson` and `toMap` methods) for you to remember this). This is important to avoid unnecessary rebuilds both in events and queries.

- [rxdart](https://pub.dev/packages/rxdart) RxDart is a reactive programming library for Dart and Flutter. We use the Behavior Subject stream implementation to keep track of the last emitted event, so you don't need to store the last state.

### Need Help? 🆘

[Issue Tracker](https://github.com/JCKodel/streamline/issues)

### Contributing 🤝

We love contributions! Whether it's:

* Reporting bugs
* Improving documentation
* Adding new features
* Fixing bugs

Feel free to open an issue or submit a pull request!

### License

This package is licensed under the GNU AGPL v3 license.

Important licensing notes:
- 👉 **You can freely use this package in your applications (commercial or non-commercial) without having to license your entire application under AGPL** 👈
- The AGPL license only applies if you modify **THIS** package's source code
- If you modify this package's source code and distribute it (either directly or as part of a network service), you must make your modifications available under AGPL v3
