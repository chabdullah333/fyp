import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Model/showattendancedropdownmodel.dart';
import 'package:secondapp/testmark.dart';

class dropdowntesting extends StatefulWidget {
  final String empname;
  const dropdowntesting({Key? key, required this.empname}) : super(key: key);

  @override
  _dropdowntestingState createState() => _dropdowntestingState();
}

class _dropdowntestingState extends State<dropdowntesting> {
  List<Showattendancedropdownmodel> locations = [];
  late String selecteditems = 'qw0er';
  Showattendancedropdownmodel dummy = new Showattendancedropdownmodel(
    coursename: 'q',
    section: 'w',
    semc: 0,
    discipline: 'e',
    courseno: 'r',
  );
  Future<List<Showattendancedropdownmodel>> showDropDown() async {
    final response = await http.get(
      Uri.parse(
          'http://${Url.ip}:5001/showattendancedropdown?EmpNumber=BIIT167'),
    );
    if (response.statusCode == 200) {
      List<Showattendancedropdownmodel> paresd =
          showattendancedropdownmodelFromJson(response.body);

      locations.add(dummy);
      // obj.addAll(paresd);
      // obj.add(dummy);
      // print(obj.length);
      print(
          'coursename:' + locations.elementAt(locations.length - 1).coursename);
      setState(() {
        locations.addAll(paresd);
      });
      // print(locations.elementAt(1));
      return locations;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    //data = showkro();
    showDropDown();
    // setState(() {
    //   selecteditems = dummy.discipline;
    // });
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.empname.toLowerCase() == 'biit346') {
    //   selecteditems = 'MCS';
    // }
    // if (widget.empname.toLowerCase() == 'biit346') {
    //   selecteditems = 'BCS';
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('drop down'),
      ),
      body: Container(
        height: 50,
        width: 350,
        child: DropdownButton(
          autofocus: true,
          hint: Text(
            'Organizations',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 35,
              color: Colors.teal,
            ),
          ),
          value: selecteditems.toString(),
          onChanged: (String? newValue) {
            setState(
              () {
                selecteditems = newValue!;
              },
            );
          },
          items: locations.map((item) {
            return DropdownMenuItem(
              child: Text(
                item.discipline + item.semc.toString() + item.section,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              value: item.coursename +
                  item.section +
                  item.semc.toString() +
                  item.discipline +
                  item.courseno,
            );
          }).toList(),
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
