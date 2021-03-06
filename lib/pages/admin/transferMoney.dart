import 'package:flutter/material.dart';

import 'package:cup_and_soup/services/cloudFirestore.dart';
import 'package:cup_and_soup/widgets/core/page.dart';
import 'package:cup_and_soup/widgets/admin/trasferMoney/amountInput.dart';
import 'package:cup_and_soup/widgets/admin/barcodeGenerator.dart';

class TransferMoneyPage extends StatefulWidget {
  @override
  _TransferMoneyPageState createState() => _TransferMoneyPageState();
}

class _TransferMoneyPageState extends State<TransferMoneyPage> {
  int _step = 1;
  double _amount = 0.0;
  String _barcode = "";

  void _amountSubmited(String amount, DateTime dateTime, bool userLimit, int scans) async {
    String barcode = await cloudFirestoreService.uploadMoneyBarcode(double.parse(amount), dateTime, userLimit, scans);
    setState(() {
      _step = 2;
      _amount = double.parse(amount);
      _barcode = barcode;
    });
  }

  void _stepBack() {
    setState(() {
      _step = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageWidget(
        title: "trasfer-money",
        child: _step == 1
            ? AmountInputWidget(onAmountSubmit: _amountSubmited)
            : BarcodeGeneratorWidget(
              amount: _amount,
              barcode: _barcode,
              backPressed: _stepBack
            ),
      ),
    );
  }
}
