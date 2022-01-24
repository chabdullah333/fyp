import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/Model/onclickmarkresponsemodel.dart';
import 'testmark.dart';

class testimg extends StatefulWidget {
  final List<Onclickmarkresponsemodel> verify;
  const testimg({Key? key, required this.verify}) : super(key: key);

  @override
  _testimg createState() => _testimg();
}

class _testimg extends State<testimg> {
  // late List<Onclickmarkresponsemodel> abc = widget.verify;

  // late Future<List<VerifyAtttendanceModel>> data;
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
                                            widget.verify[index].regNo,
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
                                        child: Text(
                                            widget.verify[index].attendStatus),
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
