import 'package:flutter/material.dart';
import 'package:secondapp/dashboard.dart';

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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image(
            image: AssetImage('images/book (1).png'),
          ),
          title: Text(
            "OOP         (80%)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("Object oriented programming"),
          onTap: () {},
        ),
        ListTile(
          leading: Image(
            image: AssetImage('images/book (1).png'),
          ),
          title: Text(
            "PF            (90%)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("Programming Fundamental"),
          onTap: () {},
        ),
        ListTile(
          leading: Image(
            image: AssetImage('images/book (1).png'),
          ),
          title: Text(
            "DBS         (99%)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("Database System"),
          onTap: () {},
        ),
        ListTile(
          tileColor: Colors.redAccent,
          leading: Image(
            image: AssetImage('images/book (1).png'),
          ),
          title: Text(
            "DLD         (60%)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("Digital Logic Design"),
          onTap: () {},
        ),
        ListTile(
          leading: Image(
            image: AssetImage('images/book (1).png'),
          ),
          title: Text(
            "AI            (77%)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("Artificial Intelligence"),
          onTap: () {},
        ),
        ListTile(
          tileColor: Colors.redAccent,
          leading: Image(
            image: AssetImage('images/book (1).png'),
          ),
          title: Text(
            "ITC         (40%)",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text("Introduction to Computer"),
          onTap: () {},
        ),
      ],
    );
  }
}
