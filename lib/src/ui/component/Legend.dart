import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Draw extends StatelessWidget {
  static List dataLogin = [];
  getValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dataLogin = prefs.getStringList('user') ?? [];
    // dataLogin = prefs.getString('login') ?? '';
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
  }

  Draw() {
    getValuesSF();
  }
  Widget drawNom(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(""),
            accountName: Text(""),
            currentAccountPicture: GestureDetector(
              child: SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("assets/logo.jpg"),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: <Color>[
                Colors.white,
                Color.fromRGBO(243, 156, 18, 20),
              ]),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () => {},
            child: ListTile(
              title: Text(
                "Menunggu Konfirmasi",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(243, 156, 18, 20),
                ),
              ),
              leading: Icon(
                Icons.close,
                color: Color.fromRGBO(243, 156, 18, 20),
              ),
            ),
          ),
          InkWell(
            onTap: () => {},
            child: ListTile(
              title: Text(
                "Order Diterima",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(243, 156, 18, 20),
                ),
              ),
              leading: Icon(
                Icons.playlist_add_check,
                color: Color.fromRGBO(243, 156, 18, 20),
              ),
            ),
          ),
          InkWell(
            onTap: () => {},
            child: ListTile(
              title: Text(
                "Proses Pengantaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(243, 156, 18, 20),
                ),
              ),
              leading: Icon(
                Icons.motorcycle,
                color: Color.fromRGBO(243, 156, 18, 20),
              ),
            ),
          ),
          InkWell(
            onTap: () => {},
            child: ListTile(
              title: Text(
                "Finish",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(243, 156, 18, 20),
                ),
              ),
              leading: Icon(
                Icons.check_box,
                color: Color.fromRGBO(243, 156, 18, 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return drawNom(context);
  }
}
