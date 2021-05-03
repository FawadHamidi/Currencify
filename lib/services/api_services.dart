import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<String>> getCurrencies() async {
    final Uri currencyUrl = Uri.https("free.currconv.com", "/api/v7/currencies",
        {"apiKey": "50c8c5220ebb2bf130b8"});
    http.Response res = await http.get(currencyUrl);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var list = body["results"];
      List<String> currencies = (list.keys).toList();
      print(currencies);
      return currencies;
    } else {
      throw Exception("failed to connect to API");
    }
  }

  Future<double> getRate(String from, String to) async {
    final Uri rateUrl = Uri.https(
      "free.currconv.com",
      "/api/v7/convert",
      {
        "apiKey": "50c8c5220ebb2bf130b8",
        "q": "${from}_${to}",
        "compact": "ultra"
      },
    );
    http.Response response = await http.get(rateUrl);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return body["${from}_${to}"];
    } else {
      throw Exception("failed to connect to API");
    }
  }
}
