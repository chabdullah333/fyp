// To parse this JSON data, do
//
//     final verifyAtttendanceModel = verifyAtttendanceModelFromJson(jsonString);

import 'dart:convert';

List<VerifyAtttendanceModel> verifyAtttendanceModelFromJson(String str) =>
    List<VerifyAtttendanceModel>.from(
        json.decode(str).map((x) => VerifyAtttendanceModel.fromJson(x)));

String verifyAtttendanceModelToJson(List<VerifyAtttendanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VerifyAtttendanceModel {
  VerifyAtttendanceModel({
    required this.id,
    required this.fullName,
    required this.status,
    required this.present,
    required this.absent,
    required this.total,
    required this.percent,
  });

  String id;
  String fullName;
  String status;
  int present;
  int absent;
  int total;
  double percent;

  factory VerifyAtttendanceModel.fromJson(Map<String, dynamic> json) =>
      VerifyAtttendanceModel(
        id: json["id"],
        fullName: json["fullName"],
        status: json["Status"],
        present: json["Present"],
        absent: json["Absent"],
        total: json["Total"],
        percent: json["Percent"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "Status": status,
        "Present": present,
        "Absent": absent,
        "Total": total,
        "Percent": percent,
      };
}

// enum Status { P }
