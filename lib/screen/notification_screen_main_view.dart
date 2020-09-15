import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreenMainView extends StatefulWidget {
  NotificationScreenMainView({Key key}) : super(key: key);

  @override
  _NotificationScreenMainViewState createState() =>
      _NotificationScreenMainViewState();
}

class _NotificationScreenMainViewState
    extends State<NotificationScreenMainView> {
  String datePromo =
      DateTime.now().hour.toString() + ":" + DateTime.now().minute.toString();
  final fiftenAgo = new DateTime.now().subtract(Duration(minutes: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Notification',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            }),
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.yellow,
              ),
              onPressed: () {})
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
                  child: Text(
                    'Wave Notification',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow[600],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: MediaQuery.of(context).size.height / 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Badge(
                                  position: BadgePosition.bottomLeft(),
                                  showBadge: true,
                                  shape: BadgeShape.circle,
                                  badgeContent: Text(''),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                'Driver',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Text(
                                'Sayur,Bayam',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Text(
                          timeago.format(fiftenAgo, locale: 'id-ID'),
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(36, 0, 0, 0),
                  child: Divider(
                    height: 8,
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Daily Promo',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 16, 8),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('Today ' + datePromo)),
                )
              ],
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 41),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    offset: Offset(5, 5),
                                    spreadRadius: 1.0,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              image: DecorationImage(
                                scale: 1,
                                image: NetworkImage(
                                    'https://awsimages.detik.net.id/community/media/visual/2016/07/12/3b3d387f-0163-4b11-8bb5-12e0e4930cdb_169.jpg?w=700&q=90'),
                              )),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
                    child: Text(
                        'Get your today promo here,this promo limited for today'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text('More info >>',
                            style: TextStyle(color: Colors.yellow))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 0, 0, 0),
                    child: Divider(
                      height: 8,
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
