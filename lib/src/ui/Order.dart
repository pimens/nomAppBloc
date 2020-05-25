import 'package:KimochiApps/src/blocs/makanan/MakananBloc.dart';
import 'package:KimochiApps/src/blocs/makanan/MakananEvent.dart';
import 'package:KimochiApps/src/blocs/makanan/MakananState.dart';
import 'package:KimochiApps/src/models/makananModels.dart';
import 'package:flutter/material.dart';
import 'package:KimochiApps/src/ui/Beranda.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:KimochiApps/src/ui/util/const.dart';

class Order extends StatefulWidget {
  String cab;
  Order({this.cab});
  @override
  _OrderState createState() => _OrderState(cab: cab);
}

class _OrderState extends State<Order> {
  MakananBloc _makananBloc;
  List trx = [];
  int isSend = 0;
  int isNewUser = 0;
  String cab;
  String dec, dd = "a";
  final namaCont = TextEditingController();
  final alamatCont = TextEditingController();
  final hpCont = TextEditingController();
  _OrderState({this.cab});

  @override
  void initState() {
    super.initState();
    this.ambildata();

  }

  Future ambildata() async {
    http.Response hasil = await http.get(
        Uri.encodeFull(Constants.server+"Api/getMaxTrx"),
        headers: {"Accept": "application/json"});
    this.setState(() {
      trx = json.decode(hasil.body);
    });
  }

  double total(List<Makanan> order) {
    double x = 0;
    for (int i = 0; i < order.length; i++) {
      x = x + (double.parse(order[i].tmp) * double.parse(order[i].harga));
    }
    return x;
  }

