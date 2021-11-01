import 'package:flutter/material.dart';
import 'package:secondapp/login.dart';
import 'package:secondapp/login.dart';

void main() {
  runApp(loginpage());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          title: Text('hey'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 100.0,
                color: Colors.white,
                child: Text('Container 1'),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                height: 200.0,
                color: Colors.cyan,
                child: Text('Container 2'),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                height: 100.0,
                color: Colors.amber,
                child: Text('Container 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
