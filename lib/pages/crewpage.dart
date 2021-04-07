import 'package:flutter/material.dart';

class CrewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('크 루',
            style: TextStyle(
              color: Colors.black,
            )
           ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: TabBar(tabs: <Widget>[
            Tab(
              icon: Icon(Icons.filter),
            ),
            Tab(
                text: '성별'
            ),
            Tab(
                text: '나이',
            ),
            Tab(
                text: '작가',
            ),
            Tab(
                text: '경력',
            ),
                ],
              labelColor: Colors.black,
              )
            ),
        body: Center(
          child: Container(
            width: 318,
              height: 155,
              child: Text(
                  '크루를 모집 중인 작가분이 현재 없습니다!\n\n아래 모집하기 버튼을 통해 피드백 크루를 모아보세요!',
                textAlign: TextAlign.center,
              ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey[300],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0)
              ),
          ),
          ),
          )
        ),
          )
    );
  }
}

