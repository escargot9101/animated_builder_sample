import 'package:animatedbuildersample/src/ui/screen/color.dart';
import 'package:animatedbuildersample/src/ui/screen/offset.dart';
import 'package:animatedbuildersample/src/ui/screen/opacity.dart';
import 'package:animatedbuildersample/src/ui/screen/scale.dart';
import 'package:animatedbuildersample/src/ui/screen/width.dart';
import 'package:flutter/material.dart';

class AnimationSampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WidthAnimationPage(),
      routes: <String, WidgetBuilder>{
        //WidthAnimationPage.kRouteName: (BuildContext context) => WidthAnimationPage(),
        OpacityAnimationPage.kRouteName: (BuildContext context) => OpacityAnimationPage(),
        OffsetAnimationPage.kRouteName: (BuildContext context) => OffsetAnimationPage(),
        ScaleAnimationPage.kRouteName: (BuildContext context) => ScaleAnimationPage(),
        ColorAnimationPage.kRouteName: (BuildContext context) => ColorAnimationPage(),
      },
    );
  }
}