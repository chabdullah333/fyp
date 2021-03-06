import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/login.dart';
import 'Model/crsattendance.dart';
import 'package:secondapp/testmark.dart';

class courseattendance extends StatefulWidget {
  final String coursecode;
  final String username;
  final String coursetitle;
  const courseattendance({
    Key? key,
    required this.username,
    required this.coursecode,
    required this.coursetitle,
  }) : super(key: key);

  @override
  _courseattendanceState createState() => _courseattendanceState();
}

class _courseattendanceState extends State<courseattendance> {
  String cdate = '';
  String uniqid = '';
  TextEditingController remarksController = TextEditingController();
  Future<List<Crsattendance>> cooorseattndnce() async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/getStudentClassAttendance?aridNo=${widget.username}&cno=${widget.coursecode}'),
    );
    if (response.statusCode == 200) {
      print(widget.username);
      print(widget.coursecode);
      print(widget.coursetitle);

      List<Crsattendance> paresd = crsattendanceFromJson(response.body);
      print(paresd);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Crsattendance>> data;
  @override
  void initState() {
    super.initState();
    data = cooorseattndnce();
  }

  showAlertDialog(BuildContext context, String complaindate, String uniqeid) {
    cdate = complaindate;
    uniqid = uniqeid;
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget applyButton = TextButton(
      child: Text("Apply"),
      onPressed: () {
        complain();
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (BuildContext context) => loginpage()));
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text(
          "Complain",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
      content: Column(
        children: [
          Container(
            height: 40,
            width: 320,
            child: Row(
              children: [
                Text(
                  "Request for check : ${complaindate}",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 320,
            child: Row(
              children: [
                Text("Remarks :"),
              ],
            ),
          ),
          Container(
            height: 90,
            width: 360,
            child: Card(
              color: Colors.grey,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: remarksController,
                  maxLines: 8,
                  decoration: InputDecoration.collapsed(
                      hintText: "Enter your remarks here"),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        cancelButton,
        applyButton,
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

  AttendanceImagesStudentSideshowAlertDialog(BuildContext context,
      String processedpicture1, String processedpicture2) {
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
            child: Image(
              height: 200,
              width: 200,
              image: NetworkImage(
                  "http://${Url.ip}:5001/fyppythonfinal/ProcessedUnProcessedImages/${processedpicture1}"),
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
                  "http://${Url.ip}:5001/fyppythonfinal/ProcessedUnProcessedImages/${processedpicture2}"),
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

  ViewDetailshowAlertDialog(BuildContext context, String date, String reqStatus,
      String sRemarks, String tRemarks) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Container(
        height: 400,
        width: 350,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                "Attendance date : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(130, 0, 0, 0),
              child: Text("${date}"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                "Request Status : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(130, 20, 0, 0),
              child: Text("${reqStatus}"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Text(
                "your remarks:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(130, 40, 0, 0),
              child: Text("${sRemarks}"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Text(
                "Teacher Remarks :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(140, 150, 0, 0),
              child: Text(tRemarks),
            ),
          ],
        ),
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

  Future<String> complain() async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/ApplyCheck?id=${uniqid}&remarks=${remarksController.text}'),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return "OK";
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.coursetitle,
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
              child: FutureBuilder<List<Crsattendance>>(
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
                          height: 85,
                          child: Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 40,
                                      child: Image(
                                        image:
                                            AssetImage('images/book (1).png'),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   width: 5,
                                    // ),
                                    Text(
                                      snapshot.data![index].date.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 40,
                                      child: Text(
                                        snapshot.data![index].venue,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Center(
                                      child: Text(
                                        snapshot.data![index].status,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color:
                                              (snapshot.data![index].status ==
                                                      'A')
                                                  ? Colors.redAccent
                                                  : Colors.green,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.red,
                                        onSurface: Colors.red,
                                        backgroundColor:
                                            (snapshot.data![index].cStatus ==
                                                    "yes")
                                                ? Colors.yellowAccent
                                                : Colors.green,
                                      ),
                                      onPressed: () {
                                        if (snapshot.data![index].cStatus ==
                                            "no") {
                                          showAlertDialog(
                                              context,
                                              snapshot.data![index].date
                                                  .toString(),
                                              snapshot.data![index].uniqueid
                                                  .toString());
                                        }
                                      },
                                      child: Text(
                                        (snapshot.data![index].cStatus == "yes"
                                            ? "Applied"
                                            : "Challenge"),
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 80,
                                      child: InkWell(
                                        onTap: () {
                                          ViewDetailshowAlertDialog(
                                              context,
                                              snapshot.data![index].date
                                                  .toString(),
                                              snapshot.data![index].reqStatus,
                                              snapshot.data![index].sRemarks,
                                              snapshot.data![index].tRemarks);
                                        },
                                        child: Text(
                                          (snapshot.data![index].cStatus ==
                                                  "yes")
                                              ? ("view details")
                                              : (""),
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      height: 25,
                                      child: InkWell(
                                          onTap: () {
                                            AttendanceImagesStudentSideshowAlertDialog(
                                                context,
                                                snapshot.data![index]
                                                    .processedpicture1,
                                                snapshot.data![index]
                                                    .processedpicture2);
                                          },
                                          child: Image(
                                            image: AssetImage(
                                              'images/gallery.png',
                                            ),
                                          )),
                                    ),
                                  ],
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
    );
  }
}
