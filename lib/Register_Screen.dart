import 'package:flutter/cupertino.dart';
import 'my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_screen.dart';
import 'package:restorant_app/Database/Database_helper.dart';
import 'package:restorant_app/Database/User.dart';
import 'synchronize.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final controller = ScrollController();
  double offset = 0;
  bool passwordInvisible = true;
  final formKey = new GlobalKey<FormState>();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  Future syncdatatosql() async {
    await SyncronizationData().fetchAllInfo().then((user) {
      SyncronizationData().saveToMysqlWith(user);
      print(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(750, 1334),
        orientation: Orientation.portrait);
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader('images/barbecue.svg', 'Order And', ' Take Away', offset),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
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
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Register",
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: 15.w,
                            ),
                            Text("Username",
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 26.sp)),
                            TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                  hintText: "eg: maqsood",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.w,
                            ),
                            Text("Email Address",
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 26.sp)),
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                  hintText: "eg: abc@gmail.com",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15.w,
                            ),
                            Text("PassWord",
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 26.sp)),
                            TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      passwordInvisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "**********",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 35.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          onPressed: () async {
                            //final form = formKey.currentState;
                            if (formKey.currentState!.validate()) {
                              print('Successful');
                              var user = new User(
                                name.text,
                                email.text,
                                password.text,
                              );
                              var db = new DatabaseHelper();
                              db.saveUser(user);
                              await SyncronizationData.isInternet()
                                  .then((connection) {
                                if (connection) {
                                  print('Inside connection');
                                  syncdatatosql();
                                  print("Internet connection available");
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("No Internet")));
                                }
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginScreen()));
                            }
                          },
                          padding: EdgeInsets.all(12),
                          color: Colors.blue[900],
                          child: Text('Sign up',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an account? ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => loginScreen()));
                        },
                        child: Text("Log In",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 120.w,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  void initState() {
    super.initState();
    controller.addListener(onScroll);
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }
}
