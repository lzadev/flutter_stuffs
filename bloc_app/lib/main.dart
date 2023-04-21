import 'dart:convert';
import 'dart:io';
import 'package:bloc_app/bloc/bloc_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

import 'bloc/person.dart';
import 'bloc/persons_bloc.dart';

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

Future<Iterable<Person>> getPersons(String url) async {
  final result = await HttpClient().getUrl(Uri.parse(url));
  final request = await result.close();
  final response = await request.transform(utf8.decoder).join();
  final jsonString = json.decode(response) as List<dynamic>;
  final persons = jsonString.map((person) => Person.fromJson(person));

  return persons;
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
                  context.read<PersonBloc>().add(
                        const LoadPersonsAction(
                          url: persons1Url,
                          loader: getPersons,
                        ),
                      );
                },
                child: const Text('LOAD PERSONS 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<PersonBloc>().add(
                        const LoadPersonsAction(
                          url: persons2Url,
                          loader: getPersons,
                        ),
                      );
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
