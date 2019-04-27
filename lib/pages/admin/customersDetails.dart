import 'package:cup_and_soup/dialogs/customersDetails.dart';
import 'package:cup_and_soup/utils/transparentRoute.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cup_and_soup/widgets/core/page.dart';
import 'package:cup_and_soup/widgets/core/table.dart';
import 'package:cup_and_soup/widgets/core/button.dart';

class CustomersDetailsPage extends StatefulWidget {
  @override
  _CustomersDetailsPageState createState() => _CustomersDetailsPageState();
}

class _CustomersDetailsPageState extends State<CustomersDetailsPage> {
  List<List<Widget>> _docsToItem(dynamic snapshot) {
    List<List<Widget>> items = [];

    snapshot.forEach((doc) {
      items.add([
        Container(
          alignment: Alignment(-1, 0),
          child: _roleIcon(doc['role']),
        ),
        Text(doc['name'].toString()),
        Text(doc['money'].toString()),
        _more(doc.documentID.toString()),
      ]);
    });

    return items;
  }


  void _onMorePressed(String uid) {
    Navigator.of(context).push(
      TransparentRoute(
        builder: (BuildContext context) => CustomersDetailsDialog(uid: uid),
      ),
    );
  }

  Widget _more(String uid) {
    return GestureDetector(
      onTap: () => _onMorePressed(uid),
          child: Icon(
        Icons.navigate_next,
        size: 16,
      ),
    );
  }
 
  Widget _roleIcon(String role) {
    if (role == "customer") {
      return Icon(
        Icons.supervisor_account,
        size: 16,
      );
    } else if (role == "admin") {
      return Icon(
        Icons.security,
        size: 16,
      );
    } else {
      return Icon(
        Icons.error,
        size: 16,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWidget(
        title: "customers-details",
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: StreamBuilder(
                  stream:
                      Firestore.instance.collection('users').snapshots(),
                  builder: (context, snapshot) {
                    int length = 0;
                    if (!snapshot.hasData || snapshot.data.documents == null)
                      return Text("Loading...");
                    length = snapshot.data.documents.length;
                    if (length == 0) {
                      return Text(
                        "Hey! it looks like there is nothing to see here.",
                        textAlign: TextAlign.center,
                      );
                    }
                    return TableWidget(
                      headings: [" ", " ", " ", " "],
                      items: _docsToItem(snapshot.data.documents),
                      flex: [1, 3, 2, 1],
                    );
                  }),
            ),
            ButtonWidget(
              text: "back",
              onPressed: () {
                Navigator.pop(context);
              },
              primary: false,
              size: "small",
            ),
          ],
        ),
      ),
    );
  }
}