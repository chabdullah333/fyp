// To parse this JSON data, do
//
//     final showattendancemodel = showattendancemodelFromJson(jsonString);

import 'dart:convert';

List<Showattendancemodel> showattendancemodelFromJson(String str) =>
    List<Showattendancemodel>.from(
        json.decode(str).map((x) => Showattendancemodel.fromJson(x)));

String showattendancemodelToJson(List<Showattendancemodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Showattendancemodel {
  Showattendancemodel({
    required this.attendanceStatuses,
    required this.regNo,
    required this.name,
    required this.ind,
  });

  String attendanceStatuses;
  String regNo;
  String name;
  String ind;

  factory Showattendancemodel.fromJson(Map<String, dynamic> json) =>
      Showattendancemodel(
        attendanceStatuses: json["AttendanceStatuses"],
        regNo: json["RegNo"],
        name: json["Name"],
        ind: json["Ind"],
      );

  Map<String, dynamic> toJson() => {
        "AttendanceStatuses": attendanceStatuses,
        "RegNo": regNo,
        "Name": name,
        "Ind": ind,
      };
}
