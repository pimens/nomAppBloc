import 'package:flutter/material.dart';

class ClippedItem extends StatefulWidget {
  const ClippedItem({
    Key key,
    this.current,
  }) : super(key: key);

  final Map current;

  @override
  ClippedItemState createState() {
    return ClippedItemState();
  }
}

class ClippedItemState extends State<ClippedItem>
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
    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: ClipPath(
        // clipper: Clipper(),
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 192, 72, 100), //warna atasa
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: Color.fromRGBO(243, 156, 18, 20),
                              size: 25,
                            ),
                            Text(
                              " " + widget.current['tanggal'].toString() + "  ",
                              style: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Colors.black,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Icon(
                              Icons.local_atm,
                              color: Color.fromRGBO(243, 156, 18, 20),
                              size: 25,
                            ),
                            Text(
                              " " + widget.current['total'].toString() + "  ",
                              style: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Colors.black,
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        color: Colors.black,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.location_on,
                                  color: Color.fromRGBO(243, 156, 18, 20),
                                  size: 25,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  widget.current['alamat'].toString(),
                                  style: TextStyle(
                                    fontFamily: 'ZCOOL QingKe HuangYou',
                                    color: Color.fromRGBO(243, 156, 18, 20),
                                    fontSize: 25,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    var radius = 28.0;

    path.lineTo(0.0, size.height / 2 + radius);
    path.arcToPoint(
      Offset(0.0, size.height / 2 - radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
