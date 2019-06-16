import 'package:cup_and_soup/models/user.dart';
import 'package:cup_and_soup/pages/home.dart';
import 'package:cup_and_soup/utils/localizations.dart';
import 'package:flutter/material.dart';

import 'package:cup_and_soup/services/cloudFirestore.dart';
import 'package:cup_and_soup/widgets/core/page.dart';
import 'package:cup_and_soup/widgets/core/divider.dart';
import 'package:cup_and_soup/widgets/account/activity.dart';
import 'package:cup_and_soup/widgets/account/balance.dart';
import 'package:cup_and_soup/widgets/account/settings.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  User _user;
  bool _upToDate = true;

  void _getData() async {
    cloudFirestoreService.streamUserData().listen((User user) {
      if (!mounted) return;
      setState(() => _user = user);
    });
  }

  void _checkUpToDate() async {
    bool upToDate = await HomePage.newVersion();
    if (!mounted) return;
    setState(() => _upToDate = upToDate);
  }

  @override
  void initState() {
    super.initState();
    _getData();
    _checkUpToDate();
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      title: translate.text("acc:p-t"),
      child: AnimatedOpacity(
        opacity: (_user != null) ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: _user != null
            ? Column(children: <Widget>[
                BalanceWidget(
                  user: _user,
                ),
                DividerWidget(),
                ActivityWidget(),
                DividerWidget(),
                SettingsWidget(
                  user: _user,
                ),
                DividerWidget(),
                Text(
                  "cup&soup (c) 2019 Zvi Karp | version " +
                      HomePage.getVersion(),
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 36),
                  child: Text(
                    !_upToDate ? translate.text("acc:p-newVersion") : "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ])
            : Container(),
      ),
    );
  }
}
