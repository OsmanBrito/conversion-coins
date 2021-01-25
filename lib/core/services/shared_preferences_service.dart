import 'dart:convert';

import 'package:coin_conversion/core/models/currencies.dart';
import 'package:coin_conversion/core/models/quotes.dart';
import 'package:coin_conversion/core/utils/strings.dart';
import 'package:coin_conversion/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesServices {
  static List<Currencies> getCurrencies(String key) {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    String currenciesString = (sharedPreferences.getString(key));
    if (currenciesString.isEmpty) {
      throw 'Ops, ocorreu um erro, tente novamente mais tarde.';
    }
    var currencies = <Currencies>[];
    json
        .decode(currenciesString)
        .toList()
        .forEach((c) => currencies.add(Currencies(c['initials'], c['name'])));
    return currencies;
  }

  static List<Quotes> getQuotes(String key) {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    String quotesString = sharedPreferences.getString(key);
    if (quotesString.isEmpty) {
      throw 'Ops, ocorreu um erro, tente novamente mais tarde.';
    }
    var quotes = <Quotes>[];
    json
        .decode(quotesString)
        .toList()
        .forEach((q) => quotes.add(Quotes(q['initials'], q['value'])));
    return quotes;
  }

  static String getTimestamp() {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    return sharedPreferences.getString(sharedTimestamp);
  }

  static Future<void> saveCurrencies(List<Currencies> currencies) async {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    sharedPreferences.setString(sharedCurrencies, json.encode(currencies));
  }

  static Future<void> saveQuotes(List<Quotes> quotes, num timestamp) async {
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    sharedPreferences.setInt(sharedTimestamp, timestamp);
    sharedPreferences.setString(sharedQuotes, json.encode(quotes));
  }
}
