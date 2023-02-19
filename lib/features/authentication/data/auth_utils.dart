import 'package:rxdart/rxdart.dart';

/// An in-memory store backed by BehaviorSubject that can be used to
/// store the data for all the repositories in the app.
class InMemoryStore<T> {
  final BehaviorSubject<T> _subject;

  Stream<T> get stream => _subject.stream;

  T get value => _subject.value;

  set value(T value) => _subject.add(value);

  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  void close() => _subject.close();
}

Future<void> delay({bool addDelay = true, int milliseconds = 2000}) {
  if (addDelay) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  } else {
    return Future.value();
  }
}
