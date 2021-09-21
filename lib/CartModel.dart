import 'package:restorant_app/ItemContent.dart';

class CartModel {
  String image;
  int price;
  String name;
  int id;
  List<ItemContent> itemcontents;
  var qty = 0;

  CartModel(
      this.image, this.price, this.name, this.id, this.itemcontents, this.qty);
  static List<CartModel> d1() => [];
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      json['image'],
      json['price'],
      json['name'],
      json['id'],
      json['itemcontents'],
      json['qty'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['price'] = this.price;
    data['name'] = this.name;
    data['id'] = this.id;
    data['itemcontents'] = this.itemcontents;
    return data;
  }
}
