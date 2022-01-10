import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secondapp/Model/VerifyAtttendanceModel.dart';
import 'package:http/http.dart' as http;
import 'testmark.dart';

class VerifyAtt extends StatefulWidget {
  final String username;
  final String coursecode;
  final String section;
  final String discipline;
  const VerifyAtt(
      {Key? key,
      required this.username,
      required this.coursecode,
      required this.section,
      required this.discipline})
      : super(key: key);

  @override
  _VerifyAttState createState() => _VerifyAttState();
}

class _VerifyAttState extends State<VerifyAtt> {
  Future<List<VerifyAtttendanceModel>> veriiifyatten() async {
    final response = await http.get(
      Uri.parse(
        'http://${Url.ip}:5001/VerifyAttendance/GetStudent?username=${widget.username}&courseno=${widget.coursecode}&section=${widget.section}&discipline=${widget.discipline}',
      ),
    );
    if (response.statusCode == 200) {
      print(widget.username);
      print(widget.coursecode);
      print(widget.section);
      print(widget.discipline);

      List<VerifyAtttendanceModel> paresd =
          verifyAtttendanceModelFromJson(response.body);
      // print(response.body);
      print(paresd);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<VerifyAtttendanceModel>> data;
  @override
  void initState() {
    super.initState();
    data = veriiifyatten();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Verify Attendance"),
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
                child: FutureBuilder<List<VerifyAtttendanceModel>>(
                  future: data,
                  key: UniqueKey(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Card(
                                    color: Colors.grey,
                                    margin: EdgeInsets.all(5),
                                    child: Container(
                                      height: 80,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.person_outlined,
                                            size: 50,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: 80,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  snapshot.data![index].id,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![index].fullName,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 32,
                                            width: 130,
                                            child: Column(
                                              children: [
                                                Text(snapshot
                                                        .data![index].present
                                                        .toString() +
                                                    ("/") +
                                                    snapshot.data![index].total
                                                        .toString()),
                                                Text(snapshot
                                                        .data![index].percent
                                                        .toString() +
                                                    ('%')),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Container(
                                            width: 40,
                                            height: 50,
                                            color: Colors.greenAccent,
                                            child: Center(
                                              child: Text(
                                                  snapshot.data![index].status),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
        // Padding(
        //   padding: EdgeInsets.all(10),
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         Card(
        //           color: Colors.redAccent,
        //           margin: EdgeInsets.all(5),
        //           child: Container(
        //             height: 80,
        //             child: Row(
        //               children: [
        //                 Icon(
        //                   Icons.person_outlined,
        //                   size: 50,
        //                   color: Colors.white,
        //                 ),
        //                 SizedBox(
        //                   height: 32,
        //                   width: 90,
        //                   child: Column(
        //                     children: [
        //                       Text("18-ARID-0159"),
        //                       Text("Siraj Ali"),
        //                     ],
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 32,
        //                   width: 40,
        //                   child: Column(
        //                     children: [
        //                       Text("9/18"),
        //                       Text("50%"),
        //                     ],
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   width: 20,
        //                 ),
        //                 Container(
        //                   width: 40,
        //                   height: 50,
        //                   color: Colors.greenAccent,
        //                   child: Center(child: Text("P")),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
