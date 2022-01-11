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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class image extends StatefulWidget {
  const image({Key? key}) : super(key: key);

  @override
  _imageState createState() => _imageState();
}

class _imageState extends State<image> {
  File? image;
  File? image2;
  String url = "http://${Url.ip}:5001/img";
  Future pickImage() async {
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

  Future pickImage2() async {
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
    // var res = await http.post(
    //   Uri.parse(url),
    //   headers: <File, File>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<File, File>{
    //     "image1": image,
    //     // 'image2': image2,
    //   }),
    // );

    // my code

    // var request = http.MultipartRequest("POST", Uri.parse(url));
    // request.fields['title'] = "dummyimage";
    // request.headers['Authorization'] = "";
    // var picture = http.MultipartFile.fromBytes(
    //     'image', (await rootBundle.load(basename)).buffer.asUint8List(),
    //     filename: "filefile.png");
    //
    // request.files.add(picture);
    //
    // var response = await request.send();

    // my code 2

    var request = http.MultipartRequest('POST', Uri.parse(url));

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

    var resp = await request.send();
    // with multi part

    // Dio dio = Dio();
    // ByteData byteData = image!.readAsBytesSync() as ByteData;
    // List<int> imageData = byteData.buffer.asInt8List();
    //
    // MultipartFile multipartFile = MultipartFile.fromBytes(
    //   imageData,
    //   filename: "img.png",
    // );
    //
    // FormData formData = FormData.fromMap({
    //   "name": multipartFile,
    // });
    //
    // var response = await dio.post(url, data: formData);

    // if (res == 200) {
    //   print(res.body) ;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image picker'),
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
                width: 30,
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
                onPressed: () => pickImage(),
                child: Text("Upload image 1"),
              ),
              ElevatedButton(
                onPressed: () => pickImage2(),
                child: Text("Upload image 2"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 300,
                child: TextField(
                  // controller: passwordController,
                  obscureText: true,
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    labelText: 'Get images address',
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
            height: 20,
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
                      'onpressed',
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
