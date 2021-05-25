import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:pencilwith/models/getxcontroller.dart';

//This could be StatelessWidget but it won't work on Dialogs for now until this issue is fixed: https://github.com/flutter/flutter/issues/45839
class Content extends StatefulWidget {
  final bool isDialog;

  const Content({Key key, this.isDialog = false}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final FocusNode _nodeText2 = FocusNode();
  TextEditingController _textEditingController = TextEditingController();
  Controller getc = Get.put(Controller());

  String codeDialog;
  String valueText;

  List<String> chapterList = [
    '무지개',
    '그때그날',
    '사건',
    '무지개',
    '어머니',
    '아버지',
  ];

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
            onTapAction: () {},
            displayActionBar: false,
            focusNode: _nodeText2,
            footerBuilder: (_) => PreferredSize(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Obx(() =>
                        Text('위치 : ${getc.textIndex}/${getc.maxTextCount}')),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios_sharp),
                        onPressed: () => _textEditingController.selection =
                            int.parse(getc.textIndex.value.toString()) == 0
                                ? TextSelection.collapsed(offset: 0)
                                : TextSelection.collapsed(
                                    offset: int.parse(
                                            getc.textIndex.value.toString()) -
                                        1)),
                    IconButton(
                        icon: Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () => _textEditingController.selection = int
                                    .parse(getc.textIndex.value.toString()) ==
                                int.parse(getc.maxTextCount.value.toString())
                            ? TextSelection.collapsed(offset: 0)
                            : TextSelection.collapsed(
                                offset:
                                    int.parse(getc.textIndex.value.toString()) +
                                        1)),
                    // IconButton(
                    //     icon: Icon(Icons.add),
                    //     onPressed: () async {
                    //       var selection = _textEditingController.selection;
                    //       createAlertDialog(context).then((value) {
                    //         _prefixTextSelection('\n[$value]\n', selection);
                    //       });
                    //     }),
                    Spacer(),
                    GestureDetector(
                      child: Row(
                        children: [
                          Text('챕터'),
                          Icon(Icons.expand_more),
                        ],
                      ),
                      onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0))),
                            backgroundColor: Colors.white,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom -
                                                  50),
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                  onTap: () {},
                                                  dense: true,
                                                  title: Text(
                                                      '${index + 1}.${chapterList[index]}',
                                                      style: TextStyle(
                                                          fontSize: 15)));
                                            },
                                            itemCount: chapterList.length,
                                          ),
                                        ),
                                        height: 500,
                                      ),
                                      //편법용
                                      TextField(
                                        decoration:
                                            InputDecoration(hintText: ''),
                                        autofocus: true,
                                      ),
                                      //SizedBox(height: 10),
                                    ],
                                  ),
                                ));
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                preferredSize: Size.fromHeight(50.0))),
      ],
    );
  }

  @override
  void initState() {
    _textEditingController.addListener(() {
      Get.find<Controller>().maxTextCount(_textEditingController.text.length);
      Get.find<Controller>().textIndex.value =
          int.parse(_textEditingController.selection.base.offset.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      isDialog: widget.isDialog,
      config: _buildConfig(context),
      child: Container(
        child: TextField(
          maxLines: null,
          style:
              TextStyle(fontSize: (MediaQuery.of(context).size.width * 0.045)),
          keyboardType: TextInputType.multiline,
          focusNode: _nodeText2,
          controller: _textEditingController,
          decoration: InputDecoration.collapsed(
              hintText: "소설을 집필해보세요",
              border: InputBorder.none,
              hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.4),
                  fontWeight: FontWeight.normal)),
        ),
      ),
    );
  }

  void _prefixTextSelection(String left, TextSelection selection) {
    final currentTextValue = _textEditingController.value.text;
    final middle = selection.textInside(currentTextValue);
    final newTextValue = selection.textBefore(currentTextValue) +
        '$left$middle' +
        selection.textAfter(currentTextValue);
    _textEditingController.value = _textEditingController.value.copyWith(
      text: newTextValue,
      selection: TextSelection.collapsed(
        offset: selection.baseOffset + left.length + middle.length,
      ),
    );
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController _textEditingModalController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('chater1'),
            content: TextField(
              controller: _textEditingModalController,
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(_textEditingModalController.text.toString());
                },
                child: Text('submit'),
              )
            ],
          );
        });
  }
}
