import 'package:KimochiApps/src/blocs/Makanan/MakananEvent.dart';
import 'package:KimochiApps/src/blocs/cabang/CabangBloc.dart';
import 'package:KimochiApps/src/blocs/cabang/CabangEvent.dart';
import 'package:KimochiApps/src/blocs/cabang/CabangState.dart';
import 'package:KimochiApps/src/blocs/makanan/MakananBloc.dart';
import 'package:KimochiApps/src/models/CabangModels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:core';
import 'package:KimochiApps/src/ui/Order.dart';

class Cb extends StatefulWidget {
  @override
  CabangClass createState() => CabangClass();
}

// st
class CabangClass extends State<Cb> with SingleTickerProviderStateMixin {
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

  CabangBloc _cabangBloc;
  MakananBloc _makananBloc;
  @override
  Widget build(BuildContext context) {
    _cabangBloc = BlocProvider.of<CabangBloc>(context);
    return new WillPopScope(
      onWillPop: () => change(context),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Pilih cabang Terdekat",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'ZCOOL QingKe HuangYou',
                color: Color.fromRGBO(243, 156, 18, 20),
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 7),
            child: BlocBuilder<CabangBloc, CabangState>(
                bloc: _cabangBloc,
                builder: (BuildContext context, CabangState state) {
                  if (state is CabangStateDefault) {
                    _cabangBloc.add(CabangEventLoad());
                  } else if (state is CabangStateLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Color.fromRGBO(243, 156, 18, 20),
                    ));
                  } else if (state is CabangStateError) {
                    return Center(child: Text(state.message.toString()));
                  } else if (state is CabangStateLoaded) {
                    return buildListCabang(context, state.data);
                  } else {
                    return Container(width: 0.0, height: 0.0);
                  }
                  return Container(width: 0.0, height: 0.0);
                }),
          )),
    );
  }

  Future change(BuildContext context) async {
    _makananBloc = BlocProvider.of<MakananBloc>(context);
    _makananBloc.add(MakananEventGetNewData(-1, 3));
    _cabangBloc.add(CabangEventLoad());
    _cabangBloc = BlocProvider.of<CabangBloc>(context);
    Navigator.of(context).pop(true);
  }

  Widget buildListCabang(BuildContext context, List<Cabang> data) {
    return SlideTransition(
      position: animation,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              primary: false,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                Cabang cbg = data[index];
                return Column(
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 10, bottom: 10),
                            margin: EdgeInsets.only(right: 13),
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.black,
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(10.0)),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 7,
                              // height: MediaQuery.of(context).size.height / 13,
                              child: Text(
                                (index + 1).toString() + "",
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Color.fromRGBO(243, 156, 18, 20),
                                    fontFamily: 'ZCOOL QingKe HuangYou'),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  cbg.nama,
                                  style: TextStyle(
                                    fontFamily: 'ZCOOL QingKe HuangYou',
                                    color: Colors.black,
                                    fontSize: 21,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  cbg.alamat.toString(),
                                  style: TextStyle(
                                    fontFamily: 'ZCOOL QingKe HuangYou',
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Order(cab: cbg.id.toString()),
                          ),
                        );
                      },
                    ),
                    Divider(
                      color: Color.fromRGBO(243, 156, 18, 10),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
