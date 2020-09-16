import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = 'B386BF07-13E0-42BA-8900-874B024B2ED9';
const apiKey2 = '76E5FE3D-B712-499E-8149-594480F32648';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> coinAPI(String selectACurrency) async {
    for (String coinList in cryptoList) {}
    http.Response response = await http.get(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$selectACurrency?apikey=$apiKey');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      throw 'Your reached max API Calls for today';
    }
  }
}
