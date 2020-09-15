import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class ChatsScreenMainView extends StatefulWidget {
  ChatsScreenMainView({Key key}) : super(key: key);

  @override
  _ChatsScreenMainViewState createState() => _ChatsScreenMainViewState();
}

class _ChatsScreenMainViewState extends State<ChatsScreenMainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: ListTile(
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
          title: Text('Driver'),
          subtitle: Text('Sedang Mengirim Pesanan'),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.red,
              ),
              onPressed: null)
        ],
      ),
      bottomSheet: BottomAppBar(
        child: Container(
          height: MediaQuery.of(context).size.height / 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.camera_alt), onPressed: null),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: 'Ketik di sini'),
                ),
              ),
              CircleAvatar(
                child: Icon(Icons.send),
              )
            ],
          ),
        ),
      ),
    );
  }
}
