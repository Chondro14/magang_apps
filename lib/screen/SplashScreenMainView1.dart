import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'LoginScreenMainView.dart';

class SplashScreenMainView1 extends StatefulWidget {
  SplashScreenMainView1({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreenMainView1());
  }

  @override
  _SplashScreenMainView1State createState() => _SplashScreenMainView1State();
}

class _SplashScreenMainView1State extends State<SplashScreenMainView1> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.green[300],
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FlareActor(
            'images/ala.flr',
            alignment: Alignment.center,
            animation: 'Untitled',
            callback: (name) {
              setState(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              });
            },
          )),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
