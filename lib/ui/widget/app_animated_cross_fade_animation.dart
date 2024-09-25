import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppAnimatedCrossFadeAnimation extends StatefulWidget {
  const AppAnimatedCrossFadeAnimation(
      {super.key, required this.child, required this.showAfter});
  final Widget child;
  final Duration showAfter;

  @override
  State<AppAnimatedCrossFadeAnimation> createState() =>
      _AppAnimatedCrossFadeAnimationState();
}

class _AppAnimatedCrossFadeAnimationState
    extends State<AppAnimatedCrossFadeAnimation> {
  CrossFadeState state = CrossFadeState.showFirst;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.showAfter, () {
      setState(() {
        state = CrossFadeState.showSecond;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: Opacity(
        opacity: 0.0,
        child: IgnorePointer(
          ignoring: true,
          child: widget.child,
        ),
      ),
      secondChild: widget.child,
      crossFadeState: state,
      duration: 300.milliseconds,
      sizeCurve: Curves.bounceInOut,
      firstCurve: Curves.bounceInOut,
    );
  }
}
