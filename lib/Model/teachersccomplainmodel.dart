// To parse this JSON data, do
//
//     final teachersccomplainmodel = teachersccomplainmodelFromJson(jsonString);

import 'dart:convert';

List<Teachersccomplainmodel> teachersccomplainmodelFromJson(String str) =>
    List<Teachersccomplainmodel>.from(
        json.decode(str).map((x) => Teachersccomplainmodel.fromJson(x)));

String teachersccomplainmodelToJson(List<Teachersccomplainmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teachersccomplainmodel {
  Teachersccomplainmodel({
    required this.id,
    required this.regNo,
    required this.attendDate,
    required this.procImg1,
    required this.procImg2,
    required this.courseTitle,
    required this.studName,
    required this.status,
    required this.studImage,
    required this.sRemarks,
    required this.tRemarks,
  });

  int id;
  String regNo;
  String attendDate;
  String procImg1;
  String procImg2;
  String courseTitle;
  String studName;
  String status;
  String studImage;
  String sRemarks;
  String tRemarks;

  factory Teachersccomplainmodel.fromJson(Map<String, dynamic> json) =>
      Teachersccomplainmodel(
        id: json["ID"],
        regNo: json["RegNo"],
        attendDate: json["AttendDate"],
        procImg1: json["ProcImg1"],
        procImg2: json["ProcImg2"],
        courseTitle: json["CourseTitle"],
        studName: json["StudName"],
        status: json["Status"],
        studImage: json["StudImage"],
        sRemarks: json["S_Remarks"],
        tRemarks: json["T_Remarks"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "RegNo": regNo,
        "AttendDate": attendDate,
        "ProcImg1": procImg1,
        "ProcImg2": procImg2,
        "CourseTitle": courseTitle,
        "StudName": studName,
        "Status": status,
        "StudImage": studImage,
        "S_Remarks": sRemarks,
        "T_Remarks": tRemarks,
      };
}
