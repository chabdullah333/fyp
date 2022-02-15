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
    required this.processedpicture1,
    required this.processedpicture2,
    required this.uniqueid,
    required this.cStatus,
    required this.reqStatus,
    required this.sRemarks,
    required this.tRemarks,
  });

  String venue;
  String date;
  String status;
  String processedpicture1;
  String processedpicture2;
  int uniqueid;
  String cStatus;
  String reqStatus;
  String sRemarks;
  String tRemarks;

  factory Crsattendance.fromJson(Map<String, dynamic> json) => Crsattendance(
        venue: json["Venue"],
        date: json["Date"],
        status: json["Status"],
        processedpicture1: json["processedpicture1"],
        processedpicture2: json["processedpicture2"],
        uniqueid: json["uniqueid"],
        cStatus: json["cStatus"],
        reqStatus: json["ReqStatus"],
        sRemarks: json["S_Remarks"],
        tRemarks: json["T_Remarks"],
      );

  Map<String, dynamic> toJson() => {
        "Venue": venue,
        "Date": date,
        "Status": status,
        "processedpicture1": processedpicture1,
        "processedpicture2": processedpicture2,
        "uniqueid": uniqueid,
        "cStatus": cStatus,
        "ReqStatus": reqStatus,
        "S_Remarks": sRemarks,
        "T_Remarks": tRemarks,
      };
}
