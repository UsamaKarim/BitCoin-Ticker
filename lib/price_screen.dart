import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String coin = 'BTC';
  String currency = 'USD';
  String rates = '12345';
//initialization of Currency to show in DropDownMenuList
  String selectedCurreny = 'USD';
  //Initializing a String to put in URL selected by person
  String selectedByPerson;

  @override
  void initState() {
    super.initState();
    updateUI(selectedCurreny);
  }

  //Android DropdownMenuItem List
  DropdownButton<String> dropDownMenuItemList() {
    List<DropdownMenuItem<String>> dropDownMenuList = [];
    for (String currency in currenciesList) {
      dropDownMenuList.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }
    return DropdownButton<String>(
      value: selectedCurreny,
      items: dropDownMenuList,
      onChanged: (value) {
        setState(() {
          selectedCurreny = value;
        });
        updateUI(selectedCurreny);
        return selectedCurreny;
      },
    );
  }

//iOS CupertinoPicker List
  NotificationListener cupertinoPickerList() {
    List<Text> textWidgetList = [];
    for (String curreny in currenciesList) {
      textWidgetList.add(
        Text(
          curreny,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          //Will only update when user has stopped scrolling in picker.

          return true;
        } else {
          return false;
        }
      },
      child: CupertinoPicker(
        itemExtent: 30,
        scrollController: FixedExtentScrollController(initialItem: 19),
        onSelectedItemChanged: (selectedIndex) {
          selectedCurreny = currenciesList[selectedIndex];
          updateUI(selectedCurreny);
          print(selectedCurreny);
        },
        children: textWidgetList,
      ),
    );
  }

  Future updateUI(String selectACurrency) async {
    try {
      var coinAPIData = await CoinData().coinAPI(selectedCurreny);
      setState(() {
        coin = coinAPIData['asset_id_base'];
        currency = coinAPIData['asset_id_quote'];
        rates = coinAPIData['rate'].toStringAsFixed(2);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(coin: coin, rates: rates, currency: currency),
              CryptoCard(coin: coin, rates: rates, currency: currency),
              CryptoCard(coin: coin, rates: rates, currency: currency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: cupertinoPickerList(),
          ),
        ],
      ),
    );
  }
}
