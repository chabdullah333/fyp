import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:secondapp/Model/showattendancemodel.dart';
import 'package:http/http.dart' as http;
import 'testmark.dart';

class showattend extends StatefulWidget {
  const showattend({Key? key}) : super(key: key);

  @override
  _showattendState createState() => _showattendState();
}

class _showattendState extends State<showattend> {
  final String courseno = 'ENG-325';
  final String discipline = 'BCS';
  final String semc = '8';
  final String Section = 'B';
  final String empno = 'BIIT167';
  late List venue = [];
  Future<List<Showattendancemodel>> showkro() async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/getAttendanceList/sirajcode?CourseNumber=${courseno}&Discipline=${discipline}&SemC=${semc}&Section=${Section}&EmpNumber=${empno}'),
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
  // Future<List<Showattendancemodel>> showkro() async {
  //   final response = await http.get(
  //     Uri.parse(
  //         'http://${Url.ip}:5001/getAttendanceList/sirajcode?CourseNumber=${courseno}&Discipline=${discipline}&SemC=${semc}&Section=${Section}&EmpNumber=${empno}'),
  //   );
  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     return showkro();
  //   } else {
  //     throw Exception('Failed to load album');
  //   }
  // }

  late Future<List<Showattendancemodel>> data;
  @override
  void initState() {
    super.initState();
    data = showkro();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Attendance'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: FutureBuilder<List<Showattendancemodel>>(
                future: data,
                key: UniqueKey(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final List<String> statuses =
                            snapshot.data![index].attendanceStatuses.split("#");

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
                                  Text(snapshot.data![index].regNo +
                                      "\n" +
                                      snapshot.data![index].name),
                                  Text(statuses[0]),
                                  Text(statuses[1]),
                                  Text(statuses[2]),
                                  Text(statuses[3]),
                                  Text(statuses[4]),
                                  Text(statuses[5]),
                                  Text(statuses[6]),
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
            ),
          ],
        ),
      ),
    );
  }
}

// class show extends StatelessWidget {
//   const show({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Show Attendance',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.red,
//       ),
//       body: showattendance(),
//     );
//   }
// }
//
// class showattendance extends StatelessWidget {
//   const showattendance({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           DataTable(columns: [
//             DataColumn(
//               label: Text(
//                 'Reg No',
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//             DataColumn(
//               label: Text(
//                 'Name',
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//             DataColumn(
//               label: Text(
//                 'Attendance',
//                 style: TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           ], rows: [
//             DataRow(cells: [
//               DataCell(
//                 Text('18-arid-0100'),
//               ),
//               DataCell(
//                 Text('Abdullah'),
//               ),
//               DataCell(
//                 Text('50%'),
//               ),
//             ]),
//             DataRow(cells: [
//               DataCell(
//                 Text('18-arid-0129'),
//               ),
//               DataCell(
//                 Text('Zeeshan'),
//               ),
//               DataCell(
//                 Text('30%'),
//               ),
//             ]),
//             DataRow(cells: [
//               DataCell(
//                 Text('18-arid-0132'),
//               ),
//               DataCell(
//                 Text('waleed'),
//               ),
//               DataCell(
//                 Text('10%'),
//               ),
//             ]),
//             DataRow(cells: [
//               DataCell(
//                 Text('18-arid-0130'),
//               ),
//               DataCell(
//                 Text('salman'),
//               ),
//               DataCell(
//                 Text('05%'),
//               ),
//             ]),
//             DataRow(cells: [
//               DataCell(
//                 Text('18-arid-0172'),
//               ),
//               DataCell(
//                 Text('zain'),
//               ),
//               DataCell(
//                 Text('2%'),
//               ),
//             ]),
//             DataRow(cells: [
//               DataCell(
//                 Text('18-arid-0105'),
//               ),
//               DataCell(
//                 Text('arslan'),
//               ),
//               DataCell(
//                 Text('80%'),
//               ),
//             ]),
//           ]),
//         ],
//       ),
//     );
//   }
// }
