import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'chats_screen_main_view.dart';

class ChatScreenMainView extends StatefulWidget {
  ChatScreenMainView({Key key}) : super(key: key);

  @override
  _ChatScreenMainViewState createState() => _ChatScreenMainViewState();
}

class _ChatScreenMainViewState extends State<ChatScreenMainView> {
  final fiftenAgo = new DateTime.now().subtract(Duration(minutes: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {}),
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
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
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
                  trailing: Text(
                    timeago.format(fiftenAgo, locale: 'id-ID'),
                    style: TextStyle(color: Colors.black),
                  ),
                  title: Text('Driver'),
                  subtitle: Text('Hey this is in message'),
                  onTap: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatsScreenMainView()));
                    });
                  },
                );
              })),
    );
  }
}
