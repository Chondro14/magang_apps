import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'BottomNavigationMainView.dart';


class SplashScreenMainView extends StatefulWidget {
  SplashScreenMainView({Key key}) : super(key: key);

  @override
  _SplashScreenMainViewState createState() => _SplashScreenMainViewState();
}

class _SplashScreenMainViewState extends State<SplashScreenMainView> {
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomnavigationMainView()));
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
