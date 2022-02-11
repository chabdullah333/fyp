// To parse this JSON data, do
//
//     final showattendancedropdownmodel = showattendancedropdownmodelFromJson(jsonString);

import 'dart:convert';

List<Showattendancedropdownmodel> showattendancedropdownmodelFromJson(
        String str) =>
    List<Showattendancedropdownmodel>.from(
        json.decode(str).map((x) => Showattendancedropdownmodel.fromJson(x)));

String showattendancedropdownmodelToJson(
        List<Showattendancedropdownmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Showattendancedropdownmodel {
  Showattendancedropdownmodel({
    required this.courseno,
    required this.coursename,
    required this.discipline,
    required this.semc,
    required this.section,
  });

  String courseno;
  String coursename;
  String discipline;
  int semc;
  String section;

  factory Showattendancedropdownmodel.fromJson(Map<String, dynamic> json) =>
      Showattendancedropdownmodel(
        courseno: json["courseno"],
        coursename: json["coursename"],
        discipline: json["discipline"],
        semc: json["semc"],
        section: json["section"],
      );

  Map<String, dynamic> toJson() => {
        "courseno": courseno,
        "coursename": coursename,
        "discipline": discipline,
        "semc": semc,
        "section": section,
      };
}
