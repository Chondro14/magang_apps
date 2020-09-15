import 'package:flutter/material.dart';

class Listhotdeals extends StatelessWidget {
  String images;
  String priceName;
  int price;
  int discount;
  String names;

  Listhotdeals(
      {this.discount, this.priceName, this.names, this.images, this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      offset: Offset(5, 5),
                      spreadRadius: 1.0,
                      color: Colors.black.withOpacity(0.1))
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 9.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(images))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    names,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Rp " + priceName + "/packs",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "View more >",
                      style: TextStyle(fontSize: 10, color: Colors.yellow[700]),
                    ),
                  ),
                )
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(90, 0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.bookmark,
                  size: 36,
                  color: Colors.yellow[700],
                ),
                Text(
                  discount.toString() + "%",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
