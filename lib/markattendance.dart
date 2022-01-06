import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:secondapp/test.dart';
import 'package:secondapp/testmark.dart';

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
  String selecteditems = "16";
  Future<List<MarkAtttendanceModel>> fetchDrop() async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}:5001/getCurrentClass?EmpNumber=${widget.username}'));
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

  @override
  void initState() {
    super.initState();
    fetchDrop();
  }

  @override
  Widget build(BuildContext context) {
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
                height: 40,
                child: Text(
                  'Teacher',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
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
            ],
          ),
          Row(
            children: [
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
              SizedBox(
                width: 78,
              ),
              Container(
                height: 40,
                child: Text(
                  "bcs-8B",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
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
              SizedBox(
                width: 56,
              ),
              Container(
                height: 40,
                child: Text(
                  'SP',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
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
              SizedBox(
                width: 98,
              ),
              Container(
                height: 40,
                child: Text(
                  'Monday',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
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
              SizedBox(
                width: 88,
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
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: Container(
                  child: Text(
                    'Camera',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  width: 80,
                  height: 30,
                ),
              ),
              // SizedBox(
              //   width: 80,
              // ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Multiimage()),
                  );
                },
                child: Container(
                  child: Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  width: 80,
                  height: 30,
                ),
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
            onPressed: () {},
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
