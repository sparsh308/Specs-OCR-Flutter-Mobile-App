import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class ImageScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;

  ImageScannerAnimation(this.stopped, this.width,
      {Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    final scorePosition = (animation.value * 440);

    Color color1 = Color(0xfff5B51D8);
    Color color2 = Color(0x00f5B51D8);

    if (animation.status == AnimationStatus.reverse) {
      color1 = Color(0x00f5B51D8);
      color2 = Color(0xfff5B51D8);
    }

    return new Positioned(
        bottom: scorePosition,
        left: 0.0,
        child: new Opacity(
            opacity: (stopped) ? 0.0 : 1.0,
            child: Container(
              height: 60.0,
              width: 500,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.9],
                colors: [color1, color2],
              )),
            )));
  }
}
