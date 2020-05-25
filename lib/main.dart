import 'package:KimochiApps/src/blocs/cabang/CabangBloc.dart';
import 'package:KimochiApps/src/blocs/Global/GlobalBloc.dart';
import 'package:KimochiApps/src/blocs/makanan/MakananBloc.dart';
import 'package:KimochiApps/src/ui/Beranda.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:core';

class MyBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }
}

void main() {
  // Start observing BLoC's state and events's transitions
  BlocSupervisor.delegate = MyBlocDelegate();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MakananBloc>(
        create: (BuildContext context) => MakananBloc(),
      ),
      BlocProvider<CabangBloc>(
        create: (BuildContext context) => CabangBloc(),
      ),
      BlocProvider<GlobalBloc>(
        create: (BuildContext context) => GlobalBloc(),
      )
    ],
    child: MyApp(),
  ));
  // BlocProvider<MakananBloc>(
  //   create: (BuildContext context) => MakananBloc(), child: MyApp()));
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Sp(),
      // routes: <String, WidgetBuilder>{
      //   '/a': (BuildContext context) => Cbg(),
      //   // '/b': (BuildContext context) => MyPage(title: 'page B'),
      //   // '/c': (BuildContext context) => MyPage(title: 'page C'),
      // },
    );
  }
}

class Sp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new Beranda(),
      title: Text(
        "",
        style: TextStyle(
          fontSize: 30,
          fontFamily: 'Bangers-Regular',
          color: Color.fromRGBO(243, 156, 18, 20),
          // fontWeight: FontWeight.bold,
        ),
      ),
      // image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
      image: Image.asset("assets/logo.jpg"),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      // onClick: () => print("Kimochi"),
      loaderColor: Colors.red,
    );
  }
}
