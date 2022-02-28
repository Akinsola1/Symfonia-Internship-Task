import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/crypto_price.dart';

class CryptoList {
  List<Crypto> _cryptoList = <Crypto>[];

  Future<List<Crypto>> fetchCrypto() async {
    List<Crypto> _postList = <Crypto>[];
    final response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"));

    if (response.statusCode == 200) {
      List<dynamic> values = <dynamic>[];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int index = 0; index < values.length; index++) {
          if (values[index] != null) {
            Map<String, dynamic> map = values[index];
            _postList.add(Crypto.fromJson(map));
          }
        }
        _cryptoList = _postList;
      }
      return _postList;
    } else {
      throw Exception('Failed to load crypto');
    }
  }
}
