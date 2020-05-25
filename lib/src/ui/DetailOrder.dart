import 'package:KimochiApps/src/blocs/Global/GlobalBloc.dart';
import 'package:KimochiApps/src/blocs/Global/GlobalEvent.dart';
import 'package:KimochiApps/src/blocs/Global/GlobalState.dart';
import 'package:KimochiApps/src/models/TrxModels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'Beranda.dart';
import 'package:KimochiApps/src/ui/util/const.dart';

class DetailOrder extends StatefulWidget {
  String notrx;
  DetailOrder({this.notrx});
  @override
  _DetailOrderState createState() => _DetailOrderState(notrx: notrx);
}

class _DetailOrderState extends State<DetailOrder> {
  GlobalBloc _globalBloc;
  String notrx;
  _DetailOrderState({this.notrx});
  double total(List<Trx> order) {
    double x = 0;
    for (int i = 0; i < order.length; i++) {
      x = x + (double.parse(order[i].subtotal));
    }
    return x;
  }

  Widget detail(List<Trx> data) {
    return Container(
      margin: EdgeInsets.only(top: 9),
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
                // Map menu = dataMenu[index];
                Trx order = data[index];
                return Column(
                  children: <Widget>[
                    FlatButton(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 5, right: 10),
                              width: MediaQuery.of(context).size.width / 5,
                              height: MediaQuery.of(context).size.height / 8,
                              child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      Constants.server +
                                          order.gambar.toString()))),
                          Text(
                            order.jumlah.toString() + "   ",
                            style: TextStyle(
                              fontFamily: 'ZCOOL QingKe HuangYou',
                              color: Colors.black,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Expanded(
                            child: Text(
                              order.nama.toString(),
                              style: TextStyle(
                                fontFamily: 'ZCOOL QingKe HuangYou',
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // addMakanan(index);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "SubTotal : ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'ZCOOL QingKe HuangYou',
                          ),
                        ),
                        Text(
                          order.subtotal.toString() + " ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'ZCOOL QingKe HuangYou',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Divider(
                      color: Color.fromRGBO(243, 156, 18, 10),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              "Total : " + total(data).toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontFamily: 'ZCOOL QingKe HuangYou',
              ),
            ),
          ),
          data.length == 0
              ? Text("")
              : data[0].status == "0" ? cancel() : Text(""),
        ],
      ),
    );
  }

  Widget cancel() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.1,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Color.fromRGBO(243, 156, 18, 20),
                width: 0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(11)),
        textColor: Color.fromRGBO(243, 156, 18, 20),
        color: Colors.black,
        onPressed: () {
          _globalBloc.add(GlobalTrxCancel(notrx: notrx));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Beranda()),
              (Route<dynamic> route) => false);
        },
        child: Text(
          "Cancel",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _globalBloc = BlocProvider.of<GlobalBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "DetailOrders",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'ZCOOL QingKe HuangYou',
            color: Color.fromRGBO(243, 156, 18, 20),
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration:
                new BoxDecoration(color: Color.fromRGBO(236, 240, 241, 10)),
            child: BlocBuilder<GlobalBloc, GlobalState>(
                bloc: _globalBloc,
                builder: (BuildContext context, GlobalState state) {
                  if (state is GlobalStateDefault) {
                    _globalBloc.add(GlobalTrxLoad(t: notrx));
                  } else if (state is GlobalStateLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GlobalStateLoaded) {
                    return detail(state.data);
                  } else if (state is GlobalStateError) {
                    return Text(state.message);
                  } else {
                    return Container(width: 0.0, height: 0.0);
                  }
                }),
          ),
        ],
      ),
    );
  }
}
