import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:secondapp/testmark.dart';
import 'package:secondapp/verifyattendance.dart';
import 'Model/MarkAtttendanceModel.dart';
import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:secondapp/Model/onclickmarkresponsemodel.dart';
import 'package:secondapp/testimage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class MyApp extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String username;

  const MyApp({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.username,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? image;
  File? image2;
  String id = "";
  String courseno = "";
  String sect = "";
  String discip = "";
  late String fname = widget.firstname;
  late String lname = widget.lastname;
  late String uname = widget.username;
  List<Onclickmarkresponsemodel> parsed = [];
  List<MarkAtttendanceModel> locations = [];
  String selecteditems = "1";
  DateTime now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String date = '';

  Future<List<MarkAtttendanceModel>> fetchDrop() async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}:5001/TEnrolledcourses/markattendance?EmpNumber=${widget.username}'));
    if (response.statusCode == 200) {
      List<MarkAtttendanceModel> Locations =
          markAtttendanceModelFromJson(response.body);
      print(response.body);
      setState(() {
        locations.addAll(Locations);
      });
      print(locations.elementAt(1));
      return locations;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<MarkAtttendanceModel>> dropdownid(String id) async {
    final response = await http.get(Uri.parse(
        'http://${Url.ip}:5001/TEnrolledcourses/markattendance/dropdownid?id=${id}'));
    if (response.statusCode == 200) {
      List<MarkAtttendanceModel> paresd =
          markAtttendanceModelFromJson(response.body);
      return paresd;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future gallerypickImage1() async {
    try {
      print('image picking');

      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image... $e');
    }
  }

  Future camerapickImage1() async {
    try {
      print('image picking');

      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image... $e');
    }
  }

  Future gallerypickImage2() async {
    try {
      print('image picking');

      final image2 = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image2 == null) return;

      final imageTemporary = File(image2.path);
      setState(() {
        this.image2 = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image... $e');
    }
  }

  Future camerapickImage2() async {
    try {
      print('image picking');

      final image2 = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image2 == null) return;

      final imageTemporary = File(image2.path);
      setState(() {
        this.image2 = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image... $e');
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datePicker = await showDatePicker(
      context: context,
      initialDate: now,
      // Current Date
      firstDate: DateTime(2010),
      // First Date
      lastDate: DateTime(2050),
      // Last Date
      // textDirection: TextDirection.LTR,
      // Header Text or Button Direction ltr or rtl
      initialDatePickerMode: DatePickerMode.day, // Day or Year Mode
      //   selectableDayPredicate: (DateTime val) =>
      //       val.weekday == 6 || val.weekday == 7 ? false : true, // WeekDay Off
      // selectableDayPredicate: (DateTime val) =>
      //     val.isBefore(val) ? false : true,
    );

    if (_datePicker != null && _datePicker != now) {
      setState(() {
        now = _datePicker;
        date = now.year.toString() +
            '-' +
            now.month.toString() +
            '-' +
            now.day.toString();
      });
    }
  }

  List<String> regno = [];
  List<String> status = [];
  Future<void> verifyimg() async {
    /////////////http//////////
    // var res = await http.post(
    //   Uri.parse(url),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, String>{
    //     'username': txtcontroller.text,
    //     'image1': image!.path.toString(),
    //     "image2": image2!.path.toString(),
    //   }),
    // );
    // if (res.statusCode == 200) {
    //   print(res.body);
    // }
    //////////http end//////////

    //////////////formdata//////////////////
    // FormData data = FormData.fromMap({
    //   "image1": await MultipartFile.fromFile(
    //     image!.path,
    //     filename: 'image1.jpg',
    //   ),
    //   "image2": await MultipartFile.fromFile(
    //     image2!.path,
    //     filename: "image2.jpg",
    //   ),
    //   'username': txtcontroller.text,
    // });
    //
    // Dio dio = new Dio();
    // dio.options.headers["contentType"] = "multipart/form-data";
    // dio
    //     .post(url, data: data)
    //     .then((response) => print(response))
    //     .catchError((error) => print(error));

//////////////////////formdata end/////////////

    // my code

    ///////////////////////////Multipart code//////////////////////
    Map<String, String> fields = <String, String>{};

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "http://${Url.ip}:5001/Proceed?EmpNumber=${widget.username}&timeTableId=${id}&courseno=${courseno}&section=${sect}&discipline=${discip}&date=${date}"));

    // final headers = <String, String>{};
    // headers["contentType"] = "application/json; charset=UTF-8";
    // request.fields['username'] = txtcontroller.text;
    // request.headers.addAll(headers);
    // for image 1
    Uint8List data = await this.image!.readAsBytes();
    List<int> list = data.cast();

    var picture1 =
        http.MultipartFile.fromBytes("image1", list, filename: 'image1.jpg');

    // for image 2
    data = await this.image2!.readAsBytes();
    list = data.cast();
    var picture2 =
        http.MultipartFile.fromBytes("image2", list, filename: 'image2.jpg');

    request.files.add(picture1);
    request.files.add(picture2);
    fields.forEach((k, v) => request.fields[k] = v);
    request.fields.addAll(fields);

    request.headers.addAll(
      {
        r'Content-Type': 'application/json; charset=UTF-8',
        r'Content-Type': 'multipart/form-data',
      },
    );
    var abc;
    abc = [];
    // var resp = await request.send();
    request.send().then((result) async {
      http.Response.fromStream(result).then((response) {
        if (response.statusCode == 200) {
          print("Uploaded! ");
          // print('response.body ' + response.body);
          // abc = response.body;
          parsed = onclickmarkresponsemodelFromJson(response.body);
          print(parsed);
          // List<Todayattendancelist> paresd =
          //     todayattendancelistFromJson(response.body) as List<Todayattendancelist>;
          for (int i = 0; i < parsed.length; i++) {
            regno.add(parsed[i].regNo);
            status.add(parsed[i].attendStatus);
            print(regno.elementAt(i));
          }
          print(regno.elementAt(0));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => testimg(
                verify: parsed,
                regno: regno,
                status: status,
                firstname: fname,
                lastname: lname,
                username: uname,
              ),
            ),
          );
        }
        return response.body;
      });
    });
    print(data);
    // resp.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    ///////////////////////////multipartrequest end
    // late Future<List<Todayattendancelist>> data123;
  }

  @override
  void initState() {
    super.initState();
    fetchDrop();
    now = DateTime.now();
  }

  // String id = "";
  // String courseno = "";
  // String sect = "";
  // String discip = "";

  @override
  Widget build(BuildContext context) {
    if (widget.username.toLowerCase() == 'biit190') {
      selecteditems = '1';
    }
    if (widget.username.toLowerCase() == 'biit167') {
      selecteditems = '16';
    }
    if (widget.username.toLowerCase() == 'biit346') {
      selecteditems = '8';
    }

    // DateTime now = new DateTime.now();
    // var formatter = new DateFormat('yyyy-MM-dd');
    // String formattedDate = formatter.format(now);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Mark Attendance'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            width: 350,
            child: DropdownButton(
              autofocus: true,
              // hint: Text(
              //   'Organizations',
              //   style: TextStyle(
              //     fontWeight: FontWeight.w900,
              //     fontSize: 35,
              //     color: Colors.teal,
              //   ),
              // ),
              value: selecteditems.toString(),
              onChanged: (String? newValue) {
                setState(
                  () {
                    selecteditems = newValue!;
                    id = selecteditems;
                  },
                );
              },
              items: locations.map((item) {
                return DropdownMenuItem(
                  child: Text(
                    item.discipline +
                        item.semC.toString() +
                        item.section +
                        "(" +
                        item.day +
                        item.slotStart.toString() +
                        "-" +
                        item.slotEnd.toString() +
                        ")",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  value: item.id.toString(),
                );
              }).toList(),
              dropdownColor: Colors.white,
            ),
          ),
          Row(
            children: [
              Container(
                height: 210,
                width: 135,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Teacher',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Class',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Subject',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Day',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 210,
                width: 225,
                // color: Colors.green,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        widget.firstname + " " + widget.lastname,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 120,
                      child: FutureBuilder<List<MarkAtttendanceModel>>(
                        future: dropdownid(id),
                        key: UniqueKey(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  courseno = snapshot.data![index].code;
                                  sect = snapshot.data![index].section;
                                  discip = snapshot.data![index].discipline;
                                  return Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          child: Text(
                                            discip +
                                                "-" +
                                                snapshot.data![index].semC
                                                    .toString() +
                                                sect,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Text(
                                            snapshot.data![index].title +
                                                ("(") +
                                                courseno +
                                                (")"),
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          child: Text(
                                            snapshot.data![index].day,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Row(
                        children: [
                          Text(
                            now.year.toString() +
                                '-' +
                                now.month.toString() +
                                '-' +
                                now.day.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.date_range,
                              size: 30,
                            ),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                _selectDate(context);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image != null
                        ? Image.file(
                            image!,
                            height: 140,
                            width: 120,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'images/gallery.png',
                            height: 140,
                            width: 120,
                          ),
                    Text('pick image 1'),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Card(
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image2 != null
                        ? Image.file(
                            image2!,
                            height: 140,
                            width: 120,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'images/gallery.png',
                            height: 140,
                            width: 120,
                          ),
                    Text('pick image 2'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 50,
                ),
                color: Colors.red,
                onPressed: () {
                  camerapickImage1();
                },
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                icon: const Icon(
                  Icons.image,
                  size: 50,
                ),
                color: Colors.red,
                onPressed: () {
                  gallerypickImage1();
                },
              ),
              SizedBox(
                width: 85,
              ),
              IconButton(
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  size: 50,
                ),
                color: Colors.red,
                onPressed: () {
                  camerapickImage2();
                },
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                icon: const Icon(
                  Icons.image,
                  size: 50,
                ),
                color: Colors.red,
                onPressed: () {
                  gallerypickImage2();
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              verifyimg();
            },
            child: Container(
              child: Text(
                'Mark Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              width: 150,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
