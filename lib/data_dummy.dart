import 'model/Promo.dart';
import 'model/categories.dart';
import 'model/hotdeals.dart';

List<Promo> promo = [
  Promo(
      images:
          "https://cdn.pixabay.com/photo/2016/01/09/04/22/fresh-1129779_1280.jpg"),
  Promo(
      images:
          "https://previews.123rf.com/images/baloncici/baloncici1202/baloncici120200038/12351194-fresh-fruits-and-vegetables-at-market-stall.jpg"),
  Promo(
      images:
          "https://www.allfresh.co.id/media/images/daily-news-larges/fresh-vegetables-in-basket-248867.jpg")
];
List<Categories> category = [
  Categories(
      images:
          "https://cdn.zmescience.com/wp-content/uploads/2018/05/isolated-1450274_960_720.png",
      categorynames: "Vegetable"),
  Categories(
      images:
          "https://cdn0-production-images-kly.akamaized.net/28wyxqkItdQdGoccrK5930PcezM=/640x640/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/1753506/original/051033400_1509172164-Buah-Naga-Beda-Warna-Beda-Manfaat.jpg",
      categorynames: "Fruit"),
  Categories(
      images:
          "https://ecs7.tokopedia.net/img/cache/700/product-1/2017/10/14/5340282/5340282_e89d7053-90e7-4381-96db-001e6ced3f33_664_442.png",
      categorynames: "Meat"),
  Categories(
      images:
          "https://redaksi.duta.co/wp-content/uploads/2017/02/26-bawang-putih.png",
      categorynames: "Seasonings")
];
List<HotDeals> hotdeals = [
  HotDeals(
      images:
          "https://ecs7.tokopedia.net/img/cache/700/product-1/2020/4/4/7958447/7958447_28863675-46f2-4838-b461-028fd5a51356_720_720.jpg",
      name: "Bawang Merah",
      price: 5000,
      priceName: "5.000",
      discount: 15),
  HotDeals(
      images:
          "https://ecs7.tokopedia.net/img/cache/700/product-1/2019/8/14/44364556/44364556_5c57a2ce-e0a1-4982-837f-4f483d2a7ea0_320_320",
      name: "Cabai Merah",
      price: 5000,
      priceName: "12.000",
      discount: 20),
  HotDeals(
      images:
          "https://redaksi.duta.co/wp-content/uploads/2017/02/26-bawang-putih.png",
      name: "Bawang Putih",
      price: 15000,
      priceName: "15.000",
      discount: 10)
];
