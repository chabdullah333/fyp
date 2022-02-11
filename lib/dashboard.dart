import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:secondapp/classes.dart';
import 'package:secondapp/classesshowattendance.dart';
import 'package:secondapp/dropdowndatatesting.dart';
import 'package:secondapp/markattendance.dart';
import 'package:secondapp/showattendance.dart';

class dashbord extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String username;
  const dashbord(
      {Key? key,
      required this.firstname,
      required this.lastname,
      required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/backgroundimg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 64,
                child: Row(
                  children: [],
                ),
              ),
              Expanded(
                child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: [
                    Card(
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyApp(
                                      firstname: firstname,
                                      lastname: lastname,
                                      username: username),
                                ),
                              );
                            },
                            child: Image.asset(
                              'images/markattendance.png',
                              height: 128,
                            ),
                          ),
                          Text('Mark Attendance'),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => classesshowattendance(
                                          empname: username,
                                        )),
                              );
                            },
                            child: Image.asset(
                              'images/showattendance.png',
                              height: 128,
                            ),
                          ),
                          Text('Show Attendance'),
                        ],
                      ),
                    ),
                    Card(
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => test()),
                              // );
                            },
                            child: Image.asset(
                              'images/complain.png',
                              height: 128,
                            ),
                          ),
                          Text('Complain'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
