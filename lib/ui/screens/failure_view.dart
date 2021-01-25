import 'package:coin_conversion/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class FailureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          height: SizeConfig.sizeByPixel(150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mood_bad,
                size: 100,
              ),
              Text('Ops, ocorreu um erro. Tente novamente mais tarde!.')
            ],
          ),
        ),
      ),
    );
  }
}
