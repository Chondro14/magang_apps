import 'package:flutter/material.dart';

class Listcategories extends StatelessWidget {
  final String image;
  final String categoriesname;

  Listcategories({@required this.image, @required this.categoriesname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
                color: Colors.white,
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
                ]),
          ),
          Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              width: MediaQuery.of(context).size.width / 5,
              child: Center(
                child: Text(
                  categoriesname,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ))
        ],
      ),
    );
  }
}
