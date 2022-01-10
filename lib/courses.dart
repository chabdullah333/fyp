import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secondapp/Model/EMPTR.dart';
import 'package:secondapp/Model/Stenrollcources.dart';
import 'package:secondapp/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/stdcrsattendance.dart';
import 'package:secondapp/testmark.dart';

// class courses extends StatelessWidget {
//   final String username;
//   const courses( {Key? key, required this.username}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Courses",
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.red,
//       ),
//       body: coursebody(username: '',),
//     );
//   }
// }

class coursebody extends StatefulWidget {
  final String username;
  const coursebody({Key? key, required this.username}) : super(key: key);

  @override
  _coursebodyState createState() => _coursebodyState();
}

class _coursebodyState extends State<coursebody> {
  Future<List<Stenrollcources>> fetchServices() async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/SEnrolledcourses/coursepercentage?username=${widget.username}'),
    );
    if (response.statusCode == 200) {
      List<Stenrollcources> paresd = stenrollcourcesFromJson(response.body);
      ;
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late String Coursecode;
  late String Coursetitle;
  late Future<List<Stenrollcources>> data;
  @override
  void initState() {
    super.initState();
    data = fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Courses",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: FutureBuilder<List<Stenrollcources>>(
              future: data,
              key: UniqueKey(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 350,
                        height: 80,
                        child: ListView(
                          children: [
                            ListTile(
                              leading: Image(
                                image: AssetImage('images/book (1).png'),
                              ),
                              title: Text(
                                snapshot.data![index].code +
                                    ("           ") +
                                    snapshot.data![index].percent.toString() +
                                    ("%"),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(snapshot.data![index].title),
                              onTap: () {
                                Coursecode = snapshot.data![index].code;
                                Coursetitle = snapshot.data![index].title;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => courseattendance(
                                            username: widget.username,
                                            coursecode: Coursecode,
                                            coursetitle: Coursetitle)));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      )),
    );
  }
}
