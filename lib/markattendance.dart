import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:secondapp/test.dart';
import 'package:secondapp/testmark.dart';
import 'package:secondapp/verifyattendance.dart';

import 'Model/MarkAtttendanceModel.dart';

class MyApp extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String username;

  const MyApp({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.username,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<MarkAtttendanceModel> locations = [];
  String selecteditems = "1";

  Future<List<MarkAtttendanceModel>> fetchDrop() async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}:5001/TEnrolledcourses/markattendance?EmpNumber=${widget.username}'));
    if (response.statusCode == 200) {
      List<MarkAtttendanceModel> Locations =
          markAtttendanceModelFromJson(response.body);
      print(response.body);
      setState(() {
        locations.addAll(Locations);
      });
      print(locations.elementAt(1));
      return locations;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<MarkAtttendanceModel>> dropdownid(String id) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}:5001/TEnrolledcourses/markattendance/dropdownid?id=${id}'));
    if (response.statusCode == 200) {
      List<MarkAtttendanceModel> paresd =
          markAtttendanceModelFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDrop();
  }

  String id = "";
  String courseno = "";
  String sect = "";
  String discip = "";

  @override
  Widget build(BuildContext context) {
    if (widget.username == 'BIIT190') {
      selecteditems = '1';
    }
    if (widget.username == 'BIIT167') {
      selecteditems = '16';
    }
    if (widget.username == 'BIIT346') {
      selecteditems = '8';
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mark Attendance'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            width: 350,
            child: DropdownButton(
              autofocus: true,
              // hint: Text(
              //   'Organizations',
              //   style: TextStyle(
              //     fontWeight: FontWeight.w900,
              //     fontSize: 35,
              //     color: Colors.teal,
              //   ),
              // ),
              value: selecteditems.toString(),
              onChanged: (String? newValue) {
                setState(
                  () {
                    selecteditems = newValue!;
                    id = selecteditems;
                  },
                );
              },
              items: locations.map((item) {
                return DropdownMenuItem(
                  child: Text(
                    item.discipline +
                        item.semC.toString() +
                        item.section +
                        "(" +
                        item.day +
                        item.slotStart.toString() +
                        "-" +
                        item.slotEnd.toString() +
                        ")",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  value: item.id.toString(),
                );
              }).toList(),
              dropdownColor: Colors.white,
            ),
          ),
          Row(
            children: [
              Container(
                height: 210,
                width: 135,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Teacher',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Class',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Subject',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Day',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 210,
                width: 225,
                // color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        widget.firstname + " " + widget.lastname,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      child: FutureBuilder<List<MarkAtttendanceModel>>(
                        future: dropdownid(id),
                        key: UniqueKey(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  courseno = snapshot.data![index].code;
                                  sect = snapshot.data![index].section;
                                  discip = snapshot.data![index].discipline;
                                  return Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: Text(
                                            discip +
                                                "-" +
                                                snapshot.data![index].semC
                                                    .toString() +
                                                sect,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Text(
                                            snapshot.data![index].title +
                                                ("(") +
                                                courseno +
                                                (")"),
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Text(
                                            snapshot.data![index].day,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Card(
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Image.asset(
                        'images/camera.png',
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    //Text('Take Picture'),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Card(
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Image.asset(
                        'images/gallery.png',
                        height: 130,
                      ),
                    ),
                    //Text('choose from gallery'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 50,
                ),
                color: Colors.red,
                onPressed: () {},
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                icon: const Icon(
                  Icons.image,
                  size: 50,
                ),
                color: Colors.red,
                onPressed: () {},
              ),
              SizedBox(
                width: 75,
              ),
              IconButton(
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 50,
                ),
                color: Colors.red,
                onPressed: () {},
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                icon: const Icon(
                  Icons.image,
                  size: 50,
                ),
                color: Colors.red,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyAtt(
                    username: widget.username,
                    coursecode: courseno,
                    section: sect,
                    discipline: discip,
                  ),
                ),
              );
            },
            child: Container(
              child: Text(
                'Mark Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              width: 150,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
