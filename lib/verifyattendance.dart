import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyAtt extends StatefulWidget {
  const VerifyAtt({Key? key}) : super(key: key);

  @override
  _VerifyAttState createState() => _VerifyAttState();
}

class _VerifyAttState extends State<VerifyAtt> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Verify Attendance"),
            centerTitle: true,
            backgroundColor: Colors.red,
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Total=50"),
                      SizedBox(
                        width: 70,
                      ),
                      Text("Present=40"),
                      SizedBox(
                        width: 70,
                      ),
                      Text("Absent=10"),
                    ],
                  ),
                  Card(
                    color: Colors.redAccent,
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
                            height: 32,
                            width: 90,
                            child: Column(
                              children: [
                                Text("18-ARID-0159"),
                                Text("Siraj Ali"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 40,
                            child: Column(
                              children: [
                                Text("9/18"),
                                Text("50%"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 100,
                            child: Column(
                              children: [
                                Text("75%"),
                                Text("Matched(%)"),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 50,
                            color: Colors.greenAccent,
                            child: Center(child: Text("P")),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                            height: 32,
                            width: 90,
                            child: Column(
                              children: [
                                Text("18-ARID-0100"),
                                Text("M Abdullah"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 40,
                            child: Column(
                              children: [
                                Text("18/18"),
                                Text("100%"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 100,
                            child: Column(
                              children: [
                                Text("75%"),
                                Text("Matched(%)"),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 50,
                            color: Colors.greenAccent,
                            child: Center(child: Text("P")),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.redAccent,
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
                            height: 32,
                            width: 90,
                            child: Column(
                              children: [
                                Text("18-ARID-0169"),
                                Text("Usama khan"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 40,
                            child: Column(
                              children: [
                                Text("3/18"),
                                Text("16%"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 100,
                            child: Column(
                              children: [
                                Text("95%"),
                                Text("Matched(%)"),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 50,
                            color: Colors.greenAccent,
                            child: Center(child: Text("P")),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                            height: 32,
                            width: 90,
                            child: Column(
                              children: [
                                Text("18-ARID-0132"),
                                Text("Zain Jehangir"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 40,
                            child: Column(
                              children: [
                                Text("16/18"),
                                Text("88%"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 100,
                            child: Column(
                              children: [
                                Text("85%"),
                                Text("Matched(%)"),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 50,
                            color: Colors.redAccent,
                            child: Center(child: Text("A")),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.redAccent,
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
                            height: 32,
                            width: 90,
                            child: Column(
                              children: [
                                Text("18-ARID-0129"),
                                Text("Zeeshan Raja"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 40,
                            child: Column(
                              children: [
                                Text("9/18"),
                                Text("50%"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                            width: 100,
                            child: Column(
                              children: [
                                Text("95%"),
                                Text("Matched(%)"),
                              ],
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 50,
                            color: Colors.greenAccent,
                            child: Center(child: Text("P")),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
