import 'package:KimochiApps/src/blocs/makanan/MakananBloc.dart';
import 'package:KimochiApps/src/blocs/makanan/MakananEvent.dart';
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
  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
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
    return ListView(
      children: <Widget>[
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            Makanan mkn = data[index];
            return GestureDetector(
                onTap: () {},
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
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
                                      ),
                                      onTap: () {
                                        data[index] = addMakanan(data[index]);
                                      },
                                    ),
                                  ),
                                  Text(
                                    mkn.tmp.toString(),
                                    style: TextStyle(fontSize: 20.0),
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
                    // Center(
                    //   child: mkn.tmp == "0"
                    //       ? SizedBox(
                    //           width: double.infinity,
                    //           child: FlatButton(
                    //             textColor: Color.fromRGBO(243, 156, 18, 20),
                    //             color: Colors.black,
                    //             shape: RoundedRectangleBorder(
                    //                 side: BorderSide(
                    //                     color: Color.fromRGBO(243, 156, 18, 20),
                    //                     width: 0,
                    //                     style: BorderStyle.solid),
                    //                 borderRadius: BorderRadius.circular(11)),
                    //             onPressed: () {
                    //               data[index] = addMakanan(data[index]);
                    //               // addMakanan(state.data[index].tmp,
                    //               //     index);
                    //             },
                    //             child: Text(
                    //               "Tambah",
                    //               style: TextStyle(
                    //                   fontFamily: 'ZCOOL QingKe HuangYou',
                    //                   fontSize: 20.0),
                    //             ),
                    //           ),
                    //         )
                    //       : Column(
                    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //           children: <Widget>[
                    //             FlatButton(
                    //               color: Colors.black,
                    //               textColor: Colors.white,
                    //               shape: RoundedRectangleBorder(
                    //                   side: BorderSide(
                    //                       color:
                    //                           Color.fromRGBO(243, 156, 18, 20),
                    //                       width: 0,
                    //                       style: BorderStyle.solid),
                    //                   borderRadius: BorderRadius.circular(11)),
                    //               onPressed: () {
                    //                 data[index] = minMakanan(data[index]);
                    //               },
                    //               child: Text(
                    //                 "-",
                    //                 style: TextStyle(fontSize: 20.0),
                    //               ),
                    //             ),
                    //             Text(
                    //               mkn.tmp.toString(),
                    //               style: TextStyle(fontSize: 20.0),
                    //             ),
                    //             FlatButton(
                    //               color: Colors.black,
                    //               textColor: Colors.white,
                    //               shape: RoundedRectangleBorder(
                    //                   side: BorderSide(
                    //                       color:
                    //                           Color.fromRGBO(243, 156, 18, 20),
                    //                       width: 0,
                    //                       style: BorderStyle.solid),
                    //                   borderRadius: BorderRadius.circular(11)),
                    //               onPressed: () {
                    //                 data[index] = addMakanan(data[index]);
                    //               },
                    //               child: Text(
                    //                 "+",
                    //                 style: TextStyle(fontSize: 20.0),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    // ),
                    Divider(
                      color: Color.fromRGBO(243, 156, 18, 20),
                    ),
                  ],
                ));
          },
        ),
      ],
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
                  return Stack(
                    children: <Widget>[
                      Container(
                          decoration: new BoxDecoration(
                              color: Color.fromRGBO(236, 240, 241, 10)),
                          child: Column(
                            children: <Widget>[
                              Carousel(url: Constants.server + "Api/promo"),
                              Divider(
                                thickness: 2,
                                color: Color.fromRGBO(243, 156, 18, 10),
                              ),
                              Expanded(
                                child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                                    child: but(state.data)),
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.1,
                                      child: FlatButton(
                                        color: Colors.black,
                                        textColor:
                                            Color.fromRGBO(243, 156, 18, 20),
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.black,
                                        padding: EdgeInsets.all(8.0),
                                        splashColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Color.fromRGBO(
                                                    243, 156, 18, 20),
                                                width: 0,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(11)),
                                        onPressed: () {
                                          _makananBloc.add(MakananEventLoad());
                                          // reset();
                                        },
                                        child: Text(
                                          "Reset",
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              fontFamily:
                                                  'ZCOOL QingKe HuangYou'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.1,
                                      child: FlatButton(
                                        color: Colors.black,
                                        textColor:
                                            Color.fromRGBO(243, 156, 18, 20),
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.black,
                                        padding: EdgeInsets.all(8.0),
                                        splashColor: Colors.blueAccent,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Color.fromRGBO(
                                                    243, 156, 18, 20),
                                                width: 0,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(11)),
                                        onPressed: () {
                                          _makananBloc.add(MakananEventOrder());
                                          // _makananBloc.add(CabangEventLoad());
                                          Navigator.of(context).push(
                                              new MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          new CabangClass()));
                                          // _makananBloc.add(MakananEventOrder(state.data, "iman"));
                                        },
                                        child: Text(
                                          "Order",
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              fontFamily:
                                                  'ZCOOL QingKe HuangYou'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
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
