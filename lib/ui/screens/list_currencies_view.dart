import 'package:coin_conversion/core/enums/viewstate.dart';
import 'package:coin_conversion/core/models/currencies.dart';
import 'package:coin_conversion/core/utils/size_config.dart';
import 'package:coin_conversion/core/viewmodels/list_currencies_model.dart';
import 'package:coin_conversion/ui/screens/base_view.dart';
import 'package:coin_conversion/ui/screens/failure_view.dart';
import 'package:coins_flags/coins_flags_widget.dart';
import 'package:flutter/material.dart';

class ListCurrenciesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseView<ListCurrenciesModel>(
      modelIsReady: (model) => model.fetchCurrencies(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Moedas'),
        ),
        backgroundColor: Colors.lightBlue,
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : model.state == ViewState.Idle ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                margin: EdgeInsets.all(SizeConfig.sizeByPixel(15)),
                padding: EdgeInsets.all(SizeConfig.sizeByPixel(15)),
                child: fetchCurrenciesUi(model.currencies)) : FailureView(),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    currencies[index].initials,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(currencies[index].name),
                ],
              )
            ],
          ));
}
