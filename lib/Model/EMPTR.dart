// To parse this JSON data, do
//
//     final emptr = emptrFromJson(jsonString);

import 'dart:convert';

Emptr emptrFromJson(String str) => Emptr.fromJson(json.decode(str));

String emptrToJson(Emptr data) => json.encode(data.toJson());

class Emptr {
  Emptr({
    required this.type,
    required this.id,
    required this.fname,
    required this.lname,
    required this.mname,
    // required this.empEmail,
    required this.role,
  });

  String type;
  String id;
  String fname;
  String lname;
  String mname;
  // String empEmail;
  String role;

  factory Emptr.fromJson(Map<String, dynamic> json) => Emptr(
        type: json["type"],
        id: json["id"],
        fname: json["fname"],
        lname: json["lname"],
        mname: json["mname"],
        // empEmail: json["Emp_email"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "fname": fname,
        "lname": lname,
        "mname": mname,
        // "Emp_email": empEmail,
        "role": role,
      };
}
