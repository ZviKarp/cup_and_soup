import 'package:flutter/material.dart';

import 'package:cup_and_soup/services/cloudFunctions.dart';
import 'package:cup_and_soup/widgets/core/dateTimePicker.dart';
import 'package:cup_and_soup/widgets/core/dialog.dart';
import 'package:cup_and_soup/widgets/core/divider.dart';
import 'package:cup_and_soup/widgets/core/button.dart';

class ComposeMessageDialog extends StatefulWidget {

  @override
  _ComposeMessageDialogState createState() => _ComposeMessageDialogState();
}

class _ComposeMessageDialogState extends State<ComposeMessageDialog> {
  TextEditingController _titleCtr = TextEditingController();
  TextEditingController _msgCtr = TextEditingController();
  DateTime _dateTime;

  void onSend() {
    String errorMsg = "no error";
    if (_titleCtr.text == "")       errorMsg = "the title can't be empty";
    else if (_msgCtr.text == "") errorMsg = "the message can't be empty";
    cloudFunctionsService.sendMessage(_titleCtr.text, _msgCtr.text, _dateTime, "all users");
  }

  Widget _actionSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ButtonWidget(
          text: "cancel",
          onPressed: () {
            Navigator.pop(context);
          },
          primary: false,
          size: "small",
        ),
        ButtonWidget(
          text: "send",
          onPressed: () {
            Navigator.pop(context);
          },
          size: "small",
        ),
      ],
    );
  }

  TableRow _titleRow() {
    return TableRow(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text("Title:"),
      ),
      TextField(
        controller: _titleCtr,
        style: TextStyle(
          fontFamily: "PrimaryFont",
          fontSize: 18,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: "Your awesome name",
        ),
      ),
    ]);
  }

  TableRow _messageRow() {
    return TableRow(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text("Message:"),
      ),
      TextField(
        controller: _msgCtr,
        style: TextStyle(
          fontFamily: "PrimaryFont",
          fontSize: 18,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          hintText: "Your awesome name",
        ),
      ),
    ]);
  }

  TableRow _sendAtRow() {
    return TableRow(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text("Send At:"),
      ),
      DateTimePicker(
        initDateTime: DateTime.now(),
        onDateTimeChange: (a) {
          print(a);
        },
      ),
    ]);
  }

  TableRow _sendToRow() {
    return TableRow(children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text("Send To:"),
      ),
      Text("All users"),
    ]);
  }

  Widget _content(context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {0: FractionColumnWidth(.3)},
      children: <TableRow>[
        _titleRow(),
        _messageRow(),
        _sendAtRow(),
        _sendToRow(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "More Options",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "PrimaryFont",
                fontSize: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _content(context),
          ),
          DividerWidget(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _actionSection(context),
          ),
        ],
      ),
    );
  }
}