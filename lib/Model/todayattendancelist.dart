// To parse this JSON data, do
//
//     final todayattendancelist = todayattendancelistFromJson(jsonString);

import 'dart:convert';

Todayattendancelist todayattendancelistFromJson(String str) =>
    Todayattendancelist.fromJson(json.decode(str));

String todayattendancelistToJson(Todayattendancelist data) =>
    json.encode(data.toJson());

class Todayattendancelist {
  Todayattendancelist({
    required this.attendanceId,
    required this.presentStudents,
    required this.todayAttendance,
  });

  int attendanceId;
  int presentStudents;
  List<List<dynamic>> todayAttendance;

  factory Todayattendancelist.fromJson(Map<String, dynamic> json) =>
      Todayattendancelist(
        attendanceId: json["attendanceId"],
        presentStudents: json["presentStudents"],
        todayAttendance: List<List<dynamic>>.from(json["todayAttendance"]
            .map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "attendanceId": attendanceId,
        "presentStudents": presentStudents,
        "todayAttendance": List<dynamic>.from(
            todayAttendance.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
