import 'package:bloc/bloc.dart';
import 'package:bloc_app/bloc/person.dart';
import 'bloc_actions.dart';
import 'package:flutter/foundation.dart' show immutable;

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrivedFromCache;

  const FetchResult({required this.persons, required this.isRetrivedFromCache});

  @override
  String toString() =>
      'FecthResult (isRetrivedFromCache) = $isRetrivedFromCache ';

  @override
  operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetrivedFromCache == other.isRetrivedFromCache;

  @override
  int get hashCode => Object.hash(persons, isRetrivedFromCache);
}

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      print('hello world');
      final url = event.url;
      if (_cache.containsKey(url)) {
        final personsCached = _cache[url]!;
        final fetchResult = FetchResult(
          persons: personsCached,
          isRetrivedFromCache: true,
        );

        emit(fetchResult);
      } else {
        final loader = event.loader;
        final persons = await loader(url);
        _cache[url] = persons;
        final fetchResult = FetchResult(
          persons: persons,
          isRetrivedFromCache: false,
        );

        emit(fetchResult);
      }
    });
  }
}