  Future setCurrentAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('user', [hpCont.text.toString()]);
  }

  void decode(List<Makanan> order) {
    String tt = "";
    String pembuka = "Terimakasih+Kak+" +
        namaCont.text +
        "+Sudah+Pesan+Minuman+di+Kimochi.%0D%0A%0D%0ABerikut+pesenan+kakak+%3A%0D%0A%0A";
    String penutup =
        "%0ASelamat+kakak+dapat+voucher+exclusive+belanja+10x+%2810poin%29+dengan+varian+apapun+di+Kimochi+gratis+1+produk+minuman+bebas+pilih.+Dan+pesanan+ini+mendapatkan+1+poin+%F0%9F%91%8D%0D%0A%0D%0ASimpan+struk+digital+ini+ya+Kak%2C+dan+Simpan+No+Kami+ini+juga+dengan+nama+Kimochi-Sejenis+Minuman+untuk+mendapatkan+promo-promo+menarik+lainnya+serta+undian+kejutan+setiap+akhir+bulannya..%0D%0A%0D%0AArigatou+Gozaimasu+%F0%9F%98%8A%F0%9F%99%8F%F0%9F%8F%BB";
    for (int i = 0; i < order.length; i++) {
      tt = tt +
          order[i].tmp +
          "+" +
          order[i].nama +
          "+=+" +
          (double.parse(order[i].tmp) * double.parse(order[i].harga))
              .toString() +
          "%0A";
    }
    tt = tt + "%0AJadi+Totalnya+:+" + total(order).toString() + "%0A";
    setState(() {
      dec = pembuka + tt + penutup;
      isSend = 1;
    });
  }

  Future userExist(List<Makanan> order) async {
    http.Response hasil = await http.get(
        Uri.encodeFull(Constants.server+"Api/getJUser/" +
            hpCont.text.toString()),
        headers: {"Accept": "application/json"});
    this.setState(() {
      List u = json.decode(hasil.body);
      isNewUser = int.parse(u[0]['j']);
      if (isNewUser == 0) {
        insertUser(order);
      } else {
        addToApi(isNewUser,order);
      }
    });
  }

  Future insertUser(List<Makanan> order) async {
    http.Response hasil = await http.get(
        Uri.encodeFull(Constants.server+"Api/insertUser/" +
            namaCont.text.toString() +
            "/" +
            hpCont.text.toString()),
        headers: {"Accept": "application/json"});
    this.setState(() {
      addToApi(isNewUser,order);
    });
  }

  addToApi(int isNewUser,List<Makanan> order) { 
    for (int i = 0; i < order.length; i++) {
      insert(
          hpCont.text,
          namaCont.text,
          order[i].id,
          order[i].tmp,
          (double.parse(order[i].tmp) * double.parse(order[i].harga))
              .toString(),
          alamatCont.text);
    }
    setCurrentAccount();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Beranda()),
        (Route<dynamic> route) => false);
  }

  insert(String hp, String n, String m, String j, String st, String al) async {
    int tmp = int.parse(trx[0]['x']);
    tmp = tmp + 1;
    var url = 'http://192.168.43.184/nomAdmin/Api/insertInvoice';
    var response = await http.post(url, body: {
      "nama": n,
      "hp": hp,
      "mkn": m,
      "jmlh": j,
      "trx": tmp.toString(),
      "st": st,
      "cab": cab,
      "alamat": al
    }).then((result) {
      print(result.body);
      setState(() {
        // dd =  result.body;;
        // isSend = 1;
      });
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    _makananBloc = BlocProvider.of<MakananBloc>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "I n v o i c e s",
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
            child: BlocBuilder<MakananBloc, MakananState>(
                bloc: _makananBloc,
                builder: (BuildContext context, MakananState state) {
                  if (state is MakananStateLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is MakananStateOrder) {
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
                              itemCount: state.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                Makanan mkn = state.data[index];
                                return Column(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, right: 10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8,
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: NetworkImage(Constants.server+
                                                      mkn.gambar))),
                                          Text(
                                            mkn.tmp + "   ",
                                            style: TextStyle(
                                              fontFamily:
                                                  'ZCOOL QingKe HuangYou',
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Expanded(
                                            child: Text(
                                              mkn.nama,
                                              style: TextStyle(
                                                fontFamily:
                                                    'ZCOOL QingKe HuangYou',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                          (double.parse(mkn.tmp) *
                                                      double.parse(mkn.harga))
                                                  .toString() +
                                              " ",
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
                          Text(
                            "Total : " + total(state.data).toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'ZCOOL QingKe HuangYou',
                            ),
                          ),
                          Container(
                            decoration: new BoxDecoration(color: Colors.black),
                            child: Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Column(
                                children: <Widget>[
                                  TextField(
                                    cursorColor:
                                        Color.fromRGBO(243, 156, 18, 20),
                                    controller: namaCont,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: "N a m a   L e n g k a p",
                                      labelStyle: TextStyle(
                                        fontFamily: 'ZCOOL QingKe HuangYou',
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 22,
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontFamily: 'ZCOOL QingKe HuangYou',
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        fontSize: 20),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(243, 156, 18, 20),
                                  ),
                                  TextField(
                                    // autofocus: true,
                                    cursorColor:
                                        Color.fromRGBO(243, 156, 18, 20),
                                    controller: hpCont,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "N o m o r  H P (628XXXX)",
                                      labelStyle: TextStyle(
                                        fontFamily: 'ZCOOL QingKe HuangYou',
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 22,
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontFamily: 'ZCOOL QingKe HuangYou',
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        fontSize: 20),
                                  ),
                                  Divider(
                                    color: Color.fromRGBO(243, 156, 18, 20),
                                  ),
                                  TextField(
                                    // autofocus: true,
                                    cursorColor:
                                        Color.fromRGBO(243, 156, 18, 20),
                                    controller: alamatCont,
                                    decoration: InputDecoration(
                                      labelText: "Alamat Pengantaran",
                                      labelStyle: TextStyle(
                                        fontFamily: 'ZCOOL QingKe HuangYou',
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 22,
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontFamily: 'ZCOOL QingKe HuangYou',
                                        color: Color.fromRGBO(243, 156, 18, 20),
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.1,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(243, 156, 18, 20),
                                          width: 0,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(11)),
                                  textColor: Color.fromRGBO(243, 156, 18, 20),
                                  color: Colors.black,
                                  onPressed: () {
                                    if (hpCont.text != "") {
                                      _makananBloc.add(MakananEventLoad());
                                      userExist(state.data);
                                      // addToApi();
                                    }
                                  },
                                  child: Text(
                                    hpCont.text == "" ? "---" : "Order",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
