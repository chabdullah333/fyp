import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
                          height: 80,
                          child: Card(
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 80,
                                  child: Image(
                                    image: AssetImage('images/book (1).png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  snapshot.data![index].date.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                Container(
                                  width: 40,
                                  child: Text(
                                    snapshot.data![index].venue,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 35,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.green,
                                  child: Center(
                                    child: Text(
                                      snapshot.data![index].status,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
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
    );
  }
}
