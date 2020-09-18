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
  Future<dynamic> coinAPI(String selectedCurrencyByUser) async {
    Map<String, String> coinListMap = {};
    for (String coinList in cryptoList) {
      http.Response response = await http.get(
          'https://rest.coinapi.io/v1/exchangerate/$coinList/$selectedCurrencyByUser?apikey=$apiKey2');
      if (response.statusCode == 200) {
        // coin = decodedData['asset_id_base'];
        // currency = decodedData['asset_id_quote'];
        double rates = jsonDecode(response.body)['rate'];
        coinListMap[coinList] = rates.toStringAsFixed(2);
      } else {
        print(response.statusCode);
        throw 'Your reached limit of max API Calls for today';
      }
    }
    return coinListMap;
  }
}
