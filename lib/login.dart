import 'package:flutter/material.dart';
import 'package:secondapp/Model/EMPTR.dart';
import 'package:secondapp/courses.dart';
import 'package:secondapp/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:secondapp/testmark.dart';

// class org {
//   bool status;
//   org({
//     required this.status,
//   });
//   factory org.fromJson(Map<String, dynamic> parsedJson) {
//     return org(
//       status: parsedJson['status'],
//     );
//   }
// }

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool error, sending, success;
  late String msg;
  late String role;
  String url = "http://${Url.ip}:5001/Login";
  @override
  void initState() {
    error = false;
    sending = false;
    success = false;
    super.initState();
  }

  late String uname;
  Future<void> verifylogin() async {
    var res = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );
    if (res.statusCode == 200) {
      uname = usernameController.text;
      print(res.body);
      Emptr data = emptrFromJson(res.body);
      print(data);
      // print(data['username'].toString());
      // int status = data['status'];
      //print(userrname);
      // final payload = {
      //   data: ['status'].toString()
      // };
      //print(payload);
      // String type;
      // type = data.type;
      if (data.type == 'T') {
        setState(
          () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => dashbord()));
          },
        );
      }
      if (data.type == 'S') {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => coursebody(username: uname)));
        });
      }

      // if (data["error"]) {
      //   setState(() {
      //     sending = false;
      //     error = true;
      //     msg = data["message"];
      //   });
      // } else {
      //   usernameController.text = '';
      //   passwordController.text = '';
      //   setState(() {
      //     sending = false;
      //     success = true;
      //   });
      // }
    } else {
      showAlertDialog(context);
    }
    // if (res.statusCode == 103) {
    //   setState(() {
    //     error = true;
    //     msg = "Error during sending data";
    //     sending = false;
    //   });
    // }
    // else {
    //   setState(() {
    //     error = true;
    //     msg = "Error during sending data";
    //     sending = false;
    //   });
    // }
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
                      verifylogin();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => dashbord()),
                      // );

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

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Widget continueButton = TextButton(
  //   child: Text("Continue"),
  //   onPressed: () {},
  // );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Invalid Login"),
    content: Text("Please enter valid username and password"),
    actions: [
      cancelButton,
      // continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
