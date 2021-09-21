import 'dart:convert';

Product clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Product.fromJson(jsonData);
}

// ignore: non_constant_identifier_names
String ProductToJson(Product data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Product {
  String image;
  int price;
  String name;
  int id;
  var qty = 0;
  Product(this.image, this.price, this.name, this.id);
  static List<Product> d1() => [
        Product(
          "images/burger.jpg",
          200,
          "Burger",
          1,
        ),
        Product(
          "images/food2.jpg",
          2800,
          "Shawarmas",
          2,
        ),
        Product(
          "images/sandwich.jpg",
          350,
          "SandWitch",
          3,
        ),
        Product(
          "images/hamburger.jpg",
          600,
          "HamBurger",
          4,
        ),
        Product(
          "images/noodles.jpg",
          800,
          "Noodles",
          5,
        ),
        Product(
          "images/pizza.jpg",
          1100,
          "Pizza",
          6,
        )
      ];
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      json['image'],
      json['price'],
      json['name'],
      json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['price'] = this.price;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
