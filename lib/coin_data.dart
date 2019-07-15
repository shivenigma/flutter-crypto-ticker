import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Future getPrice(String fiat, String crypto) async {
    String currencyId = fiat.toUpperCase();
    String cryptoId = crypto.toUpperCase();
    final response = await http.get(
        'https://apiv2.bitcoinaverage.com/indices/global/ticker/$cryptoId$currencyId');
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      var res = jsonDecode(response.body);
      print(res);
      return res['last'];
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
