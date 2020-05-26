import 'package:KimochiApps/src/blocs/Global/GlobalBloc.dart';
import 'package:KimochiApps/src/blocs/Global/GlobalEvent.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:KimochiApps/src/ui/DetailOrder.dart';
import 'package:KimochiApps/src/ui/component/Legend.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:KimochiApps/src/ui/util/const.dart';

class Recent extends StatefulWidget {
  String hp;
  Recent({this.hp});
  @override
  _RecentState createState() => _RecentState(hp: hp);
}

class _RecentState extends State<Recent> {
  List user = [];
  List current = [];
  Timer timer;
  String hp;
  _RecentState({this.hp});
  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getStringList('user') ?? [];
    // data_login = prefs.getString('login') ?? '';
  }

  Widget judul(BuildContext context, String alamat) {
    return ExpandablePanel(
      // header: Text("xxx"),
      collapsed: Text(
        alamat,
        style: TextStyle(fontSize: 25.0, fontFamily: 'ZCOOL QingKe HuangYou'),
        softWrap: true,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      expanded: Text(
        alamat,
        softWrap: true,
        style: TextStyle(fontSize: 25.0, fontFamily: 'ZCOOL QingKe HuangYou'),
      ),
      tapHeaderToExpand: true,
      hasIcon: true,
    );
  }

  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull(Constants.server + "Api/getTrx/" + hp),
        headers: {"Accept": "application/json"});
    if (!mounted) return;
    this.setState(() {
      current = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    if (this.mounted) {
      super.initState();
      getValuesSF();
      this.ambildata();
      timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
        this.ambildata();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalBloc _globalBloc;
  @override
  Widget build(BuildContext context) {
    _globalBloc = BlocProvider.of<GlobalBloc>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Draw(),
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
          "Recent Orders",
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
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: current == null ? 0 : current.length,
                itemBuilder: (BuildContext context, int index) {
                  // Map menu = dataMenu[index];
                  return Container(
                      // height: MediaQuery.of(context).size.height / 6,
                      // width: MediaQuery.of(context).size.width / 1.3,
                      child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color.fromRGBO(243, 156, 18, 20),
                            width: 0,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 3.0,
                    child: Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Column(
                        children: <Widget>[
                          FlatButton(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Icon(
                                        Icons.calendar_today,
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        size: 25,
                                      ),
                                      Text(
                                        " " +
                                            current[index]['tanggal']
                                                .toString() +
                                            "  ",
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
                                        " " +
                                            current[index]['total'].toString() +
                                            "  ",
                                        style: TextStyle(
                                          fontFamily: 'ZCOOL QingKe HuangYou',
                                          color: Colors.black,
                                          fontSize: 25,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Icon(
                                        current[index]['status'].toString() ==
                                                "0"
                                            ? Icons.close
                                            : current[index]['status']
                                                        .toString() ==
                                                    "1"
                                                ? Icons.check_box
                                                : current[index]['status']
                                                            .toString() ==
                                                        "2"
                                                    ? Icons.playlist_add_check
                                                    : Icons.motorcycle,
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        size: 25.0,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: Color.fromRGBO(243, 156, 18, 20),
                                      size: 25,
                                    ),
                                    Expanded(
                                      child: Text(
                                        current[index]['alamat'].toString(),
                                        style: TextStyle(
                                          fontFamily: 'ZCOOL QingKe HuangYou',
                                          color: Colors.black,
                                          fontSize: 25,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onPressed: () {
                              _globalBloc.add(GlobalTrxLoad(t: current[index]['notrx'].toString()));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailOrder(
                                      notrx:
                                          current[index]['notrx'].toString()),
                                ),
                              );
                            },
                          ),
                          Divider(
                            thickness: 2,
                            color: Color.fromRGBO(243, 156, 18, 10),
                          ),
                        ],
                      ),
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
