import 'package:animated_builder_sample/src/ui/screen/width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ColorAnimationPage extends StatefulWidget {
  const ColorAnimationPage({super.key});

  static const kRouteName = 'color';

  @override
  State<ColorAnimationPage> createState() => _ColorAnimationPageState();
}

class _ColorAnimationPageState extends State<ColorAnimationPage>
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
        title: const Text('color animation'),
        actions: <Widget>[
          /// Button to navigate to next page
          CupertinoButton(
            onPressed: () => GoRouter.of(context).go('/${WidthAnimationPage.kRouteName}'),
            padding: EdgeInsets.zero,
            child: Text('back to top',
              style: Theme.of(context).primaryTextTheme.titleLarge,
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
                child: Text('animate',
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
  }) : _color = ColorTween(
         begin: Colors.red,
         end: Colors.cyan,
       ).animate(
         /// アニメーションにカーブを設定したいときには
         /// AnimationControllerをCurvedAnimationで包む
         CurvedAnimation(
           parent: controller,
           curve: Curves.easeInOut,
         ),
       );

  final AnimationController controller;
  final Animation<Color?> _color;

  Widget _animationBuilder(BuildContext context, Widget? child) {
    return Container(
      width: 100.0,
      height: 100.0,
      alignment: Alignment.center,
      color: _color.value,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _animationBuilder,
      animation: controller,
      child: Text('color',
        style: Theme.of(context).primaryTextTheme.titleLarge,
      ),
    );
  }
}