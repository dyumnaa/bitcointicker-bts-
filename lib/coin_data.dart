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

const apiKey = '32B2CA62-CAF3-4820-8B66-D3396F43276C';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';

class CoinData {
  Future<Map<String, String>> getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) { // Corrected line
      String requestURL = '$coinAPIURL/$crypto/$currency?apiKey=$apiKey';
      print('Request URL: $requestURL');
      http.Response response = await http.get(Uri.parse(requestURL));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        print('Last price fetched: $lastPrice');
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices; // Corrected return type
  }
}


