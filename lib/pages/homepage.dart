import 'package:flutter/material.dart';
import 'package:pencilwith/pages/subpages/feedback.dart';
import 'package:pencilwith/pages/subpages/memo.dart';
import 'package:pencilwith/pages/subpages/write.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> subPageList = [MemoPage(), WritePage(), FeedBackPage()];
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              child: Column(
                children: [
                  Expanded(child: Container()),
                  TabBar(tabs: [
                    Tab(
                      child: Text(
                        '메모모음',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '글쓰기',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Tab(
                      child: Text(
                        '피드백',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ),
          body: TabBarView(children: subPageList)),
    );
  }
}
