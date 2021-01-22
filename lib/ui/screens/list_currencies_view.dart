import 'package:coin_conversion/core/enums/viewstate.dart';
import 'package:coin_conversion/core/models/currencies.dart';
import 'package:coin_conversion/core/viewmodels/list_currencies_model.dart';
import 'package:coin_conversion/ui/screens/base_view.dart';
import 'package:coins_flags/coins_flags_widget.dart';
import 'package:flutter/material.dart';

class ListCurrenciesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ListCurrenciesModel>(
      modelIsReady: (model) => model.fetchCurrencies(),
      builder: (context, model, child) => Scaffold(
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Container(
                margin: EdgeInsets.all(15.0),
                child: fetchCurrenciesUi(model.currencies)),
      ),
    );
  }

  Widget fetchCurrenciesUi(List<Currencies> currencies) => ListView.builder(
      itemCount: currencies.length,
      itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CoinsFlagsWidget(
                currencyInitials: currencies[index].initials,
              ),
              Text(currencies[index].initials),
              Text(currencies[index].name)
            ],
          ));
}
