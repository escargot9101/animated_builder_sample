import 'package:animated_builder_sample/src/ui/screen/opacity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WidthAnimationPage extends StatefulWidget {
  const WidthAnimationPage({super.key});

  static const kRouteName = 'width';

  @override
  State<WidthAnimationPage> createState() => _WidthAnimationPageState();
}

class _WidthAnimationPageState extends State<WidthAnimationPage>
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
        title: const Text('width animation'),
        actions: <Widget>[
          /// Button to navigate to next page
          CupertinoButton(
            onPressed: () => context.go(
                '${GoRouterState.of(context).matchedLocation}/${OpacityAnimationPage.kRouteName}'),
            padding: EdgeInsets.zero,
            child: Row(
              children: <Widget>[
                Text(
                  'opacity',
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
  }) : _width = Tween<double>(begin: 100.0, end: 300.0).animate(controller);

  final AnimationController controller;
  final Animation<double> _width;

  Widget _animationBuilder(BuildContext context, Widget? child) {
    return Container(
      width: _width.value,
      height: 100.0,
      alignment: Alignment.center,
      color: Colors.red,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _animationBuilder,
      animation: controller,
      child: Text(
        'width',
        style: Theme.of(context).primaryTextTheme.titleLarge,
      ),
    );
  }
}
