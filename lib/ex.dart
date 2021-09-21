import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: DropDownMultiSelect(
              onChanged: (List<String> x) {
                setState(() {
                  selected = x;
                  print(selected);
                });
              },
              options: [
                'Extra cheese                                Rs 10',
                'Extra Honey                                 Rs 10',
                'Extra cheese                                Rs 10',
                'Extra Sugar                                 Rs 1o',
              ],
              selectedValues: selected,
              whenEmpty: 'Select Something',
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
                print('inside cart');
                selected = [''];
              },
              color: Colors.blue[900],
              child: Center(
                child: Text(
                  'ADD TO CART',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
