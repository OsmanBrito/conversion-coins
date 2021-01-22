import 'package:coin_conversion/core/viewmodels/conversion_model.dart';
import 'package:coin_conversion/core/viewmodels/list_currencies_model.dart';
import 'package:get_it/get_it.dart';

import 'core/services/api.dart';

GetIt sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton(() => Api());

  sl.registerFactory(() => ListCurrenciesModel());
  sl.registerFactory(() => ConversionModel());
}