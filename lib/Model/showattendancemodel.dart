class datemodal {
  List Date;

  datemodal({
    required this.Date,
  });

  factory datemodal.fromJson(Map<String, dynamic> json) {
    return datemodal(
      Date: json['Date'].toList(),
    );
  }
}

class statusmodal {
  List status;

  statusmodal({
    required this.status,
  });

  factory statusmodal.fromJson(Map<String, dynamic> json) {
    return statusmodal(
      status: json['Status'].toList(),
    );
  }
}

class showattendancemodel {
  String RegNo;
  String Name;
  datemodal date;
  statusmodal status;

  showattendancemodel({
    required this.RegNo,
    required this.Name,
    required this.date,
    required this.status,
  });

  factory showattendancemodel.fromJson(Map<String, dynamic> json) {
    return showattendancemodel(
        RegNo: json['Reg_no'].toString(),
        Name: json['Fullname'],
        date: datemodal.fromJson(json['Date']),
        status: statusmodal.fromJson(json['Status']));
  }
}
