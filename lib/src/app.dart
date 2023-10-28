import 'package:animated_builder_sample/src/ui/screen/color.dart';
import 'package:animated_builder_sample/src/ui/screen/offset.dart';
import 'package:animated_builder_sample/src/ui/screen/opacity.dart';
import 'package:animated_builder_sample/src/ui/screen/scale.dart';
import 'package:animated_builder_sample/src/ui/screen/width.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AnimationSampleApp extends StatelessWidget {
  const AnimationSampleApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Animation Sample',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/${WidthAnimationPage.kRouteName}',
  routes: [
    GoRoute(
      path: '/${WidthAnimationPage.kRouteName}',
      builder: (context, state) => const WidthAnimationPage(),
      routes: [
        GoRoute(
          path: OpacityAnimationPage.kRouteName,
          builder: (context, state) => const OpacityAnimationPage(),
          routes: [
            GoRoute(
              path: OffsetAnimationPage.kRouteName,
              builder: (context, state) => const OffsetAnimationPage(),
              routes: [
                GoRoute(
                  path: ScaleAnimationPage.kRouteName,
                  builder: (context, state) => const ScaleAnimationPage(),
                  routes: [
                    GoRoute(
                      path: ColorAnimationPage.kRouteName,
                      builder: (context, state) => const ColorAnimationPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
