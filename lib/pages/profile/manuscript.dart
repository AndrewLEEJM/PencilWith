import 'package:flutter/material.dart';

class Manuscript extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '원 고 관 리',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Text('원고 관리',
            style: TextStyle(fontSize: 16.0, color: Colors.black)),
      ),
    );
  }
}
