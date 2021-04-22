import 'package:flutter/material.dart';
import 'package:pencilwith/models/feedbackmodel.dart';
import 'package:pencilwith/models/feedbackreplymodel.dart';
import 'package:pencilwith/pages/subpages/suboptionpages/commonfunction.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:intl/intl.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  final tmpTheme = TextStyle(fontSize: 9, color: Colors.black);
  final tmpTheme2 = TextStyle(height: 1.5, fontSize: 12, color: Colors.black);
  final dateFormatter = DateFormat('MM/dd HH:mm');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    closedKeyboard(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: List.generate(feedbackList.length, (index) {
              var subReplyList1 = [];
              var tmpCnt = 0;
              for (var reply in feedbackReplyList) {
                if (reply['id'] == feedbackList[index]['id']) {
                  subReplyList1.add(reply);
                }
              }
              tmpCnt = subReplyList1.length;
              return ExpansionTileCard(
                  contentPadding: EdgeInsets.all(10),
                  key:
                      new GlobalKey(), //이렇게 해놓고 나중에 this 쓰면 안되나? 외부 connection시
                  leading: CircleAvatar(
                      backgroundColor: Colors.grey[850],
                      child: Center(
                        child: Text(
                          '${feedbackList[index]['user'].toString().substring(0, 1)}',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  title: Text(
                    '${feedbackList[index]['target']}',
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: Text.rich(
                          TextSpan(
                              style: tmpTheme,
                              text:
                                  '${dateFormatter.format(DateTime.parse(feedbackList[index]['date']))}\n\n',
                              children: [
                                TextSpan(
                                    style: tmpTheme2,
                                    text: '${feedbackList[index]['content']}')
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.mail_outline_rounded,
                            size: 15,
                          ),
                          Text('$tmpCnt')
                        ],
                      )
                    ],
                  ),
                  children: _makeSubList(subReplyList1));
            }),
          ),
        ));
  }

  List<Widget> _makeSubList(List myList) {
    return List.generate(myList.length, (index) {
      return Column(
        children: [
          Divider(thickness: 1.0, height: 1.0),
          Padding(
            padding: const EdgeInsets.only(left: 68, right: 44),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text.rich(
                  TextSpan(
                      style: tmpTheme,
                      text:
                          '${dateFormatter.format(DateTime.parse(myList[index]['date']))}\n\n',
                      children: [
                        TextSpan(
                            style: tmpTheme2,
                            text: '${myList[index]['content']}')
                      ]),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
