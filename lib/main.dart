import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/cubit/counter_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // BlocProvider is a Flutter widget which provides a bloc to its children via BlocProvider.of<T>(context).
    // It is used as a dependency injection (DI) widget so that a single
    // instance of a bloc can be provided to multiple widgets within a subtree.
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: const MaterialApp(
        title: 'Flutter Starter',
        home: CounterApp(),
      ),
    );
  }
}

class CounterApp extends StatelessWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App With Bloc - Cubit'),
      ),
      // BlocListener is a Flutter widget which takes a BlocWidgetListener and an optional Bloc and
      // invokes the listener in response to state changes in the bloc. It should be used for functionality
      // that needs to occur once per state change such as navigation, showing a SnackBar, showing a Dialog, etc...
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.counterValue == 5) {
            const snackBar = SnackBar(
              content: Text('Counter is at 5'),
              duration: Duration(milliseconds: 500),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // BlocBuilder is a Flutter widget which requires a Bloc and a builder function.
              // BlocBuilder handles building the widget in response to new states.
              // BlocBuilder is very similar to StreamBuilder but has a more simple API to reduce
              // the amount of boilerplate code needed. The builder function will potentially be called
              // many times and should be a pure function that returns a widget in response to the state.
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(state.counterValue.toString(),
                      style: const TextStyle(fontSize: 50));
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 20),
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CounterAppWithBlocConsumer extends StatelessWidget {
  const CounterAppWithBlocConsumer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App With Bloc - Cubit'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // BlocConsumer exposes a builder and listener in order to react to new states.
            // BlocConsumer is analogous to a nested BlocListener and BlocBuilder but reduces
            // the amount of boilerplate needed. BlocConsumer should only be used when it is necessary to
            // both rebuild UI and execute other reactions to state changes in the bloc.
            // BlocConsumer takes a required BlocWidgetBuilder and BlocWidgetListener
            // and an optional bloc, BlocBuilderCondition, and BlocListenerCondition.
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.counterValue == 5) {
                  const snackBar = SnackBar(
                    content: Text('Counter is at 5'),
                    duration: Duration(milliseconds: 500),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              builder: (context, state) {
                return Text(state.counterValue.toString(),
                    style: const TextStyle(fontSize: 50));
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
