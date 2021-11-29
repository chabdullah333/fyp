import 'package:flutter/material.dart';

class show extends StatelessWidget {
  const show({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Show Attendance',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: showattendance(),
    );
  }
}

class showattendance extends StatelessWidget {
  const showattendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DataTable(columns: [
            DataColumn(
              label: Text(
                'Reg No',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Attendance',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ),
          ], rows: [
            DataRow(cells: [
              DataCell(
                Text('18-arid-0100'),
              ),
              DataCell(
                Text('Abdullah'),
              ),
              DataCell(
                Text('50%'),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text('18-arid-0129'),
              ),
              DataCell(
                Text('Zeeshan'),
              ),
              DataCell(
                Text('30%'),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text('18-arid-0132'),
              ),
              DataCell(
                Text('waleed'),
              ),
              DataCell(
                Text('10%'),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text('18-arid-0130'),
              ),
              DataCell(
                Text('salman'),
              ),
              DataCell(
                Text('05%'),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text('18-arid-0172'),
              ),
              DataCell(
                Text('zain'),
              ),
              DataCell(
                Text('2%'),
              ),
            ]),
            DataRow(cells: [
              DataCell(
                Text('18-arid-0105'),
              ),
              DataCell(
                Text('arslan'),
              ),
              DataCell(
                Text('80%'),
              ),
            ]),
          ]),
        ],
      ),
    );
  }
}
