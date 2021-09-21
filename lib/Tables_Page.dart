import 'dart:core';
import 'package:flutter/material.dart';
import 'package:restorant_app/HomePage.dart';
import 'package:restorant_app/ItemcontentModel.dart';
import 'constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Menu_Screen.dart';
import 'ItemcontentModel.dart';

class TablesScreen extends StatefulWidget {
  final int index;
  TablesScreen(this.index);

  @override
  _TablesScreenState createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  int checkedIndex = 0;
  late int area_index;
  final String a = '';

  List<dynamic> itemm = [];
  List colors = [
    Colors.blue[900],
    Colors.blue[900],
    Colors.blue[900],
    Colors.blue[900],
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.orange,
    Colors.orange,
    Colors.orange,
    Colors.orange,
    Colors.brown,
    Colors.brown,
    Colors.brown,
    Colors.brown,
  ];
  List<String> abc = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: RichText(
              text: TextSpan(
                  text: 'Restaurant',
                  style: kHeadingTextStyle.copyWith(
                    color: Colors.white60,
                  ),
                  children: [
                TextSpan(
                    text: ' Menu page',
                    style: kHeadingTextStyle.copyWith(
                      color: Colors.white60,
                    )),
                TextSpan(
                    text: '  Dine in - Area ${widget.index + 1}',
                    style: TextStyle(fontSize: 30.sp, color: Colors.white54))
              ])),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_sharp),
          ),
        ),
        endDrawer: drawer(context),
        body: Container(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: double.infinity,
                  //maxWidth: 230,
                ),
                child: Container(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: 16,
                      itemBuilder: (BuildContext context, int index) {
                        return buildCard(index);
                      }),
                ))));
  }

  Widget buildCard(int index) {
    bool checked = index == checkedIndex;
    bool selected = index == checkedIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          checkedIndex = index;
          print(area_index = widget.index + 1);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MenuScreen(index, area_index = widget.index + 1, a)));
        });
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
                color: checked ? Colors.white : colors[index],
                shape: selected
                    ? new RoundedRectangleBorder(
                        side: new BorderSide(color: kFaceBookColor, width: 1.5),
                        borderRadius: BorderRadius.circular(15))
                    : new RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(15)),
                //borderOnForeground: true,

                
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '   Table ${index + 1}',
                            style: kTitleTextstyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text('NO Order',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.sp,
                                    fontFamily: "Poppins",
                                    letterSpacing: .6)),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget drawer(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1E4E98),
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('images/burger.jpg'),
                  ),
                  Text('User Name'),
                ],
              )),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: const Text('Dark Theme'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
            ListTile(
              title: Center(child: Text('App version 1.1.1')),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
