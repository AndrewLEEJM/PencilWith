import 'package:flutter/material.dart';

class Agreement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          '이 용 약 관',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Text('''펜슬 위드를 통해 집필하신 원고는 펜슬위드에서 제작된 것을 명시해야 합니다.

완성된 원고의 저작권은 작가에게 있으며 피드백해준 글에 대해 저작권을 주장할 수 없습니다.

완성된 원고에서 나오는 수익은 작가 7, 펜슬 위드 3으로 분배합니다.
        ''',
            maxLines: 20,
            style: TextStyle(fontSize: 16.0, color: Colors.black)),
      ),
    );
  }
}
