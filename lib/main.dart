import 'dart:async';

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
      debugShowCheckedModeBanner: false,
      title: 'Parallex Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ParallexAnimation(
        child: BaseWidget(),
      ),
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

  Duration animationDuration = const Duration(seconds: 15);

  final initialDelay = Future.delayed(
    const Duration(seconds: 1),
  );
  Timer? animationTimer;

  final parrallexWidthPercent = 120;

  double? totalAdditionalParrallexWidth;
  double? rightPostion;
  double maxEndPostion = 0;
  double maxStartPostion = 0;

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
    initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          right: rightPostion,
          duration: animationDuration,
          child: SizedBox(
            width: (childBaseWidth != null &&
                    totalAdditionalParrallexWidth != null)
                ? (childBaseWidth! + totalAdditionalParrallexWidth!)
                : null,
            child: childWithKey,
          ),
        ),
      ],
    );
  }

  void fetchChildWidth() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxRed =
          childKey.currentContext?.findRenderObject() as RenderBox;
      final childSize = renderBoxRed.size;
      childBaseWidth = childSize.width;
      initChildPositionWidth();
    });
  }

  void initChildPositionWidth() {
    totalAdditionalParrallexWidth =
        childBaseWidth! * parrallexWidthPercent / 100;
    rightPostion = -totalAdditionalParrallexWidth! / 2;
    maxEndPostion = -childBaseWidth! + totalAdditionalParrallexWidth!;
    maxStartPostion = totalAdditionalParrallexWidth!;
    setState(() {});
  }

  void initTimer() async {
    animationTimer?.cancel();
    await initialDelay;
    updateChildPostion();
    animationTimer = Timer.periodic(
      animationDuration,
      (_) {
        updateChildPostion();
      },
    );
  }

  void updateChildPostion() async {
    if (rightPostion == 0) {
      rightPostion = maxEndPostion;
    } else if (rightPostion == maxEndPostion) {
      rightPostion = maxStartPostion;
    } else if (rightPostion == maxStartPostion) {
      rightPostion = maxEndPostion;
    } else {
      rightPostion = maxEndPostion;
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    ///Closing timer on widget dispose.
    animationTimer?.cancel();
  }
}
