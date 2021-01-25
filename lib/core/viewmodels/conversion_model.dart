import 'package:coin_conversion/core/enums/viewstate.dart';
import 'package:coin_conversion/core/models/quotes.dart';
import 'package:coin_conversion/core/services/api_service.dart';
import 'package:coin_conversion/core/viewmodels/base_model.dart';
import 'package:coin_conversion/locator.dart';

class ConversionModel extends BaseModel {
  ApiService _api = sl<ApiService>();

  List<Quotes> liveQuotes;
  String conversionResult;
  String timestamp = "";
  String targetCurrencyFieldValue = 'USD';
  String desiredCurrencyFieldValue = 'EUR';

  Future fetchLiveQuotes() async {
    try{
      setState(ViewState.Busy);
      liveQuotes = await _api.liveQuotes();
      conversionResult = liveQuotes
          .firstWhere((element) => element.initials.contains('EUR'))
          .value
          .toStringAsFixed(2);
      timestamp = _api.getTimestamp();
      setState(ViewState.Idle);
    } catch(_){
      setState(ViewState.Failure);
    }
  }

  changeValue(String dropDownValue, bool isFirstField, String inputValue) {
    if (isFirstField) {
      targetCurrencyFieldValue = dropDownValue;
    } else {
      desiredCurrencyFieldValue = dropDownValue;
    }
    updateConversion(inputValue);
    notifyListeners();
  }

  updateConversion(String inputValue) {
    Quotes quote;
    if (!targetCurrencyFieldValue.contains('USD')) {
      quote = liveQuotes.firstWhere((element) =>
          element.initials.contains('USD$targetCurrencyFieldValue'));
      num currencyToDollar = num.parse(inputValue) / quote.value;
      quote = liveQuotes.firstWhere((element) =>
          element.initials.contains('USD$desiredCurrencyFieldValue'));
      conversionResult = (currencyToDollar * quote.value).toStringAsFixed(2);
    } else {
      quote = liveQuotes.firstWhere((element) => element.initials
          .contains('$targetCurrencyFieldValue$desiredCurrencyFieldValue'));
      conversionResult = (num.parse(inputValue) * quote.value).toStringAsFixed(2);
    }
    notifyListeners();
  }

  changeChoices(String inputValue) {
    var aux = targetCurrencyFieldValue;
    targetCurrencyFieldValue = desiredCurrencyFieldValue;
    desiredCurrencyFieldValue = aux;
    updateConversion(inputValue);
  }
}
