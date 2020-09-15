import 'package:flutter/material.dart';
import 'package:magang_apps/model/Promo.dart';
import 'package:magang_apps/model/categories.dart';
import 'package:magang_apps/model/hotdeals.dart';
import 'package:magang_apps/widget/listcategories.dart';
import 'package:magang_apps/widget/listhotdeals.dart';
import 'package:magang_apps/widget/listpromo.dart';


import '../data_dummy.dart';
import 'notification_screen_main_view.dart';

class HomeScreenMainView extends StatefulWidget {
  HomeScreenMainView({Key key}) : super(key: key);

  @override
  _HomeScreenMainViewState createState() => _HomeScreenMainViewState();
}

class _HomeScreenMainViewState extends State<HomeScreenMainView> {
  String location = "Yogyakarta";
  List<Promo> promolist = promo;
  List<Categories> categoryList = category;
  List<HotDeals> hotDeals = hotdeals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ala",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.yellow[700],
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.yellow[700],
              ),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreenMainView()));
                });
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.45,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(0, 20),
                      blurRadius: 5.0,
                      spreadRadius: 1.0)
                ]),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                        child: Text(
                          "Home",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text("Lokasi saya : " + location),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 4),
                        child: Center(
                          child: TextField(
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              hintText: "Cari...",
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 1.0)),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                        child: Text(
                          "Today's Promo",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                          child: ListView.builder(
                              itemCount: promolist.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Listpromo(
                                  image: promolist[index].images,
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 8,
                          child: ListView.builder(
                              itemCount: categoryList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Listcategories(
                                    image: categoryList[index].images,
                                    categoriesname:
                                        categoryList[index].categorynames);
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 0, 0),
                    child: Text(
                      "Hot Deals",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 30, 0),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "View more >",
                        style: TextStyle(
                            color: Colors.yellow[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4.8,
                  child: ListView.builder(
                      itemCount: hotDeals.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Listhotdeals(
                          images: hotDeals[index].images,
                          discount: hotDeals[index].discount,
                          names: hotDeals[index].name,
                          priceName: hotDeals[index].priceName,
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
