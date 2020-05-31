import 'package:KimochiApps/src/blocs/Makanan/MakananEvent.dart';
import 'package:KimochiApps/src/blocs/makanan/MakananBloc.dart';
import 'package:KimochiApps/src/blocs/makanan/MakananState.dart';
import 'package:KimochiApps/src/models/makananModels.dart';
import 'package:KimochiApps/src/ui/Cabang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'component/Carousel.dart';
import 'component/Draw.dart';
import 'component/ItemSearch.dart';
import 'package:KimochiApps/src/ui/util/const.dart';

class Beranda extends StatefulWidget {
  // @override
  // _BerandaState createState() => _BerandaState();
  @override
  _BerandaState createState() {
    return _BerandaState();
  }
}

class _BerandaState extends State<Beranda> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  ScrollController _controller;
  bool loadData = false;
  int s = 0, off = 3;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);

    animationController.forward();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
          print("akhir");
      setState(() {
        loadData = true;
      });
      setState(() {
        loadData = false;
        int tmp = this.s+3;
        s = s+3;
        _makananBloc.add(MakananEventGetNewData(tmp, this.off));
      });
    }
  }

  MakananBloc _makananBloc;
  Makanan addMakanan(Makanan m) {
    int x = int.parse(m.tmp);
    x = x + 1;
    m.tmp = x.toString();
    this.setState(() {});
    return m;
  }

  Makanan minMakanan(Makanan m) {
    int x = int.parse(m.tmp);
    x = x - 1;
    m.tmp = x.toString();
    this.setState(() {});
    return m;
  }

  Widget but(List<Makanan> data) {
    return Expanded(
      child: ListView.builder(
        controller: _controller,
        primary: false,
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          Makanan mkn = data[index];
          return GestureDetector(
              onTap: () {},
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: <Widget>[
                      // ClippedItem(current: mkn),
                      ItemSearch(
                        img: mkn.gambar.toString(),
                        title: mkn.nama,
                        address: mkn.kategori,
                        rating: mkn.harga,
                        view: index.toString(),
                      ),
                      mkn.tmp == "0"
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  border: Border.all(),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: GestureDetector(
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Color.fromRGBO(243, 156, 18, 20),
                                ),
                                onTap: () {
                                  data[index] = addMakanan(data[index]);
                                },
                              ),
                            )
                          : Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 7.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Color.fromRGBO(243, 156, 18, 20),
                                      size: 30,
                                    ),
                                    onTap: () {
                                      data[index] = addMakanan(data[index]);
                                    },
                                  ),
                                ),
                                Text(
                                  mkn.tmp.toString(),
                                  style: TextStyle(fontSize: 25.0),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 7.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 30,
                                      color: Color.fromRGBO(243, 156, 18, 20),
                                    ),
                                    onTap: () {
                                      data[index] = minMakanan(data[index]);
                                    },
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                ],
              ));
        },
      ),
    );
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _makananBloc = BlocProvider.of<MakananBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Color.fromRGBO(243, 156, 18, 20),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        backgroundColor: Colors.black,
        title: Text(
          "k i m o c h i",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Bangers-Regular',
            color: Color.fromRGBO(243, 156, 18, 20),
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Draw(),
      body: Container(
          child: BlocBuilder<MakananBloc, MakananState>(
              bloc: _makananBloc,
              builder: (BuildContext context, MakananState state) {
                if (state is MakananStateDefault) {
                  _makananBloc.add(MakananEventLoad());
                } else if (state is MakananStateLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Color.fromRGBO(243, 156, 18, 20),
                  ));
                } else if (state is MakananStateError) {
                  return Center(child: Text(state.message.toString()));
                } else if (state is MakananStateLoaded) {
                  return Column(
                    children: <Widget>[
                      Carousel(url: Constants.server + "Api/promo"),
                      Divider(
                        thickness: 2,
                        color: Color.fromRGBO(243, 156, 18, 10),
                      ),
                      but(state.data),
                      // Expanded(
                      //   child:
                      // ),
                      loadData == false
                          ? Text("")
                          : Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Color.fromRGBO(243, 156, 18, 20),
                            )),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: FlatButton(
                                color: Colors.black,
                                textColor: Color.fromRGBO(243, 156, 18, 20),
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        width: 0,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(11)),
                                onPressed: () {
                                  _makananBloc.add(MakananEventLoad());
                                  // reset();
                                },
                                child: Text(
                                  "Reset",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: 'ZCOOL QingKe HuangYou'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: FlatButton(
                                color: Colors.black,
                                textColor: Color.fromRGBO(243, 156, 18, 20),
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black,
                                padding: EdgeInsets.all(8.0),
                                splashColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        width: 0,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(11)),
                                onPressed: () {
                                  _makananBloc.add(MakananEventOrder());
                                  // _makananBloc.add(CabangEventLoad());
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new Cb()));
                                  // _makananBloc.add(MakananEventOrder(state.data, "iman"));
                                },
                                child: Text(
                                  "Order",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: 'ZCOOL QingKe HuangYou'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(width: 0.0, height: 0.0);
                }
                return Container(width: 0.0, height: 0.0);
              })),
    );
  }
}
