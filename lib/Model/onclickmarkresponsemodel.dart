// To parse this JSON data, do
//
//     final onclickmarkresponsemodel = onclickmarkresponsemodelFromJson(jsonString);

import 'dart:convert';

List<Onclickmarkresponsemodel> onclickmarkresponsemodelFromJson(String str) =>
    List<Onclickmarkresponsemodel>.from(
        json.decode(str).map((x) => Onclickmarkresponsemodel.fromJson(x)));

String onclickmarkresponsemodelToJson(List<Onclickmarkresponsemodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Onclickmarkresponsemodel {
  Onclickmarkresponsemodel({
    required this.regNo,
    required this.attendStatus,
    required this.name,
    required this.totalAttend,
    required this.presentAttend,
    required this.totalpercentage,
  });

  String regNo;
  String attendStatus;
  String name;
  int totalAttend;
  int presentAttend;
  double totalpercentage;

  factory Onclickmarkresponsemodel.fromJson(Map<String, dynamic> json) =>
      Onclickmarkresponsemodel(
        regNo: json["RegNo"],
        attendStatus: json["Attend_Status"],
        name: json["Name"],
        totalAttend: json["TotalAttend"],
        presentAttend: json["PresentAttend"],
        totalpercentage: json["totalpercentage"],
      );

  Map<String, dynamic> toJson() => {
        "RegNo": regNo,
        "Attend_Status": attendStatus,
        "Name": name,
        "TotalAttend": totalAttend,
        "PresentAttend": presentAttend,
        "totalpercentage": totalpercentage,
      };
}
