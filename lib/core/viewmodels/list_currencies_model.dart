import 'package:coin_conversion/core/enums/viewstate.dart';
import 'package:coin_conversion/core/models/currencies.dart';
import 'package:coin_conversion/core/services/api_service.dart';
import 'package:coin_conversion/core/viewmodels/base_model.dart';
import 'package:coin_conversion/locator.dart';

class ListCurrenciesModel extends BaseModel {
  ApiService _api = sl<ApiService>();

  List<Currencies> currencies;

  Future fetchCurrencies() async {
    setState(ViewState.Busy);
    currencies = await _api.listCurrencies();
    setState(ViewState.Idle);
  }
}
