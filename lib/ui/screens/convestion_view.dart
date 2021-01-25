import 'package:coin_conversion/core/enums/viewstate.dart';
import 'package:coin_conversion/core/utils/size_config.dart';
import 'package:coin_conversion/core/viewmodels/conversion_model.dart';
import 'package:coin_conversion/ui/screens/base_view.dart';
import 'package:coin_conversion/ui/screens/list_currencies_view.dart';
import 'package:coins_flags/coins_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ConversionView extends StatelessWidget {
  final TextEditingController controller = TextEditingController(
    text: '1',
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BaseView<ConversionModel>(
      modelIsReady: (model) => model.fetchLiveQuotes(),
      builder: (context, model, child) => Scaffold(
        body: Scaffold(
          backgroundColor: Colors.lightBlue,
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : model.state == ViewState.Idle
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white),
                      margin: EdgeInsets.only(
                          left: SizeConfig.sizeByPixel(15),
                          right: SizeConfig.sizeByPixel(15),
                          top: SizeConfig.sizeByPixel(50),
                          bottom: SizeConfig.sizeByPixel(15)),
                      child: _buildConversionContent(model, context))
                  : Center(child: Text("Erro!")),
        ),
      ),
    );
  }

  Widget _buildConversionContent(ConversionModel model, BuildContext context) {
    List<String> initials =
        model.liveQuotes.map((e) => e.initials.substring(3, 6)).toList();
    return Form(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.sizeByPixel(35),
                bottom: SizeConfig.sizeByPixel(15)),
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                color: Colors.yellow,
                child: Text(
                  'Vizualizar moedas',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListCurrenciesView()))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  _buildSearchCurrency(initials, model, true),
                  _buildSearchCurrency(initials, model, false),
                ],
              ),
              IconButton(
                  icon: Icon(Icons.wifi_protected_setup),
                  onPressed: () => model.changeChoices(
                      controller.text.isEmpty ? '1' : controller.text)),
            ],
          ),
          Container(
              margin: EdgeInsets.all(SizeConfig.sizeByPixel(20)),
              child: Text("Quantidade para conversão")),
          Container(
            margin: EdgeInsets.only(bottom: SizeConfig.sizeByPixel(15)),
            width: SizeConfig.sizeByPixel(160),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              focusNode: FocusNode(),
              textAlign: TextAlign.center,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (value) {
                if (value.isNotEmpty && num.parse(value) > 0) {
                  model.updateConversion(controller.text);
                } else {
                  model.updateConversion('1');
                }
              },
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Resultado da conversão"),
              Text(
                model.conversionResult,
                style: TextStyle(fontSize: SizeConfig.sizeByPixel(60)),
              ),
              Expanded(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: SizeConfig.sizeByPixel(5)),
                      child: Text('Base atualizada: ${model.timestamp}'),
                    )),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _buildSearchCurrency(
      List<String> initials, ConversionModel model, bool isTarget) {
    return Container(
      child: SearchableDropdown.single(
        items: initials.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                CoinsFlagsWidget(currencyInitials: value),
                Text(value),
              ],
            ),
          );
        }).toList(),
        value: isTarget
            ? model.targetCurrencyFieldValue
            : model.desiredCurrencyFieldValue,
        searchHint: "Moeda desejada",
        onChanged: (String value) {
          model.changeValue(value, isTarget, controller.text);
        },
        displayClearIcon: false,
      ),
    );
  }
}
