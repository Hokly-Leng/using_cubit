import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class CounterCubit extends Cubit<int> {
  CounterCubit({this.initialdata = 0}) : super(initialdata);

  int initialdata;

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CounterCubit cubit = CounterCubit();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen Cubit'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
            initialData: cubit.initialdata,
            stream: cubit.stream,
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text(
                    'Loading......',
                    style: TextStyle(fontSize: 25),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    '${snapshot.data}',
                    style: const TextStyle(fontSize: 50),
                  ),
                );
              }
            }),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => cubit.decrement(),
                icon: const Icon(Icons.remove, size: 30,),
              ),
              IconButton(
                onPressed: () => cubit.increment(),
                icon: const Icon(Icons.add, size: 30,),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
