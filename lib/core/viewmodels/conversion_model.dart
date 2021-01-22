import 'package:coin_conversion/core/enums/viewstate.dart';
import 'package:coin_conversion/core/models/quotes.dart';
import 'package:coin_conversion/core/services/api.dart';
import 'package:coin_conversion/core/viewmodels/base_model.dart';
import 'package:coin_conversion/locator.dart';

class ConversionModel extends BaseModel {
  Api _api = sl<Api>();

  List<Quotes> liveQuotes;
  String conversionResult;
  String firstFieldValue = 'USD';
  String secondFieldValue = 'EUR';

  Future fetchLiveQuotes() async {
    setState(ViewState.Busy);
    liveQuotes = await _api.liveQuotes();
    conversionResult = liveQuotes
        .firstWhere((element) => element.initial.contains('EUR'))
        .value
        .toString();
    setState(ViewState.Idle);
  }

  changeValue(String dropDownValue, bool isFirstField,
      String inputValue) {
    if (isFirstField) {
      firstFieldValue = dropDownValue;
    } else {
      secondFieldValue = dropDownValue;
    }
    updateConversion(inputValue);
    notifyListeners();
  }

  updateConversion(String inputValue) {
    Quotes quote;
    if (!firstFieldValue.contains('USD')) {
      quote = liveQuotes.firstWhere(
          (element) => element.initial.contains('USD$firstFieldValue'));
      num currencyToDollar = num.parse(inputValue) / quote.value;
      quote = liveQuotes.firstWhere(
          (element) => element.initial.contains('USD$secondFieldValue'));
      conversionResult = (currencyToDollar * quote.value).toString();
    } else {
      quote = liveQuotes.firstWhere((element) =>
          element.initial.contains('$firstFieldValue$secondFieldValue'));
      conversionResult = (num.parse(inputValue) * quote.value).toString();
    }
    notifyListeners();
  }
}
