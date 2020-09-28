import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:magang_apps/screen/shopping_cart_main_view.dart';

import 'BlogScreenMainView.dart';
import 'ChatScreenMainView.dart';
import 'FeedScreenMainView.dart';
import 'HomeScreenMainView.dart';


class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});

  IconData iconData;
  String text;
}

class BottomnavigationMainView extends StatefulWidget {
  BottomnavigationMainView({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BottomnavigationMainView(),
    );
  }

  @override
  _BottomnavigationMainViewState createState() =>
      _BottomnavigationMainViewState();
}

class _BottomnavigationMainViewState extends State<BottomnavigationMainView> {
  int screenPageIndex = 0;
  Color colorse = Colors.black45;

  Widget screenPage = new HomeScreenMainView();

  Widget ChooseScreen(int indexPage) {
    switch (indexPage) {
      case 0:
        return new HomeScreenMainView();
      case 1:
        return new ChatScreenMainView();
      case 2:
        return new ShoppingCartMainView();

      case 3:
        return new BlogScreenMainView();
      case 4:
        return new FeedScreenMainView();
    }
  }

  Color colorIcon(int indexPage) {
    switch (indexPage) {
      case 0:
        return Colors.yellow[700];
      case 1:
        return Colors.yellow[700];
      case 2:
        return Colors.yellow[700];
      case 3:
        return Colors.yellow[700];
      case 4:
        return Colors.yellow[700];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: screenPage,
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.add_shopping_cart),
            backgroundColor: Colors.yellow[500],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 6,
                      onPressed: () {
                        setState(() {
                          screenPageIndex = 0;
                          screenPage = ChooseScreen(screenPageIndex);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            size: 30,
                            color: screenPageIndex == 0
                                ? Colors.yellow[700]
                                : Colors.black45,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                                color: screenPageIndex == 0
                                    ? Colors.yellow[700]
                                    : Colors.black45),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 6,
                      onPressed: () {
                        setState(() {
                          screenPageIndex = 1;
                          screenPage = ChooseScreen(screenPageIndex);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.chat,
                            size: 30,
                            color: screenPageIndex == 1
                                ? Colors.yellow[700]
                                : Colors.black45,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(
                                color: screenPageIndex == 1
                                    ? Colors.yellow[700]
                                    : Colors.black45),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 6,
                      onPressed: () {
                        setState(() {
                          screenPageIndex = 3;
                          screenPage = ChooseScreen(screenPageIndex);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.web_asset,
                            size: 30,
                            color: screenPageIndex == 3
                                ? Colors.yellow[700]
                                : Colors.black45,
                          ),
                          Text(
                            'Blog',
                            style: TextStyle(
                                color: screenPageIndex == 3
                                    ? Colors.yellow[700]
                                    : Colors.black45),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width / 6,
                      onPressed: () {
                        setState(() {
                          screenPageIndex = 4;
                          screenPage = ChooseScreen(screenPageIndex);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.web,
                            size: 30,
                            color: screenPageIndex == 4
                                ? Colors.yellow[700]
                                : Colors.black45,
                          ),
                          Text(
                            'Feeds',
                            style: TextStyle(
                                color: screenPageIndex == 4
                                    ? Colors.yellow[700]
                                    : Colors.black45),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          color: Colors.white,
          shape: CustomAppBar(0),
        ));
  }
}

class CustomAppBar extends NotchedShape {
  final double radius;

  CustomAppBar(this.radius);

  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final notchRadius = guest.width / 2.0;

    const s1 = 15.0;
    const s2 = 1.0;

    final r = notchRadius;
    final a = -1.0 * r - s2;
    final b = host.top - guest.center.dy;

    final n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final p2yA = -math.sqrt(r * r - p2xA * p2xA);
    final p2yB = -math.sqrt(r * r - p2xB * p2xB);

    final p = List<Offset>(6);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (var i = 0; i < p.length; i += 1) {
      p[i] += guest.center;
      //p[i] += padding;
    }

    return (radius ?? 0) > 0
        ? (Path()
          ..moveTo(host.left, host.top + radius)
          ..arcToPoint(Offset(host.left + radius, host.top),
              radius: Radius.circular(radius))
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(
            p[3],
            radius: Radius.circular(notchRadius),
            clockwise: true,
          )
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.right - radius, host.top)
          ..arcToPoint(Offset(host.right, host.top + radius),
              radius: Radius.circular(radius))
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close())
        : (Path()
          ..moveTo(host.left, host.top)
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(
            p[3],
            radius: Radius.circular(notchRadius),
            clockwise: true,
          )
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.right, host.top)
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close());
  }
}
