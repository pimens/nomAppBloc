import 'package:flutter/material.dart';
import 'package:KimochiApps/src/ui/Recent.dart';
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
            onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new Recent(
                  hp: dataLogin.length == 0
                      ? (-1).toString()
                      : dataLogin[0].toString()),
            )),
            child: ListTile(
              title: Text(
                "Recent Orders",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ZCOOL QingKe HuangYou',
                  fontSize: 40.0,
                  color: Color.fromRGBO(243, 156, 18, 20),
                ),
              ),
              leading: Icon(
                Icons.view_list,
                color: Color.fromRGBO(243, 156, 18, 20),
                size: 40,
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
