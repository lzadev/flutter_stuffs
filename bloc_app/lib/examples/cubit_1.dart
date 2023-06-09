import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc App',
      home: Cubit1(),
    );
  }
}

const names = ['Foo', 'Bar', 'Baz'];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(names.length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRadomName() {
    emit(names.getRandomElement());
  }
}

class Cubit1 extends StatefulWidget {
  const Cubit1({super.key});

  @override
  State<Cubit1> createState() => _Cubit1State();
}

class _Cubit1State extends State<Cubit1> {
  late final NamesCubit cubit;

  @override
  void initState() {
    cubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        centerTitle: true,
        title: const Text('Home Page'),
      ),
      body: StreamBuilder<String?>(
        stream: cubit.stream,
        builder: (context, snapshot) {
          print('StreamBuilder Test');
          final button = ElevatedButton(
            onPressed: () => cubit.pickRadomName(),
            child: const Text('Pick a random name'),
          );
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return button;
            case ConnectionState.waiting:
              return button;
            case ConnectionState.active:
              return Center(
                child: Column(
                  children: [
                    Text(snapshot.data ?? ''),
                    button,
                  ],
                ),
              );
            case ConnectionState.done:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
