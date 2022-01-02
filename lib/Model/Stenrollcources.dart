// To parse this JSON data, do
//
//     final stenrollcources = stenrollcourcesFromJson(jsonString);

import 'dart:convert';

List<Stenrollcources> stenrollcourcesFromJson(String str) =>
    List<Stenrollcources>.from(
        json.decode(str).map((x) => Stenrollcources.fromJson(x)));

String stenrollcourcesToJson(List<Stenrollcources> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Stenrollcources {
  Stenrollcources({
    required this.code,
    required this.title,
  });

  String code;
  String title;

  factory Stenrollcources.fromJson(Map<String, dynamic> json) =>
      Stenrollcources(
        code: json["Code"],
        title: json["Title"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Title": title,
      };
}
