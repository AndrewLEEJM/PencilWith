import 'package:flutter/material.dart';
import 'package:pencilwith/models/feedbackmodel.dart';
import 'package:pencilwith/pages/subpages/suboptionpages/commonfunction.dart';

class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
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
      body: SingleChildScrollView(child: _feedbackPage()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            FocusScope.of(context).requestFocus(new FocusNode());
          });
        },
        backgroundColor: Colors.grey[400],
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _feedbackPage() {
    return Column(
      children: List.generate(feedbackList.length, (index) {
        return feedbackList[index]['kind'] == 'feedback'
            ? Card(
                margin:
                    EdgeInsets.only(right: 10, top: 10, left: 10, bottom: 10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                        child: Text('${feedbackList[index]['target']}'),
                      ),
                      Text('${feedbackList[index]['content']}'),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.message,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('3'),
                          Spacer(),
                          Text('신고')
                        ],
                      ),
                    ],
                  ),
                ),
                color: Colors.grey[300],
              )
            : Card(
                margin:
                    EdgeInsets.only(right: 10, top: 10, left: 50, bottom: 10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                        child: Text('${feedbackList[index]['target']}'),
                      ),
                      Text('${feedbackList[index]['content']}'),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                color: Colors.grey[300],
              );
      }),
    );
  }
}
