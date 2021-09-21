import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restorant_app/CartModel.dart';
import 'constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ex.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:vertical_tabs/vertical_tabs.dart';
import 'package:get/get.dart';
import 'ItemContent.dart';
import 'Menu_Screen.dart';
import 'product.dart';
import 'ItemcontentModel.dart';

class MenuContent extends StatefulWidget {
  List<CartModel> pdata = [];
  final int index;
  MenuContent(this.pdata, this.index);

  @override
  _MenuContentState createState() => _MenuContentState();
}

class ItemData extends GetxController {
  final List<ItemContent> dt = ItemContent.content();
}

class _MenuContentState extends State<MenuContent> {
  List<bool> _isSelected = [];
  List<ItemContent> Selected = [];
  ItemcontentModel model = new ItemcontentModel();
  ItemData dx = Get.put(ItemData());
  int _counter = 1;
  late int index1 = 1;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context, model);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white60,
                )),
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
                ])),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.white60,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_shopping_cart_sharp,
                    color: Colors.white60,
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 180,
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    reverse: false,
                    enlargeCenterPage: true,
                  ),
                  items: widget.pdata.map((image) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          // margin: EdgeInsets.symmetric(horizontal: 1.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage(widget.pdata[widget.index].image),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    //color: Colors.blue[900],
                    child: VerticalTabs(
                      //tabBackgroundColor: Colors.blueGrey,
                      tabsWidth: 80,
                      //tabBackgroundColor: Colors.blue[900],
                      //tabsShadowColor: Colors.blue[900],
                      //selectedTabBackgroundColor: Colors.grey,
                      //indicatorColor: Colors.blue[900],
                      backgroundColor: kShadowColor,
                      disabledChangePageFromContentView: true,
                      tabs: <Tab>[
                        Tab(
                            child: SizedBox(
                                height: 105.h,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(Icons.fastfood),
                                      Text('Item 1'),
                                    ],
                                  ),
                                ))),
                        Tab(
                            child: SizedBox(
                                height: 105.h,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(Icons.emoji_food_beverage),
                                      Text('Item 2'),
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
                                      Text('Item 3'),
                                    ],
                                  ),
                                ))),
                      ],
                      contents: <Widget>[
                        tabsContent(),
                        tabsContent(),
                        tabsContent(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkResponse(
                            onTap: () {
                              setState(() {
                                _decrementCounter(index1);
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
                          dx.dt[index1].qty.toString(),
                          style: TextStyle(
                              fontSize: 40.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        InkResponse(
                            onTap: () {
                              setState(() {
                                _incrementCounter(index1);
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0XFFF0F0F0)),
                      borderRadius: BorderRadius.circular(120),
                    ),
                    // ignore: deprecated_member_use
                    child: MaterialButton(
                      onPressed: () {
                        model.index = widget.index;
                        model.itemModel = Selected;
                        print("preesed//////////////////////////");
                        print(Selected.toString());
                        Navigator.pop(context, model);
                      },
                      color: Colors.blue[900],
                      child: Center(
                        child: Text(
                          'ADD TO CART',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget tabsContent() {
    return Container(
        //margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(8),
        color: Colors.black12,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              //maxHeight: double.infinity,
              maxWidth: 230.w,
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              // width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(20, 20),
                    bottom: Radius.elliptical(20, 20),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, 15.0),
                        blurRadius: 15.0),
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0.0, -10.0),
                        blurRadius: 10.0),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: new Text(widget.pdata[widget.index].name,
                          style: TextStyle(
                              fontSize: 45.sp,
                              fontFamily: "Poppins-Bold",
                              letterSpacing: .6)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Item name'),
                        Text(widget.pdata[widget.index].price.toString()),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('ADD OPTIONS'),
                    SizedBox(
                      height: 20.h,
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 15.h);
                          },
                          shrinkWrap: false,
                          itemCount: dx.dt.length,
                          itemBuilder: (context, index) {
                            index1 = index;
                            return buildItem(index);
                          }),
                    )
                  ],
                ),
              ),
            )));
  }

  Widget buildItem(int index) {
    ItemData dx = Get.put(ItemData());
    if (_isSelected.length < dx.dt.length) {
      _isSelected.add(false);
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected[index] = !_isSelected[index];
          if (_isSelected[index] == true) {
            Selected.add(dx.dt[index]);
          } else {}
          //print(Selected);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          radioButton(index),
          SizedBox(
            width: 20.w,
          ),
          Text(dx.dt[index].name),
          SizedBox(
            width: 90.w,
          ),
          Text(dx.dt[index].price.toString()),
        ],
      ),
    );
  }

  Widget radioButton(int index) => Container(
        width: 20.0,
        height: 20.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: _isSelected[index]
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.black),
              )
            : Container(),
      );

  _incrementCounter(int i) {
    dx.dt[i].qty++;
  }

  _decrementCounter(int i) {
    if (dx.dt[i].qty <= 1) {
      dx.dt[i].qty = 1;
    } else {
      dx.dt[i].qty--;
    }
  }
}
