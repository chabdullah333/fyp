import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 58.0),
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset('images/loginimg.jpeg'),
                  Text(
                    'Welcome to login',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decorationColor: Colors.white,
                  ),
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decorationColor: Colors.white,
                  ),
                  filled: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  ButtonTheme(
                    height: 40,
                    disabledColor: Colors.blue,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          Text('login successfully');
                        });
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
