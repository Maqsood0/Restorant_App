import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restorant_app/CartModel.dart';
import 'package:restorant_app/ItemContent.dart';
import 'package:restorant_app/ItemcontentModel.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vertical_tabs/vertical_tabs.dart';
import 'constant.dart';
import 'Menu_Content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:badges/badges.dart';
import 'package:collection/collection.dart';
import 'package:restorant_app/product.dart';
import 'package:get/get.dart';
import 'Menu_Content.dart';
import 'ItemContent.dart';
import 'ItemcontentModel.dart';

class MenuScreen extends StatefulWidget {
  String text;
  final int index;
  final int area_index;
  MenuScreen(this.index, this.area_index, this.text);
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<int> _counter = [];
  List<bool> isselected = [];
  ItemcontentModel itemModel = new ItemcontentModel();
  List<double> opacity = [];
  final List<Product> dt = Product.d1();
  final List<CartModel> cart = CartModel.d1();
  late int cindex;
  late int i;
  var result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
        title: RichText(
            text: TextSpan(
                text: 'Restaurant',
                style: kHeadingTextStyle.copyWith(
                  color: Colors.white60,
                ),
                children: [
              TextSpan(
                  text: ' Menu',
                  style: kHeadingTextStyle.copyWith(
                    color: Colors.white60,
                  )),
              widget.index > 0
                  ? TextSpan(
                      text:
                          ' Dine in - Area ${widget.area_index} - Table# ${widget.index + 1}',
                      style: TextStyle(fontSize: 30.sp, color: Colors.white54))
                  : TextSpan(
                      text: '  Take away - Ref#(${widget.text})',
                      style: TextStyle(fontSize: 30.sp, color: Colors.white54)),
            ])),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white60,
              )),
          Badge(
            position: BadgePosition.topEnd(top: 1, end: 25),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.scale,
            badgeContent: Text(
              _sum().toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
                onPressed: () {
                  _key.currentState!.openEndDrawer();
                },
                icon: Icon(
                  Icons.add_shopping_cart_sharp,
                  color: Colors.white60,
                )),
          ),
        ],
      ),
      endDrawer: drawer(context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                //padding: EdgeInsets.only(left: 10, top: 20),
                //color: Colors.blue[900],
                child: VerticalTabs(
                  //tabBackgroundColor: Colors.blueGrey,
                  tabsWidth: 180.w,
                  disabledChangePageFromContentView: true,
                  tabs: <Tab>[
                    Tab(
                        child: SizedBox(
                            height: 105.h,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.fastfood),
                                  Text('Fast Food'),
                                ],
                              ),
                            ))),
                    Tab(
                        child: SizedBox(
                            height: 124.h,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.emoji_food_beverage),
                                  Text('Beverages'),
                                ],
                              ),
                            ))),
                    Tab(
                        child: SizedBox(
                            height: 105.h,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.set_meal),
                                  Text(' Meal'),
                                ],
                              ),
                            ))),
                    Tab(
                        child: SizedBox(
                            height: 105.h,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.local_drink_sharp),
                                  Text('Drinks'),
                                ],
                              ),
                            ))),
                    Tab(
                        child: SizedBox(
                            height: 105.h,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.food_bank),
                                  Text('Food'),
                                ],
                              ),
                            ))),
                    Tab(
                        child: SizedBox(
                            height: 124.h,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.local_drink_sharp),
                                  Text('Beverages'),
                                ],
                              ),
                            ))),
                    Tab(
                        child: SizedBox(
                            height: 105.h,
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(Icons.emoji_food_beverage_outlined),
                                  Text('Coffee'),
                                ],
                              ),
                            ))),
                  ],
                  contents: <Widget>[
                    tabsContent(),
                    tabsContent(),
                    tabsContent(),
                    tabsContent(),
                    tabsContent(),
                    tabsContent(),
                    tabsContent(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getItemTotal(List<CartModel> items) {
    double sum = 0.0;
    items.forEach((e) {
      sum += (e.price * e.qty);
    });
    return sum;
  }

  getTotal(List<ItemContent> items) {
    double sum = 0.0;
    items.forEach((e) {
      sum += (e.price * e.qty);
    });
    double sumtotal = (getItemTotal(cart)) + (sum);
    return "${sumtotal}";
  }

  _sum() {
    var result = _counter.fold<int>(0, (prev, element) => prev + element);
    return result;
  }

  Widget tabsContent() {
    return Container(
      color: Colors.black12,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: double.infinity,
            maxWidth: 220.w,
          ),
          child: Container(
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 1.5,
                ),
                itemCount: dt.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildCard(index);
                }),
          )),
    );
  }

  _onTap(int index) async {
    if (cart.length > 0) {
      var last = cart.last.id;
      bool select = false;
      cart.forEach((element) async {
        if (element.id == dt[index].id) {
          element.qty++;
          select = true;
        } else if (last == element.id && !select) {
          cart.add(new CartModel(dt[index].image, dt[index].price,
              dt[index].name, dt[index].id, [], 1));
          if (index == 1) {
            itemModel = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MenuContent(cart, (cart.length - 1))));
            cart[itemModel.index].itemcontents = itemModel.itemModel;
            print(cart[index].id);
          }
        }
      });
    } else {
      cart.add(new CartModel(dt[index].image, dt[index].price, dt[index].name,
          dt[index].id, [], 1));

      if (index == 1) {
        itemModel = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MenuContent(cart, (cart.length - 1))));
        cart[itemModel.index].itemcontents = itemModel.itemModel;
        print(cart[index].id);
      }
    }
  }

  Widget buildCard(int index) {
    if (_counter.length < dt.length) {
      _counter.add(0);
    }
    if (isselected.length < dt.length) {
      isselected.add(false);
    }
    if (opacity.length < dt.length) {
      opacity.add(0.0);
    }

    return GestureDetector(
      onTap: () async {
        setState(() {
          // ignore: unrelated_type_equality_checks
          isselected[index] = true;
          opacity[index] = 0.6;
          _incrementCounterProduct(index);
          getTotal(itemModel.itemModel);
        });
        _onTap(index);
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
                width: MediaQuery.of(context).size.width / 0.5,
                height: MediaQuery.of(context).size.height / 3.9,
                margin: EdgeInsets.all(0),
                decoration: isselected[index]
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.blue.withOpacity(opacity[index]),
                              BlendMode.srcATop),
                          fit: BoxFit.fill,
                          alignment: Alignment(0, 0),
                          image: AssetImage(
                            dt[index].image,
                          ),
                        ),
                      )
                    : BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          alignment: Alignment(0, 0),
                          image: AssetImage(
                            dt[index].image,
                          ),
                        ),
                      )),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 100.h,
                      decoration: const BoxDecoration(
                        color: Colors.black45,
                      ),
                      child: Column(
                        children: [
                          Text(
                            dt[index].name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            dt[index].price.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: opacity[index] > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline_sharp),
                              onPressed: () {
                                setState(() {
                                  _decrementCounterProduct(index);
                                  print('inside decrement');
                                  if (_counter.elementAt(index) == 0) {
                                    opacity[index] = 0;
                                    isselected[index] == false;
                                    cart.removeWhere(
                                        (item) => item.name == dt[index].name);
                                    print('inside decrement1');
                                  } else {
                                    isselected[index] == true;
                                    print('inside decrement2');
                                  }
                                });
                              },
                              color: Colors.white,
                              iconSize: 55.sp,
                            ),
                            Chip(
                              padding: EdgeInsets.all(0),
                              backgroundColor: Colors.red,
                              label: Text(_ProductQty(index).toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ),
                          ],
                        )
                      : Row(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget drawer(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 680.w,
        child: Drawer(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.arrow_back_ios_sharp),
                onTap: () {
                  Navigator.pop(context);
                },
                trailing: RaisedButton(
                    onPressed: () {},
                    color: Colors.blue[900],
                    child: RichText(
                      text: TextSpan(
                        text: 'Items  ',
                        children: <TextSpan>[
                          TextSpan(
                              text: _sum().toString(),
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    )),
              ),
              Expanded(
                  child: Container(
                child: _counter.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.fromLTRB(5, 20, 0, 0),
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          i = index;
                          return Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100,
                                        width: 1.0),
                                    top: BorderSide(
                                        color: Colors.grey.shade100,
                                        width: 1.0),
                                  )),
                              height: 100.0,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5.0)
                                        ],
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0)),
                                        image: DecorationImage(
                                            image:
                                                AssetImage(cart[index].image),
                                            fit: BoxFit.fitHeight)),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 10.0, left: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          cart[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.0),
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text("Price ${cart[index].price}"),
                                        cart[index].itemcontents.length > 0
                                            ? Expanded(
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  itemCount: cart[i]
                                                      .itemcontents
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    cindex = index;
                                                    return Container(
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(cart[i]
                                                                .itemcontents[
                                                                    index]
                                                                .name),
                                                          ),
                                                          Expanded(
                                                            child: Text(cart[i]
                                                                .itemcontents[
                                                                    index]
                                                                .price
                                                                .toString()),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Column(),
                                      ],
                                    ),
                                  )),
                                  Container(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkResponse(
                                              onTap: () {
                                                setState(() {
                                                  _decrementCounterCart(index);
                                                });
                                              },
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                                size: 60.sp,
                                              )),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          Text(
                                            cart[index].qty.toString(),
                                            style: TextStyle(
                                                fontSize: 40.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          InkResponse(
                                              onTap: () {
                                                setState(() {
                                                  _incrementCounterCart(index);
                                                });
                                              },
                                              child: Icon(
                                                Icons.add_circle,
                                                color: Colors.blue[900],
                                                size: 60.sp,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                    : Container(
                        child: Center(
                            child: Text(
                          'No items found',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
                      ),
              )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                    height: 90.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey),
                      //borderRadius: BorderRadius.circular(120),
                    ),
                    // ignore: deprecated_member_use
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                                fontSize: 25.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            getTotal(itemModel.itemModel),
                            style: TextStyle(
                                fontSize: 35.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0XFFF0F0F0)),
                    borderRadius: BorderRadius.circular(120),
                  ),
                  // ignore: deprecated_member_use
                  child: MaterialButton(
                    onPressed: () {},
                    color: Colors.blue[900],
                    child: Center(
                      child: Text(
                        'Finish Order',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _incrementCounterProduct(int i) {
    _counter[i]++;
    dt[i].qty++;
  }

  _decrementCounterProduct(int i) {
    if (dt[i].qty <= 0 && _counter[i] <= 0) {
      dt[i].qty = 0;
      _counter[i] = 0;
    } else {
      _counter[i]--;
      dt[i].qty--;
      cart.forEach((element) {
        if (element.id == dt[i].id) {
          element.qty--;
        }
      });
      print(dt[i].qty);
    }
  }

  _incrementCounterCart(int i) {
    _counter[i]++;
    cart[i].qty++;
    dt.forEach((element) {
      if (element.id == cart[i].id) {
        dt[i].qty++;
      }
    });
    getItemTotal(cart);
    print(getItemTotal(cart));
  }

  _decrementCounterCart(int i) {
    if (cart[i].qty <= 1) {
      cart[i].qty = 1;
    } else {
      _counter[i]--;
      cart[i].qty--;
      dt.forEach((element) {
        if (element.id == cart[i].id) {
          dt[i].qty--;
        }
      });
      getItemTotal(cart);
      print(getItemTotal(cart));
    }
  }

  // ignore: non_constant_identifier_names
  _ProductQty(int i) {
    int q = 0;
    cart.forEach((element) {
      if (element.id == dt[i].id) {
        q = element.qty;
      }
    });
    return q;
  }
}
