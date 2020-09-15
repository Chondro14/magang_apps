import 'package:flutter/material.dart';

class Listpromo extends StatelessWidget {
  final String image;

  Listpromo({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          width: MediaQuery.of(context).size.width / 1.8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              image: DecorationImage(
                image: NetworkImage(image),
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    offset: Offset(5, 5),
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(0.1))
              ])),
    );
  }
}
