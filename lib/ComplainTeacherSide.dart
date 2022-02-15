import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/testmark.dart';
import 'Model/teachersccomplainmodel.dart';

class teacherComplain extends StatefulWidget {
  final String teacherregno;
  const teacherComplain({Key? key, required this.teacherregno})
      : super(key: key);

  @override
  _teacherComplainState createState() => _teacherComplainState();
}

class _teacherComplainState extends State<teacherComplain> {
  TextEditingController tremarksController = TextEditingController();
  Future<List<Teachersccomplainmodel>> studentskirequests() async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/getRequestList/teacherSideComplaint?EmpNumber=${widget.teacherregno}'),
    );
    if (response.statusCode == 200) {
      List<Teachersccomplainmodel> paresd =
          teachersccomplainmodelFromJson(response.body);
      print(paresd);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<String> admit(String id, String tRemarks) async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/AdmitRequest/teacherside?RequestId=${id}&TRemarks=${tremarksController.text}'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<String> reject(String id, String tRemarks) async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/RejectRequest?RequestId=${id}&TRemarks=${tremarksController.text}'),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to load album');
    }
  }

  AttendanceImagesTeacherSideshowAlertDialog(
      BuildContext context, String procImg1, String procImg2, String date) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Text("Attendance : ${date}"),
          ),
          Container(
            child: Image(
              height: 200,
              width: 200,
              image: NetworkImage(
                  "http://${Url.ip}:5001/fyppythonfinal/ProcessedUnProcessedImages/${procImg1}"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Image(
              height: 200,
              width: 200,
              image: NetworkImage(
                  "http://${Url.ip}:5001/fyppythonfinal/ProcessedUnProcessedImages/${procImg2}"),
            ),
          ),
        ],
      ),
      actions: [
        cancelButton,
        // continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  ViewRemarksshowAlertDialog(
    BuildContext context,
    String attenddate,
    String status,
    String sRemarks,
    String id,
  ) {
    // set up the buttons
    // Widget cancelButton = TextButton(
    //   child: Text("Cancel"),
    //   onPressed: () {
    //     Navigator.of(context).pop();
    //   },
    // );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 400,
        width: 350,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text("Attendance date : "),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
              child: Text("${attenddate}"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text("Current Status : "),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(130, 20, 0, 0),
              child: Text("${status}"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Text("Student Remark:"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(130, 40, 0, 0),
              child: Text("${sRemarks}"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Text("Give your Remarks(Optional):"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 170, 0, 0),
              child: TextField(
                controller: tremarksController,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  labelText: "Remarks",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decorationColor: Colors.white,
                  ),
                  filled: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 255, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  admit(id, tremarksController.text);
                  // admit(snapshot.data![index].id.toString(),
                  //     snapshot.data![index].tRemarks);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) =>
                  //         teacherComplain(teacherregno: widget.teacherregno),
                  //   ),
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  // );
                  // snapshot.data!.removeAt(index);
                },
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.red,
                  shadowColor: Colors.red,
                  primary: Colors.deepPurple,
                ),
                child: Text(
                  "Admit",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(140, 255, 0, 0),
              child: ElevatedButton(
                onPressed: () {
                  reject(id, tremarksController.text);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  // reject(snapshot.data![index].id.toString(),
                  //     snapshot.data![index].tRemarks);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) =>
                  //         teacherComplain(teacherregno: widget.teacherregno),
                  //   ),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  shadowColor: Colors.red,
                ),
                child: Text(
                  "Rejected",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
      // actions: [
      //   cancelButton,
      //   // continueButton,
      // ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  late Future<List<Teachersccomplainmodel>> data;
  @override
  void initState() {
    super.initState();
    data = studentskirequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: FutureBuilder<List<Teachersccomplainmodel>>(
            future: data,
            key: UniqueKey(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Container(
                          height: 180,
                          width: 360,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 15.0, 0.0, 0.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "http://${Url.ip}:5001/fyppythonfinal/StudentsImages/${snapshot.data![index].studImage}"),
                            radius: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(110.0, 15, 0, 0),
                          child: Text(snapshot.data![index].regNo),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(250.0, 0, 0, 0),
                          child: TextButton(
                            onPressed: () {
                              ViewRemarksshowAlertDialog(
                                  context,
                                  snapshot.data![index].attendDate.toString(),
                                  snapshot.data![index].status,
                                  snapshot.data![index].sRemarks,
                                  snapshot.data![index].id.toString());
                            },
                            child: Text(
                              "View Remarks",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(110.0, 35, 0, 0),
                          child: Text(snapshot.data![index].studName),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(110.0, 55, 0, 0),
                          child: Text(snapshot.data![index].courseTitle),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(110.0, 75, 0, 0),
                          child: Text(snapshot.data![index].attendDate),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(90.0, 85, 0, 0),
                          child: TextButton(
                            onPressed: () {
                              AttendanceImagesTeacherSideshowAlertDialog(
                                  context,
                                  snapshot.data![index].procImg1,
                                  snapshot.data![index].procImg2,
                                  snapshot.data![index].attendDate.toString());
                            },
                            child: Text(
                              "Attendance Images",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(190.0, 125, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              admit(snapshot.data![index].id.toString(),
                                  snapshot.data![index].tRemarks);
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         teacherComplain(
                              //             teacherregno: widget.teacherregno),
                              //   ),
                              // );
                              Navigator.of(context).pop(true);
                              setState(() {
                                snapshot.data!.removeAt(index);
                              });
                              // snapshot.data!.removeAt(index);
                            },
                            style: ElevatedButton.styleFrom(
                              onSurface: Colors.red,
                              shadowColor: Colors.red,
                              primary: Colors.deepPurple,
                            ),
                            child: Text(
                              "Admit",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(270.0, 125, 0, 0),
                          child: ElevatedButton(
                            onPressed: () {
                              reject(snapshot.data![index].id.toString(),
                                  snapshot.data![index].tRemarks);
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         teacherComplain(
                              //             teacherregno: widget.teacherregno),
                              //   ),
                              // );
                              Navigator.of(context).pop();
                              setState(() {
                                snapshot.data!.removeAt(index);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                              shadowColor: Colors.red,
                            ),
                            child: Text(
                              "Rejected",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
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
      ),
    );
  }
}
