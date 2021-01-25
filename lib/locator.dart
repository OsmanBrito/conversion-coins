import 'package:coin_conversion/core/viewmodels/conversion_model.dart';
import 'package:coin_conversion/core/viewmodels/list_currencies_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/api_service.dart';

GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton(() => ApiService());
  sl.registerFactory(() => ListCurrenciesModel());
  sl.registerFactory(() => ConversionModel());
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
