import 'package:animated_builder_sample/src/ui/screen/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaleAnimationPage extends StatefulWidget {
  const ScaleAnimationPage({super.key});

  static const kRouteName = 'scale';

  @override
  State<ScaleAnimationPage> createState() => _ScaleAnimationPageState();
}

class _ScaleAnimationPageState extends State<ScaleAnimationPage>
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
        title: const Text('scale animation'),
        actions: <Widget>[
          /// Button to navigate to next page
          CupertinoButton(
            onPressed: () => context.go(
                '${GoRouterState.of(context).matchedLocation}/${ColorAnimationPage.kRouteName}'),
            padding: EdgeInsets.zero,
            child: Row(
              children: <Widget>[
                Text(
                  'color',
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
  }) : _scale = Tween<double>(begin: 1.0, end: 0.2).animate(
          /// アニメーションにカーブを設定したいときには
          /// AnimationControllerをCurvedAnimationで包む
          CurvedAnimation(
            parent: controller,
            curve: Curves.easeInOut,
          ),
        );

  final AnimationController controller;
  final Animation<double> _scale;

  Widget _animationBuilder(BuildContext context, Widget? child) {
    return Transform.scale(
      scale: _scale.value,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _animationBuilder,
      animation: controller,

      /// Transformを使用する場合は、アニメーションがContainer自体のパラメータに
      /// 影響しないのでContainerをまるごとchildに含めて無駄なリビルドを抑制する。
      child: Container(
        width: 200.0,
        height: 200.0,
        alignment: Alignment.center,
        color: Colors.red,
        child: Text(
          'scale',
          style: Theme.of(context).primaryTextTheme.titleLarge,
        ),
      ),
    );
  }
}
