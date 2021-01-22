import 'package:coin_conversion/core/enums/viewstate.dart';
import 'package:coin_conversion/core/viewmodels/conversion_model.dart';
import 'package:coin_conversion/ui/screens/base_view.dart';
import 'package:coins_flags/coins_flags_widget.dart';
import 'package:flutter/material.dart';

class ConversionView extends StatelessWidget {
  final TextEditingController controller = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return BaseView<ConversionModel>(
      modelIsReady: (model) => model.fetchLiveQuotes(),
      builder: (context, model, child) => Scaffold(
        body: Scaffold(
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Container(
                  margin: EdgeInsets.all(15.0),
                  child: _buildConversionContent(model)),
        ),
      ),
    );
  }

  Widget _buildConversionContent(ConversionModel model) {
    List<String> initials =
        model.liveQuotes.map((e) => e.initial.substring(3, 6)).toList();
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: model.firstFieldValue,
                items: initials.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  model.changeValue(value, true, controller.text);
                },
              ),
              DropdownButton<String>(
                value: model.secondFieldValue,
                items: initials.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  model.changeValue(value, false, controller.text);
                },
              )
            ],
          ),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (value.isNotEmpty && num.parse(value) > 0) {
                model.updateConversion(controller.text);
              } else {
                model.updateConversion('1');
              }
            },
          ),
          Expanded(
              child: Center(
                  child: Text(
            model.conversionResult,
            style: TextStyle(fontSize: 50),
          )))
        ],
      ),
    );
  }
}
