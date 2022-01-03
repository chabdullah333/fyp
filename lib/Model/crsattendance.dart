// To parse this JSON data, do
//
//     final crsattendance = crsattendanceFromJson(jsonString);

import 'dart:convert';

List<Crsattendance> crsattendanceFromJson(String str) =>
    List<Crsattendance>.from(
        json.decode(str).map((x) => Crsattendance.fromJson(x)));

String crsattendanceToJson(List<Crsattendance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Crsattendance {
  Crsattendance({
    required this.venue,
    required this.date,
    required this.status,
  });

  String venue;
  String date;
  String status;

  factory Crsattendance.fromJson(Map<String, dynamic> json) => Crsattendance(
        venue: json["Venue"],
        // date: DateTime.parse(json["Date"]),
        date: json["Date"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Venue": venue,
        // "Date":
        //     "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "Date": date,
        "Status": status,
      };
}
