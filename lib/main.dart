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
  final childKey = GlobalKey();

  late Widget childWithKey;
  double? childBaseWidth;

  @override
  void initState() {
    super.initState();

    childWithKey = SizedBox(
      key: childKey,
      child: widget.child,
    );
    fetchChildWidth();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        childWithKey,
      ],
    );
  }

  void fetchChildWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxRed =
          childKey.currentContext?.findRenderObject() as RenderBox;
      final childSize = renderBoxRed.size;
      childBaseWidth = childSize.width;
    });
  }
}
