import 'package:flutter/cupertino.dart';
import 'package:restorant_app/Menu_Screen.dart';
import 'package:restorant_app/Register_Screen.dart';
import 'my_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restorant_app/Database/Loginpage_checker.dart';
import 'package:restorant_app/Database/User.dart';
import 'HomePage.dart';
import 'Tables_Page.dart';

// ignore: camel_case_types
class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

// ignore: camel_case_types
class _loginScreenState extends State<loginScreen>
    implements LoginPageContract {
  bool passwordInvisible = true;
  final controller = ScrollController();
  double offset = 0;
  bool _isSelected = false;
  bool _isLoading = false;
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> passKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  late LoginPageChecker _presenter;
  _loginScreenState() {
    _presenter = new LoginPageChecker(this);
  }
  void _showSnackBar(String text) {
    scaffoldKey.currentState!.showSnackBar(new SnackBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
      content: new Text(text),
    ));
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
      key: scaffoldKey,
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
                        key: passKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Login",
                                style: TextStyle(
                                    fontSize: 45.sp,
                                    fontFamily: "Poppins-Bold",
                                    letterSpacing: .6)),
                            SizedBox(
                              height: 30.w,
                            ),
                            Text("Email",
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 26.sp)),
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                  hintText: "eg: abc@gmail.com",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return 'Please a valid Email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30.w,
                            ),
                            Text("PassWord",
                                style: TextStyle(
                                    fontFamily: "Poppins", fontSize: 26.sp)),
                            TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      Text(password.text);
                                    },
                                    icon: Icon(
                                      passwordInvisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "**********",
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter your password';
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
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 8.w,
                          ),
                          GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text("Remember me",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: "Poppins-Medium"))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          onPressed: () {
                            if (passKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                                passKey.currentState!.save();
                                User user =
                                    new User(null, email.text, password.text);
                                _presenter.doLogin(user);
                              });
                            }
                          },
                          padding: EdgeInsets.all(12),
                          color: Colors.blue[900],
                          child: Text('Log In',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "New User? ",
                        style: TextStyle(
                            fontFamily: "Poppins-Medium", fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Text("SignUp",
                            style: TextStyle(
                                color: Color(0xff5d74e3),
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

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  void onLoginSuccess(user) async {
    if (user == null) {
      _showSnackBar('Incorrect Detail !!');
      _showSnackBar('Please enter your Email and Password again');
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
    //_showSnackBar('Not successful');
  }
}
