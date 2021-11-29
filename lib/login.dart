import 'package:flutter/material.dart';
import 'package:secondapp/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String username, password;
  late bool error, sending, success;
  late String msg;
  late String role;
  String url = "http://192.168.43.166:5000/testingtesting";
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
  }

  Future<void> verifylogin() async {
    var res = await http.post(Uri.parse(url), body: {
      'username': usernameController.text,
      'password': passwordController.text,
      //'Role': roleController.text,
    });
    if (res.statusCode == 200) {
      print(res.body);
      var data = json.decode(res.body);
      print(data);
      if (data != null) {
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => dashbord()));
        });
      }
      if (data["error"]) {
        setState(() {
          sending = false;
          error = true;
          msg = data["message"];
        });
      } else {
        usernameController.text = '';
        passwordController.text = '';
        setState(() {
          sending = false;
          success = true;
        });
      }
    } else {
      setState(() {
        error = true;
        msg = "Error during sending data";
        sending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Image.asset('images/login.png'),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: usernameController,
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
              controller: passwordController,
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
                  child: ElevatedButton(
                    onPressed: () {
                      // verifylogin();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => dashbord()),
                      );

                      //setState(() {});
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
    );
  }
}
