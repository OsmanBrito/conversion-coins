import 'package:coin_conversion/core/models/currencies.dart';
import 'package:coin_conversion/core/models/quotes.dart';
import 'package:coin_conversion/core/services/shared_preferences_service.dart';
import 'package:coin_conversion/core/utils/strings.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ApiService {
  static const key = 'access_key=1ac51fd9c35dac254eeb04dc93712ed8&format=1';
  static const api = 'http://api.currencylayer.com/';

  var _dio = Dio();

  num _timestamp;

  Future<List<Currencies>> listCurrencies() async {
    try {
      Response response = await _dio.get("$api/list?$key");
      var currencies = <Currencies>[];
      if (response.statusCode == 200) {
        response.data['currencies']
            .forEach((k, v) => currencies.add(Currencies(k, v)));
        SharedPreferencesServices.saveCurrencies(currencies);
        return currencies;
      } else {
        return SharedPreferencesServices.getCurrencies(sharedCurrencies);
      }
    } on DioError catch (_) {
      return SharedPreferencesServices.getCurrencies(sharedCurrencies);
    }
  }

  Future<List<Quotes>> liveQuotes() async {
    try {
      Response response = await _dio.get("$api/live?$key");
      var quotes = <Quotes>[];
      if (response.statusCode == 200) {
        response.data['quotes'].forEach((k, v) => quotes.add(Quotes(k, v)));
        _timestamp = response.data['timestamp'];
        SharedPreferencesServices.saveQuotes(quotes, _timestamp);
        return quotes;
      } else {
        _timestamp = num.parse(SharedPreferencesServices.getTimestamp());
        return SharedPreferencesServices.getQuotes(sharedQuotes);
      }
    } on Exception catch (_) {
      _timestamp = num.parse(SharedPreferencesServices.getTimestamp());
      return SharedPreferencesServices.getQuotes(sharedQuotes);
    }
  }

  String getTimestamp() {
    var date = DateTime.fromMillisecondsSinceEpoch(_timestamp * 1000);
    return DateFormat('yyyy.MM.dd hh:mm aaa').format(date);
  }
}
