import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secondapp/Model/Stenrollcources.dart';
import 'package:secondapp/dashboard.dart';
import 'package:http/http.dart' as http;

class courses extends StatelessWidget {
  const courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Courses",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: coursebody(),
    );
  }
}

class coursebody extends StatefulWidget {
  const coursebody({Key? key}) : super(key: key);

  @override
  _coursebodyState createState() => _coursebodyState();
}

class _coursebodyState extends State<coursebody> {
  Future<List<Stenrollcources>> fetchServices() async {
    final response =
        await http.get(Uri.parse('http://192.168.0.102:5001/SEnrolledcourses'));
    if (response.statusCode == 200) {
      List<Stenrollcources> paresd = stenrollcourcesFromJson(response.body);
      ;
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  late Future<List<Stenrollcources>> data;

  @override
  void initState() {
    super.initState();
    data = fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: [
    //     ListTile(
    //       leading: Image(
    //         image: AssetImage('images/book (1).png'),
    //       ),
    //       title: Text(
    //         "OOP         (80%)",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       subtitle: Text("Object oriented programming"),
    //       onTap: () {},
    //     ),
    //     ListTile(
    //       leading: Image(
    //         image: AssetImage('images/book (1).png'),
    //       ),
    //       title: Text(
    //         "PF            (90%)",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       subtitle: Text("Programming Fundamental"),
    //       onTap: () {},
    //     ),
    //     ListTile(
    //       leading: Image(
    //         image: AssetImage('images/book (1).png'),
    //       ),
    //       title: Text(
    //         "DBS         (99%)",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       subtitle: Text("Database System"),
    //       onTap: () {},
    //     ),
    //     ListTile(
    //       tileColor: Colors.redAccent,
    //       leading: Image(
    //         image: AssetImage('images/book (1).png'),
    //       ),
    //       title: Text(
    //         "DLD         (60%)",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       subtitle: Text("Digital Logic Design"),
    //       onTap: () {},
    //     ),
    //     ListTile(
    //       leading: Image(
    //         image: AssetImage('images/book (1).png'),
    //       ),
    //       title: Text(
    //         "AI            (77%)",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       subtitle: Text("Artificial Intelligence"),
    //       onTap: () {},
    //     ),
    //     ListTile(
    //       tileColor: Colors.redAccent,
    //       leading: Image(
    //         image: AssetImage('images/book (1).png'),
    //       ),
    //       title: Text(
    //         "ITC         (40%)",
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //       subtitle: Text("Introduction to Computer"),
    //       onTap: () {},
    //     ),
    //   ],
    // );

    return Padding(
      padding: EdgeInsets.all(8),
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: FutureBuilder<List<Stenrollcources>>(
              future: data,
              key: UniqueKey(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              child: Image(
                                image: AssetImage('images/book (1).png'),
                              ),
                            ),
                            Text(
                              snapshot.data![index].title,
                            ),
                          ],
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
      )),
    );
  }
}
