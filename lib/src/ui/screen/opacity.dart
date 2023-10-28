import 'package:animated_builder_sample/src/ui/screen/offset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OpacityAnimationPage extends StatefulWidget {
  const OpacityAnimationPage({super.key});

  static const kRouteName = 'opacity';

  @override
  State<OpacityAnimationPage> createState() => _OpacityAnimationPageState();
}

class _OpacityAnimationPageState extends State<OpacityAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    /// controllerのライフサイクル管理を忘れずに！
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('opacity animation'),
        actions: <Widget>[
          /// Button to navigate to next page
          CupertinoButton(
            onPressed: () => context.go(
                '${GoRouterState.of(context).matchedLocation}/${OffsetAnimationPage.kRouteName}'),
            padding: EdgeInsets.zero,
            child: Row(
              children: <Widget>[
                Text(
                  'offset',
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Spacer(),
              CupertinoButton(
                onPressed: () {
                  if (_controller.status == AnimationStatus.dismissed) {
                    _controller.forward();
                  } else if (_controller.status == AnimationStatus.completed) {
                    _controller.reverse();
                  }
                },
                color: Colors.green,
                child: Text(
                  'animate',
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 100.0),
          WidthAnimation(controller: _controller),
        ],
      ),
    );
  }
}

class WidthAnimation extends StatelessWidget {
  WidthAnimation({
    super.key,
    required this.controller,
  }) : _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(controller);

  final AnimationController controller;
  final Animation<double> _opacity;

  Widget _animationBuilder(BuildContext context, Widget? child) {
    return Opacity(
      opacity: _opacity.value,
      child: Container(
        width: 100.0,
        height: 100.0,
        alignment: Alignment.center,
        color: Colors.red,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _animationBuilder,
      animation: controller,
      child: Text(
        'opacity',
        style: Theme.of(context).primaryTextTheme.titleLarge,
      ),
    );
  }
}
