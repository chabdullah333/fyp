import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secondapp/Model/showattendancedropdownmodel.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/classes.dart';
import 'package:secondapp/testmark.dart';

class classesshowattendance extends StatefulWidget {
  final String empname;
  const classesshowattendance({Key? key, required this.empname})
      : super(key: key);

  @override
  _classesshowattendanceState createState() => _classesshowattendanceState();
}

class _classesshowattendanceState extends State<classesshowattendance> {
  Future<List<Showattendancedropdownmodel>> show() async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/showattendanceclasses?EmpNumber=${widget.empname}'),
    );
    if (response.statusCode == 200) {
      List<Showattendancedropdownmodel> parsed =
          showattendancedropdownmodelFromJson(response.body);
      return parsed;
    } else {
      throw Exception("failed to load album");
    }
  }

  late String coursecode;
  late String discip;
  late String sect;
  late String semc;

  late Future<List<Showattendancedropdownmodel>> data;
  @override
  void initState() {
    super.initState();
    data = show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classes"),
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
              child: FutureBuilder<List<Showattendancedropdownmodel>>(
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
                          child: ListView(
                            children: [
                              ListTile(
                                leading: Image(
                                  image: AssetImage('images/class.png'),
                                ),
                                title: Text(
                                  snapshot.data![index].discipline +
                                      ('-') +
                                      snapshot.data![index].semc.toString() +
                                      snapshot.data![index].section,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  snapshot.data![index].courseno,
                                ),
                                onTap: () {
                                  coursecode = snapshot.data![index].courseno;
                                  discip = snapshot.data![index].discipline;
                                  sect = snapshot.data![index].section;
                                  semc = snapshot.data![index].semc.toString();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => test(
                                        empname: widget.empname,
                                        courseno: coursecode,
                                        discipline: discip,
                                        section: sect,
                                        semesterno: semc,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
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
