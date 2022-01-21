import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:secondapp/testmark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class image extends StatefulWidget {
  const image({Key? key}) : super(key: key);

  @override
  _imageState createState() => _imageState();
}

class _imageState extends State<image> {
  TextEditingController txtcontroller = TextEditingController();
  File? image;
  File? image2;
  String username = "Abdullah";
  late String password = "abc123";
  String url = "http://${Url.ip}:5001/img";

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
    Map<String, String> fields = <String, String>{
      "username": username.toString(),
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse("http://${Url.ip}:5001/Proceed"));

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
          print('response.body ' + response.body);
          abc = response.body;
        }
        return response.body;
      });
    });

    // resp.stream.transform(utf8.decoder).listen((value) {
    //   print(value);
    // });
    ///////////////////////////multipartrequest end
  } ////////////////verifyimg

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image picker code'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Card(
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Spacer(),
                    image != null
                        ? Image.file(
                            image!,
                            height: 128,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'images/showattendance.png',
                            height: 50,
                            width: 50,
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
                    // Spacer(),
                    image2 != null
                        ? Image.file(
                            image2!,
                            height: 128,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'images/showattendance.png',
                            height: 50,
                            width: 50,
                          ),
                    Text('pick image 2'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => gallerypickImage1(),
                child: Text("Gallery pic 1"),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () => gallerypickImage2(),
                child: Text("Gallery pic 2"),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  camerapickImage1();
                },
                child: Text("Camera pic 1"),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  camerapickImage2();
                },
                child: Text("Camera pic 2"),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Container(
                height: 67,
                width: 300,
                child: TextField(
                  controller: txtcontroller,
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    labelText: 'abc',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      decorationColor: Colors.white,
                    ),
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 80,
          ),
          Row(
            children: [
              Container(
                child: ButtonTheme(
                  height: 40,
                  disabledColor: Colors.blue,
                  child: ElevatedButton(
                    onPressed: () {
                      verifyimg();
                      print(image);
                      print(image2);
                    },
                    child: Text(
                      'Mark Attendance',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
