import 'package:flutter/material.dart';
// import 'package:flutter_jobs/Status.dart';
// import 'package:flutter_jobs/DetailScreen.dart';
// import 'package:flutter_jobs/utils/Colors.dart';

class CircleStatusLogo extends StatefulWidget {
  final Icon status;

  const CircleStatusLogo({
    this.status,
    Key key,
  }) : super(key: key);

  @override
  CircleStatusLogoState createState() {
    return new CircleStatusLogoState();
  }
}

class CircleStatusLogoState extends State<CircleStatusLogo>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return new CircleWithAnimation(widget: widget);
  }

  @override
  bool get wantKeepAlive => true;
}

class CircleWithAnimation extends StatefulWidget {
  const CircleWithAnimation({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final CircleStatusLogo widget;

  @override
  CircleWithAnimationState createState() {
    return new CircleWithAnimationState();
  }
}

class CircleWithAnimationState extends State<CircleWithAnimation>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: FractionalTranslation(
        child: Material(
          type: MaterialType.circle,
          color: Colors.black,
          elevation: 10.0,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(width: 1.0, color: Colors.transparent)),
              height: 50.0,
              width: 50.0,
              child: widget.widget.status
              ),
        ),
        translation: Offset(-0.5, 0.82),
      ),
    );
  }

  getDomain(String trim) {}
}
