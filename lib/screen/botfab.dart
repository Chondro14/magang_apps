import 'package:flutter/material.dart';

class FABNavBarItem {
  FABNavBarItem({this.title, this.icondata});

  IconData icondata;
  String title;
}

class Botfab extends StatefulWidget {
  Botfab({this.items,
    this.onNavSelected,
    this.notchedShape,
    this.size,
    this.height,
    this.colors,
    this.backgroundcolor,
    this.CenterText,
    this.selectedColor}) {

  }
  final List<FABNavBarItem> items;
  final ValueChanged<int> onNavSelected;
  final String CenterText;
  final Color backgroundcolor;
  final Color selectedColor;
  final Color colors;
  final NotchedShape notchedShape;
  final double size;
  final double height;

  @override
  _BotfabState createState() => _BotfabState();
}

class _BotfabState extends State<Botfab> {
  int _selectedIndex = 0;

  _update(int index) {
    widget.onNavSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }


  Widget buildMiddleitem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: widget.size,),
            Text(
              widget.CenterText ?? '', style: TextStyle(color: widget.colors),)
          ],
        ),
      ),
    );
  }

  Widget buildItem(FABNavBarItem navitems, int index,
      ValueChanged<int> onPressed) {
    Color color =
    _selectedIndex == index ? widget.selectedColor : widget.colors;
    return Expanded(
        child: SizedBox(
          height: widget.height,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () => onPressed(index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    navitems.icondata,
                    color: color,
                    size: widget.size,
                  ),
                  Text(
                    navitems.title,
                    style: TextStyle(color: color),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'increment',
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        elevation: 2.0,
        backgroundColor: Colors.yellow[500],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height / 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width / 4.5,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.home,
                          size: 30,
                          color: Colors.black45,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width / 4.5,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          size: 30,
                          color: Colors.black45,
                        ),
                        Text(
                          'Chat',
                          style: TextStyle(color: Colors.black45),
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
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width / 4.5,
                    onPressed: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.web_asset,
                          size: 30,
                          color: Colors.black45,
                        ),
                        Text(
                          'Blog',
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width / 4.5,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.web,
                          size: 30,
                          color: Colors.black45,
                        ),
                        Text(
                          'Feeds',
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.blue,
      ),
    );
  }
}
