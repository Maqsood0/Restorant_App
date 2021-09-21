import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class field extends StatelessWidget {
  field(this.TableText, this.orderText, this.color);

  int checkedIndex = 0;
  bool checked = false;
  bool selected = false;
  final String TableText;
  final String orderText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
              color: color,
              shape: selected
                  ? new RoundedRectangleBorder(
                      side: new BorderSide(color: kFaceBookColor, width: 1.5),
                      borderRadius: BorderRadius.circular(12))
                  : new RoundedRectangleBorder(
                      side: new BorderSide(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(12)),
              borderOnForeground: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        TableText,
                        style: kTitleTextstyle,
                      ),
                      Text(''),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(orderText,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.sp,
                            fontFamily: "Poppins",
                            letterSpacing: .6)),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
