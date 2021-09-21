import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constant.dart';
import 'Tables_Page.dart';
import 'Menu_Screen.dart';
import 'ItemContent.dart';
import 'ItemcontentModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //static final now = TimeOfDay.now();
  int checkedIndex = 0;
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
  TextEditingController text = TextEditingController();
  final GlobalKey<FormState> passKey = GlobalKey<FormState>();
  List<String> abc = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                    text: ' Home page',
                    style: kHeadingTextStyle.copyWith(
                      color: Colors.white60,
                    )),
              ])),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_sharp),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Dine in'),
              Tab(
                text: 'Take Away',
              ),
              Tab(
                text: 'Delivery',
              ),
            ],
          ),
        ),
        endDrawer: drawer(context),
        body: TabBarView(children: [
          ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return field(
                  color: Colors.white60,
                  colmnchld: RaisedButton(
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TablesScreen(index)));
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Text(
                              'Area ${index + 1}',
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.blue[900],
                        ),
                      ],
                    ),
                  ),
                );
              }),
          Form(
            key: passKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    //height: 100,
                    child: TextFormField(
                      controller: text,
                      decoration: InputDecoration(
                        hintText: 'Enter a Reference Number',
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 20.sp),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter any reference number';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        text.text = value!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.all(12),
                        color: Colors.blue[900],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MenuScreen(0, 0, text.text)));
                        },
                        child: Text('Skip',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.all(12),
                        color: Colors.blue[900],
                        onPressed: () {
                          try {
                            if (passKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuScreen(
                                          checkedIndex, 0, text.text)));
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('Submit',
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
              child: Text(
            'No Order',
            style: TextStyle(fontSize: 40.sp),
          )),
        ]),
      ),
    );
  }

/*
  Widget buildCard(int index) {
    bool checked = index == checkedIndex;
    bool selected = index == checkedIndex;

    int name = colors[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          checkedIndex = index;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TablesScreen()));
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
                            '   Table $index',
                            style: kTitleTextstyle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('NO Order',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.sp,
                                  fontFamily: "Poppins",
                                  letterSpacing: .6)),
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
*/
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

class PlayerPreferences extends StatefulWidget {
  //final int numPlayers;
  //PlayerPreferences({required this.numPlayers});

  @override
  _PlayerPreferencesState createState() => _PlayerPreferencesState();
}

class _PlayerPreferencesState extends State<PlayerPreferences> {
  int dropDownValue = 0;
  List<String> location = ['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              DropdownButton<String>(
                hint: Text('Select an Area'),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownValue = newValue! as int;
                  });
                },
                items: location.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class field extends StatelessWidget {
  field({required this.colmnchld, required this.color});
  final Widget colmnchld;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: color,
          // border: Border.all(color: Color(0)),
          borderRadius: BorderRadius.circular(80),
        ),
        child: colmnchld,
      ),
    );
  }
}
