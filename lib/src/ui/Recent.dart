import 'package:flutter/material.dart';
import 'package:KimochiApps/src/ui/DetailOrder.dart';
import 'package:KimochiApps/src/ui/component/Legend.dart';
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

  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull(Constants.server+"Api/getTrx/" + hp),
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
  void dispose(){
    super.dispose();
    timer.cancel();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                  return Column(
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
                                        current[index]['tanggal'].toString() +
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
                                    current[index]['status'].toString() == "0"
                                        ? Icons.close
                                        : current[index]['status'].toString() ==
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailOrder(
                                  notrx: current[index]['notrx'].toString()),
                            ),
                          );
                        },
                      ),
                      Divider(
                        thickness: 2,
                        color: Color.fromRGBO(243, 156, 18, 10),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
