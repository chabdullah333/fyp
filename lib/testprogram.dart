import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class testing extends StatelessWidget {
  const testing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        title: Text(
          'Dice',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: dice(),
    );
  }
}

class dice extends StatefulWidget {
  const dice({Key? key}) : super(key: key);

  @override
  _diceState createState() => _diceState();
}

class _diceState extends State<dice> {
  int leftdiceno = 1;
  int rightdice = 2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Image.asset('images/dice$leftdiceno.png'),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                setState(() {
                  rightdice = Random().nextInt(6) + 1;
                });
              },
              child: Image.asset('images/dice$rightdice.png'),
            ),
          ),
        ],
      ),
    );
  }
}
