import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupCard extends StatelessWidget {
  bool passwordInvisible = true;
  //String _name, _email, _password;

  @override
  Widget build(BuildContext context) {
    return new Container(
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
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Form(
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
                  style: TextStyle(fontFamily: "Poppins", fontSize: 26.sp)),
              TextField(
                decoration: InputDecoration(
                    hintText: "eg: maqsood",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: 15.w,
              ),
              Text("Email Address",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 26.sp)),
              TextField(
                decoration: InputDecoration(
                    hintText: "eg: abc@gmail.com",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: 15.w,
              ),
              Text("PassWord",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 26.sp)),
              TextFormField(
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
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ),
              SizedBox(
                height: 35.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
