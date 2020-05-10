import 'package:animatedbuildersample/src/ui/screen/scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OffsetAnimationPage extends StatefulWidget {
  OffsetAnimationPage({Key key}) : super(key: key);

  static const kRouteName = '/offset';

  @override
  _OffsetAnimationPageState createState() => _OffsetAnimationPageState();
}

class _OffsetAnimationPageState extends State<OffsetAnimationPage>
    with SingleTickerProviderStateMixin {

  AnimationController _controller;

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
    super.dispose();
    /// controllerのライフサイクル管理を忘れずに！
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('offset animation'),
        actions: <Widget>[
          /// Button to navigate to next page
          CupertinoButton(
            onPressed: () => Navigator.of(context).pushNamed(ScaleAnimationPage.kRouteName),
            padding: EdgeInsets.zero,
            child: Row(
              children: <Widget>[
                Text('scale',
                  style: Theme.of(context).primaryTextTheme.title,
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white),
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
              Spacer(),
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
                  style: Theme.of(context).primaryTextTheme.title,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 100.0),
          WidthAnimation(controller: _controller),
        ],
      ),
    );
  }
}

class WidthAnimation extends StatelessWidget {
  WidthAnimation({
    Key key,
    this.controller,
  }) : _offset = Tween<Offset>(
         begin: const Offset(-100.0, 50.0),  // Offset(dx, dy)
         end: const Offset(100.0, -50.0),
       ).animate(
         /// アニメーションにカーブを設定したいときには
         /// AnimationControllerをCurvedAnimationで包む
         CurvedAnimation(
           parent: controller,
           curve: Curves.easeInOut,
         ),
       ),
       super(key: key);

  final AnimationController controller;
  final Animation<Offset> _offset;

  Widget _animationBuilder(BuildContext context, Widget child) {
    return Transform.translate(
      offset: _offset.value,
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
        width: 100.0,
        height: 100.0,
        alignment: Alignment.center,
        color: Colors.red,
        child: Text('offset',
          style: Theme.of(context).primaryTextTheme.title,
        ),
      ),
    );
  }
}