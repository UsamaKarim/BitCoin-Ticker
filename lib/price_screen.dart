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
//initialization of Currency to show in DropDownMenuList
  String _selectedCurrency = 'USD';
  //Initializing a String to put in URL selected by person
  String selectedByPerson;
  // String _selector = '';
  FixedExtentScrollController _controller =
      FixedExtentScrollController(initialItem: 19);

  @override
  void initState() {
    super.initState();
    updateUI();
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
      value: _selectedCurrency,
      items: dropDownMenuList,
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value;
        });
        updateUI();
        return _selectedCurrency;
      },
    );
  }

//iOS CupertinoPicker List
  CupertinoPicker cupertinoPickerList() {
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
    return
        //  NotificationListener<ScrollNotification>(
        //   onNotification: (scrollNotification) {
        //     if (scrollNotification is ScrollEndNotification) {
        //       // print(currenciesList[_controller.selectedItem]);
        //       setState(() {
        //         _selectedCurrency = currenciesList[_controller.selectedItem];
        //       });
        //       return true;
        //     } else {
        //       return false;
        //     }
        //   },
        // child:
        CupertinoPicker(
      itemExtent: 30,
      scrollController: _controller,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          _selectedCurrency = currenciesList[selectedIndex];
          updateUI();
        });

        print(_selectedCurrency);
      },
      children: textWidgetList,
    );
  }

  Map<String, String> coinValues = {};

  Future updateUI() async {
    try {
      var coinAPIData = await CoinData().coinAPI(_selectedCurrency);
      setState(() {
        coinValues = coinAPIData;
      });
    } catch (e) {
      print(e);
    }
  }

  Column makeCards() {
    List<Widget> cardList = [];
    for (String coinList in cryptoList) {
      cardList.add(
        CryptoCard(
          coin: coinList,
          rates: coinValues[coinList],
          currency: _selectedCurrency,
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cardList,
    );
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
          makeCards(),
          // [
          //   CryptoCard(
          //       coin: 'BTC',
          //       rates: coinValues['BTC'],
          //       currency: _selectedCurrency),
          //   CryptoCard(
          //       coin: 'ETH',
          //       rates: coinValues['ETH'],
          //       currency: _selectedCurrency),
          //   CryptoCard(
          //       coin: 'LTC',
          //       rates: coinValues['LTC'],
          //       currency: _selectedCurrency),
          // ],

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
