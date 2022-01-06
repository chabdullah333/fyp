// To parse this JSON data, do
//
//     final markAtttendanceModel = markAtttendanceModelFromJson(jsonString);

import 'dart:convert';

List<MarkAtttendanceModel> markAtttendanceModelFromJson(String str) =>
    List<MarkAtttendanceModel>.from(
        json.decode(str).map((x) => MarkAtttendanceModel.fromJson(x)));

String markAtttendanceModelToJson(List<MarkAtttendanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarkAtttendanceModel {
  MarkAtttendanceModel({
    required this.id,
    required this.semC,
    required this.title,
    required this.section,
    required this.discipline,
    required this.day,
    required this.slotStart,
    required this.slotEnd,
  });

  int id;
  int semC;
  String title;
  String section;
  String discipline;
  String day;
  String slotStart;
  String slotEnd;

  factory MarkAtttendanceModel.fromJson(Map<String, dynamic> json) =>
      MarkAtttendanceModel(
        id: json["Id"],
        semC: json["SemC"],
        title: json["Title"],
        section: json["Section"],
        discipline: json["Discipline"],
        day: json["Day"],
        slotStart: json["SlotStart"].toString(),
        slotEnd: json["SlotEnd"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "SemC": semC,
        "Title": title,
        "Section": section,
        "Discipline": discipline,
        "Day": day,
        "SlotStart": slotStart,
        "SlotEnd": slotEnd,
      };
}