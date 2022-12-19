import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parallex Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BaseWidget(),
    );
  }
}

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/moon.jpg',
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }
}

class ParallexAnimation extends StatefulWidget {
  final Widget child;
  const ParallexAnimation({
    super.key,
    required this.child,
  });

  @override
  State<ParallexAnimation> createState() => _ParallexAnimationState();
}

class _ParallexAnimationState extends State<ParallexAnimation> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
