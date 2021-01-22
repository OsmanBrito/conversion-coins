import 'dart:convert';

import 'package:coin_conversion/core/models/currencies.dart';
import 'package:coin_conversion/core/models/quotes.dart';
import 'package:dio/dio.dart';

class Api {
  static const key = 'access_key=1ac51fd9c35dac254eeb04dc93712ed8&format=1';
  static const api = 'http://api.currencylayer.com/';

  var _dio = Dio();

  Future<List<Currencies>> listCurrencies() async {
    try {
      Response response = await _dio.get("$api/list?$key");
      var currencies = <Currencies>[];
      if (response.statusCode == 200) {
        response.data['currencies']
            .forEach((k, v) => currencies.add(Currencies(k, v)));
        return currencies;
      } else {
        return [];
      }
    } on DioError catch (_) {
      throw 'Ops, ocorreu um erro';
    }
  }

  Future<List<Quotes>> liveQuotes() async {
    try {
      Response response = await _dio.get("$api/live?$key");
      var quotes = <Quotes>[];
      if (response.statusCode == 200) {
        response.data['quotes']
            .forEach((k, v) => quotes.add(Quotes(k, v)));
        return quotes;
      } else {
        return [];
      }
    } on Exception catch (_) {
      throw 'Ops, ocorreu um erro';
    }
  }
}
