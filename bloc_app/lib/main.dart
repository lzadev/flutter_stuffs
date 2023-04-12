import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc App',
      home: BlocProvider(
        create: (context) => PersonBloc(),
        child: const HomePage(),
      ),
    );
  }
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction extends LoadAction {
  final PersonUrl url;

  const LoadPersonsAction({required this.url});
}

Future<Iterable<Person>> getPersons(String url) async {
  final result = await HttpClient().getUrl(Uri.parse(url));
  final request = await result.close();
  final response = await request.transform(utf8.decoder).join();
  final jsonString = json.decode(response) as List<dynamic>;
  final persons = jsonString.map((person) => Person.fromJson(person));

  return persons;
}

@immutable
class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});

  Person.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        age = json["age"] as int;
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrivedFromCache;

  const FetchResult({required this.persons, required this.isRetrivedFromCache});

  @override
  String toString() =>
      'FecthResult (isRetrivedFromCache) = $isRetrivedFromCache ';
}

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      final url = event.url;
      if (_cache.containsKey(url)) {
        final personsCached = _cache[url]!;
        final fetchResult = FetchResult(
          persons: personsCached,
          isRetrivedFromCache: true,
        );

        emit(fetchResult);
      } else {
        final persons = await getPersons(url.urlString);
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

enum PersonUrl { person1, person2 }

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.person1:
        return "http://10.0.0.2:5500/api/persons1.json";
      case PersonUrl.person2:
        return "http://10.0.0.2:5500/api/persons2.json";
    }
  }
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  context
                      .read<PersonBloc>()
                      .add(const LoadPersonsAction(url: PersonUrl.person1));
                },
                child: const Text('LOAD PERSONS 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<PersonBloc>()
                      .add(const LoadPersonsAction(url: PersonUrl.person2));
                },
                child: const Text('LOAD PERSONS 2'),
              ),
            ],
          ),
          BlocBuilder<PersonBloc, FetchResult?>(
            buildWhen: (previous, current) {
              return previous?.persons != current?.persons;
            },
            builder: (context, state) {
              state?.log();
              final persons = state?.persons;
              if (persons == null) return const SizedBox.shrink();
              return Expanded(
                child: ListView.separated(
                  itemCount: persons.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(persons[index]!.name),
                      subtitle: Text(persons[index]!.age.toString()),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.indigo,
                    height: 3,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
