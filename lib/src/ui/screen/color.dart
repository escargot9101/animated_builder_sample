import 'package:animatedbuildersample/src/ui/screen/width.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorAnimationPage extends StatefulWidget {
  ColorAnimationPage({Key key}) : super(key: key);

  static const kRouteName = '/color';

  @override
  _ColorAnimationPageState createState() => _ColorAnimationPageState();
}

class _ColorAnimationPageState extends State<ColorAnimationPage>
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
    /// controllerのライフサイクル管理を忘れずに！
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('color animation'),
        actions: <Widget>[
          /// Button to navigate to next page
          CupertinoButton(
            onPressed: () => Navigator.of(context)
                .popUntil(ModalRoute.withName(WidthAnimationPage.kRouteName)),
            padding: EdgeInsets.zero,
            child: Text('back to top',
              style: Theme.of(context).primaryTextTheme.headline6,
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
                  style: Theme.of(context).primaryTextTheme.headline6,
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
       ),
       super(key: key);

  final AnimationController controller;
  final Animation<Color> _color;

  Widget _animationBuilder(BuildContext context, Widget child) {
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
        style: Theme.of(context).primaryTextTheme.headline6,
      ),
    );
  }
}