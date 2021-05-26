import 'package:flutter/material.dart';

closedKeyboard(BuildContext ctx) async {
  await FocusScope.of(ctx).requestFocus(new FocusNode());
}
