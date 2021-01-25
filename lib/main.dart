import 'package:coin_conversion/locator.dart';
import 'package:coin_conversion/ui/screens/convestion_view.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(MyApp());
  await setupLocator();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConversionView(),
    );
  }
}
