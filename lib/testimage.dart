import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/Model/onclickmarkresponsemodel.dart';
import 'testmark.dart';

class testimg extends StatefulWidget {
  final List<Onclickmarkresponsemodel> verify;
  final List<String> regno;
  final List<String> status;
  const testimg(
      {Key? key,
      required this.verify,
      required this.regno,
      required this.status})
      : super(key: key);

  @override
  _testimg createState() => _testimg();
}

class _testimg extends State<testimg> {
  String url = "http://${Url.ip}:5001/saveattendancelistinDB";
  // late Map<String, String> data;
  // final Map<String, dynamic> data = new Map<String, dynamic>();
  // // late Future<List<VerifyAtttendanceModel>> data;
  // verifyattendance() async {
  //   // final uri = url;
  //
  //   for (int i = 0; i < regnumber.length; i++) {
  //     data.addAll({
  //       data["regno[$i]"]: regnumber[i].toString(),
  //     });
  //   }
  //   for (int i = 0; i < statuscode.length; i++) {
  //     data.addAll({
  //       data["regno[$i]"]: statuscode[i].toString(),
  //     });
  //   }
  //
  //   http.Response response = await http.post(
  //     Uri.parse(url),
  //     body: data,
  //   );
  //   if (response.statusCode == 200) {
  //     print("ho gya");
  //   } else {
  //     print("nhi huwa");
  //   }
  // }
  Future<List<Onclickmarkresponsemodel>> verifyattendance() async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/saveattendancelistinDB?regno=${widget.regno}&status=${widget.status}'),
    );
    if (response.statusCode == 200) {
      List<Onclickmarkresponsemodel> paresd =
          onclickmarkresponsemodelFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }
  // Future<void> verifyattendance() async {
  //   print(regnumber);
  //   print(statuscode);
  //   var res = await http.post(
  //     Uri.parse(url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; crset=UTF-8',
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       "regno": regnumber,
  //       "status": statuscode,
  //     }),
  //   );
  // }

  @override
  void initState() {
    super.initState();
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
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.verify.length,
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
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: 80,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            widget.verify[index].regNo
                                                .toString(),
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          Text(
                                            widget.verify[index].name,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32,
                                      width: 130,
                                      child: Column(
                                        children: [
                                          Text(widget
                                                  .verify[index].presentAttend
                                                  .toString() +
                                              ("/") +
                                              widget.verify[index].totalAttend
                                                  .toString()),
                                          Text(widget
                                                  .verify[index].totalpercentage
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
                                        child: Text(widget
                                            .verify[index].attendStatus
                                            .toString()),
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
                ),
              ),
              Container(
                child: ButtonTheme(
                  height: 40,
                  disabledColor: Colors.blue,
                  child: ElevatedButton(
                    onPressed: () {
                      verifyattendance();
                    },
                    child: Text(
                      'Verify Attendance',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
