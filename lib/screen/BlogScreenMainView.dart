import 'package:flutter/material.dart';

class BlogScreenMainView extends StatefulWidget {
  BlogScreenMainView({Key key}) : super(key: key);

  @override
  _BlogScreenMainViewState createState() => _BlogScreenMainViewState();
}

class _BlogScreenMainViewState extends State<BlogScreenMainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(automaticallyImplyLeading: false,bottom: TabBar(isScrollable: true,tabs: <Tab>[]),),);
  }
}
