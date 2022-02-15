import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/showattendancedropdownmodel.dart';
import 'Model/showattendancemodel.dart';
import 'testmark.dart';

class test extends StatefulWidget {
  final String empname;
  final String courseno;
  final String discipline;
  final String section;
  final String semesterno;
  const test(
      {Key? key,
      required this.empname,
      required this.courseno,
      required this.discipline,
      required this.section,
      required this.semesterno})
      : super(key: key);

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  late int pagelenght = 3;
  late int divisor = 7;
  // final String courseno = 'ENG-325';
  // final String discipline = 'BCS';
  // final String semc = '8';
  // final String Section = 'B';
  // final String empno = 'BIIT167';
  late List venue = [];
  Showattendancedropdownmodel dummy = new Showattendancedropdownmodel(
    coursename: 'abc',
    section: 'ABC',
    semc: 0,
    discipline: 'ABC',
    courseno: 'ABC',
  );
  String selecteditems = 'abc';
  List<Showattendancedropdownmodel> obj = [];
  // Future<List<Showattendancedropdownmodel>> showDropDown() async {
  //   final response = await http.get(
  //     Uri.parse(
  //         'http://${Url.ip}:5001/showattendancedropdown?EmpNumber=BIIT167'),
  //   );
  //   if (response.statusCode == 200) {
  //     List<Showattendancedropdownmodel> paresd =
  //         showattendancedropdownmodelFromJson(response.body);
  //     obj.addAll(paresd);
  //     obj.add(dummy);
  //     print(obj.length);
  //     print('coursename:' + obj.elementAt(obj.length - 1).coursename);
  //     print(paresd.length);
  //     return paresd;
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  Future<List<Showattendancemodel>> showkro() async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/showattendance/pageview/apnacode?CourseNumber=${widget.courseno}&Discipline=${widget.discipline}&SemC=${widget.semesterno}&Section=${widget.section}&EmpNumber=${widget.empname}'),
    );
    if (response.statusCode == 200) {
      List<Showattendancemodel> paresd =
          showattendancemodelFromJson(response.body);
      print(paresd);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  //late Future<List<Showattendancemodel>> data;
  @override
  void initState() {
    super.initState();
    //data = showkro();
    // setState(() {
    //   showDropDown();
    // });
  }
  // print("page length before s : " + pagelenght.toString());
  // int s = pagelenght;
  // print("printing s : " + s.toString());
  // pagelenght = (s / 7).toInt();
  //
  // int reminder = (s % 7);
  // print('remainder : ' + reminder.toString());
  //
  // // (reminder > 0) ? pagelenght += 1 : pagelenght = 1;
  // if (reminder > 0) {
  //   pagelenght += 1;
  //
  //   print('remainder page length : ' + pagelenght.toString());
  // }
  // print("Total Pages Show Attendance : " + pagelenght.toString());

  @override
  Widget build(BuildContext context) {
    print("page length before s : " + pagelenght.toString());
    int s = pagelenght;
    print("printing s : " + s.toString());
    pagelenght = (s / 7).toInt();

    int reminder = (s % 7);
    print('remainder : ' + reminder.toString());

    // (reminder > 0) ? pagelenght += 1 : pagelenght = 1;
    if (reminder > 0) {
      pagelenght += 1;

      print('remainder page length : ' + pagelenght.toString());
    }
    print("Total Pages Show Attendance : " + pagelenght.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('Show Attendance'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (reminder > 0) ? pagelenght += 1 : pagelenght = 0,
          itemBuilder: (_, indexPage) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<List<Showattendancemodel>>(
                    future: showkro(),
                    key: UniqueKey(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final List<String> statuses = snapshot
                                .data![index].attendanceStatuses
                                .split("#");

                            // pagelenght = (statuses.length / 7).toInt();
                            //
                            // int reminder = (statuses.length % 7);
                            //
                            // if (reminder > 0) {
                            //   pagelenght += 1;
                            // }
                            // print("Total Pages Show Attendance : " +
                            //     pagelenght.toString());

                            int startIndex = 7 * indexPage;
                            // venue = snapshot.data![0].attendanceStatuses;
                            return Container(
                              child: SingleChildScrollView(
                                child: Table(
                                  border: TableBorder
                                      .all(), // Allows to add a border decoration around your table
                                  columnWidths: {
                                    0: FixedColumnWidth(25.0),
                                    1: FixedColumnWidth(140.0),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Text(snapshot.data![index].ind),
                                      Text(
                                        snapshot.data![index].regNo +
                                            "\n" +
                                            snapshot.data![index].name,
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                      (startIndex + 0 < statuses.length)
                                          ? Center(
                                              child: Text(
                                                statuses[0 + startIndex],
                                                // style: TextStyle(
                                                //     color: (statuses == "P")
                                                //         ? Colors.green
                                                //         : Colors.red),
                                              ),
                                            )
                                          : Text(""),
                                      (startIndex + 1 < statuses.length)
                                          ? Center(
                                              child: Text(
                                                  statuses[1 + startIndex]))
                                          : Text(""),
                                      (startIndex + 2 < statuses.length)
                                          ? Center(
                                              child: Text(
                                                  statuses[2 + startIndex]))
                                          : Text(""),
                                      (startIndex + 3 < statuses.length)
                                          ? Center(
                                              child: Text(
                                                  statuses[3 + startIndex]))
                                          : Text(""),
                                      (startIndex + 4 < statuses.length)
                                          ? Center(
                                              child: Text(
                                                  statuses[4 + startIndex]))
                                          : Text(""),
                                      (startIndex + 5 < statuses.length)
                                          ? Center(
                                              child: Text(
                                                  statuses[5 + startIndex]))
                                          : Text(""),
                                      (startIndex + 6 < statuses.length)
                                          ? Center(
                                              child: Text(
                                                  statuses[6 + startIndex]))
                                          : Text(""),
                                    ]),
                                  ],
                                ),
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
                ],
              ),
            );
          }),
    );
  }
}
