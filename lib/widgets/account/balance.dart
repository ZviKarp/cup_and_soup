import 'package:flutter/material.dart';

import 'package:cup_and_soup/widgets/core/center.dart';

class BalanceWidget extends StatefulWidget {
  BalanceWidget({
    @required this.uid,
    @required this.userData,
  });

  final String uid;
  final Map<String, dynamic> userData;

  @override
  _BalanceWidgetState createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Balance",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.title,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: CenterWidget(
            child: Center(
              child: Text(
                widget.userData["money"].toString() ?? "...",
                style: Theme.of(context).textTheme.display1.merge(
                      TextStyle(color: Theme.of(context).primaryColor),
                    ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Text(
            "You have up to " +
                widget.userData["allowdCredit"].toString() +
                " NIS in credit, ask a admin to give you more.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      ],
    );
  }
}
